Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8JyN5kwzzDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 15:06:04 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A53stm039848
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 01:06:01 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9qknke-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 01:06:01 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 02:05:59 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 98FD21DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 01:05:48 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A55vLr33948078
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:05:57 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A55ur0012818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:05:57 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
Date: Wed, 10 Aug 2016 02:05:53 -0300
In-Reply-To: <87r39xthnv.fsf@concordia.ellerman.id.au>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <3544655.o5QPxko4Ba@hactar> <87r39xthnv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <18857164.IzlezsQllh@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 10 August 2016, 13:41:08 schrieb Michael Ellerman:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
> >> On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> >> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes: 
> >> > > +/* Some details preceding the binary serialized measurement list
> >> > > */
> >> > > +struct ima_kexec_hdr {
> >> > > +	unsigned short version;
> >> > > +	unsigned long buffer_size;
> >> > > +	unsigned long count;
> >> > > +} __packed;
> >> > > +
> >> > 
> >> > Am I understanding it correctly that this structure is passed between
> >> > kernels?
> >> 
> >> Yes, the header prefixes the measurement list, which is being passed on
> >> the same computer to the next kernel.  Could the architecture (eg.
> >> LE/BE) change between soft re-boots?
> > 
> > Yes. I am able to boot a BE kernel from an LE kernel with my patches.
> > Whether we want to support that or not is another question...
> 
> Yes you must support that. BE -> LE and vice versa.

I didn't test BE - LE yet, but will do.

> You should also consider the possibility that the next kernel is not
> Linux.

If the next kernel is an ELF binary and it supports the kexec "calling 
convention", it should work too. What could possibly go wrong? I can try 
FreeBSD (I suppose it's an ELF kernel) and see what happens.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
