Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHf8Q5rvTzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 13:25:10 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7M3Nlnu094898
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 23:25:08 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24y4kupg8m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 23:25:07 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 22 Aug 2016 00:25:06 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id AE3001DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 23:24:53 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7M3P3c25210196
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 00:25:03 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7M3P1vP024484
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 00:25:02 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, x86@kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-ima-devel@lists.sourceforge.net,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/6] kexec_file: Allow skipping checksum calculation
 for some segments.
Date: Mon, 22 Aug 2016 00:25 -0300
In-Reply-To: <20160822031745.GA30489@dhcp-128-65.nay.redhat.com>
References: <1471058305-30198-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <105132489.pljZvDuEBr@hactar>
 <20160822031745.GA30489@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <3959832.c4ESAKX1ch@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 22 August 2016, 11:17:45 schrieb Dave Young:
> On 08/18/16 at 06:09pm, Thiago Jung Bauermann wrote:
> > Hello Dave,
> > 
> > Thanks for your review!
> > 
> > [ Trimming down Cc: list a little to try to clear the "too many
> > recipients"> 
> >   mailing list restriction. ]
> 
> I also got "too many recipients".. Thanks for the trimming.

Didn't work though. What is the maximum number of recipients?

> > Am Donnerstag, 18 August 2016, 17:03:30 schrieb Dave Young:
> > > On 08/13/16 at 12:18am, Thiago Jung Bauermann wrote:
> > > > Adds checksum argument to kexec_add_buffer specifying whether the
> > > > given
> > > > segment should be part of the checksum calculation.
> > > 
> > > Since it is used with add buffer, could it be added to kbuf as a new
> > > field?
> > 
> > I was on the fence about adding it as a new argument to kexec_add_buffer
> > or as a new field to struct kexec_buf. Both alternatives make sense to
> > me. I implemented your suggestion in the patch below, what do you
> > think?> 
> > > Like kbuf.no_checksum, default value is 0 that means checksum is
> > > needed
> > > if it is 1 then no need a checksum.
> > 
> > It's an interesting idea and I implemented it that way, though in
> > practice all current users of struct kexec_buf put it on the stack so
> > the field needs to be initialized explicitly.
> 
> No need to set it as false because it will be initialized to 0 by
> default?

As far as I know, variables on the stack are not initialized. Only global 
and static variables are.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
