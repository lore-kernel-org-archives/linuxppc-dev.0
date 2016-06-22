Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZWB82YfzzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 03:02:55 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MGsC4c064674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 13:02:53 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q1qp4ff4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 13:02:53 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 14:02:51 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 96B0F1DC0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 13:02:41 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MH2mq830540092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 14:02:48 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MH2mFe016336
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 14:02:48 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
Date: Wed, 22 Jun 2016 14:02:45 -0300
In-Reply-To: <20160622232946.793d6c04@350D>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622232946.793d6c04@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2895031.4C8tZ3BP2G@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Balbir,

Am Mittwoch, 22 Juni 2016, 23:29:46 schrieb Balbir Singh:
> On Tue, 21 Jun 2016 16:48:32 -0300
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
> > This patch series implements the kexec_file_load system call on
> > PowerPC.
> > 
> > This system call moves the reading of the kernel, initrd and the
> > device tree from the userspace kexec tool to the kernel. This is
> > needed if you want to do one or both of the following:
> > 
> > 1. only allow loading of signed kernels.
> > 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
> > 
> >    command line and other boot inputs for the Integrity Measurement
> >    Architecture subsystem.
> > 
> > The above are the functions kexec already has built into
> > kexec_file_load. Yesterday I posted a set of patches which allows a
> > third feature:
> > 
> > 3. have IMA pass-on its event log (where integrity measurements are
> > 
> >    registered) accross kexec to the second kernel, so that the event
> >    history is preserved.
> 
> OK.. and this is safe? Do both the kernels need to be signed by the
> same certificate?

They don't. The integrity of the event log (assuming that is what you mean 
by "this" in "this is safe") is guaranteed by the TPM device. Each event in 
the measurement list extends a PCR and records its PCR value. It is 
cryptographically guaranteed that if you replay the PCR extends recorded in 
the event log and in the end of the process they match the current PCR 
values in the TPM device, then that event log is correct.

The kernel signature serves to ensure that you only run kernels from an 
authorized provider. It doesn't play a role in integrity assurance, which 
aims to verify that the machine is really running the code it says it is 
running. As I understand it, at least. It's a bit subtle and I could be 
missing something...

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
