Return-Path: <zohar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8WMD4QxszDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:54:48 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7ACsQVH047250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:54:46 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9t5jjc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:54:46 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 22:54:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 472972CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:54:41 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7ACsf5Q27525352
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:54:41 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7ACse0P000920
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:54:41 +1000
Subject: Re: [PATCH 1/7] ima: on soft reboot, restore the measurement list
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, Dave Young <dyoung@redhat.com>
Date: Wed, 10 Aug 2016 08:54:36 -0400
In-Reply-To: <87vaz9rlx2.fsf@concordia.ellerman.id.au>
References: <1470313475-20090-1-git-send-email-zohar@linux.vnet.ibm.com>
 <3544655.o5QPxko4Ba@hactar> <87r39xthnv.fsf@concordia.ellerman.id.au>
 <18857164.IzlezsQllh@hactar> <87vaz9rlx2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1470833676.2881.183.camel@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-10 at 19:52 +1000, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> 
> > Am Mittwoch, 10 August 2016, 13:41:08 schrieb Michael Ellerman:
> >> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> >> > Am Dienstag, 09 August 2016, 09:01:13 schrieb Mimi Zohar:
> >> >> On Tue, 2016-08-09 at 20:59 +1000, Michael Ellerman wrote:
> >> >> > Mimi Zohar <zohar@linux.vnet.ibm.com> writes: 
> >> >> > > +/* Some details preceding the binary serialized measurement list
> >> >> > > */
> >> >> > > +struct ima_kexec_hdr {
> >> >> > > +	unsigned short version;
> >> >> > > +	unsigned long buffer_size;
> >> >> > > +	unsigned long count;
> >> >> > > +} __packed;
> >> >> > > +
> >> >> > 
> >> >> > Am I understanding it correctly that this structure is passed between
> >> >> > kernels?
> >> >> 
> >> >> Yes, the header prefixes the measurement list, which is being passed on
> >> >> the same computer to the next kernel.  Could the architecture (eg.
> >> >> LE/BE) change between soft re-boots?
> >> > 
> >> > Yes. I am able to boot a BE kernel from an LE kernel with my patches.
> >> > Whether we want to support that or not is another question...
> >> 
> >> Yes you must support that. BE -> LE and vice versa.
> >
> > I didn't test BE - LE yet, but will do.
> 
> Thanks.

Ok. There have been requests for making the binary_runtime_measurements
architecture independent.  As this was not a network facing interface,
we left it in native format.  With the kernel now consuming this data,
it makes sense for the binary_runtime_measurements to be in an
architecture independent format.

Unfortunately, as the <securityfs>/ima/binary_runtime_measurements is
not prefixed with any metadata, this change would need to be Kconfig
based, but kexec would always use the architecture independent format.

> >> You should also consider the possibility that the next kernel is not
> >> Linux.

Oh!

> > If the next kernel is an ELF binary and it supports the kexec "calling 
> > convention", it should work too. What could possibly go wrong? I can try 
> > FreeBSD (I suppose it's an ELF kernel) and see what happens.
> 
> At least for old style kexec (not sys_kexec_load()) I don't think it
> even needs to be an ELF binary.
> 
> I think there are folks working on FreeBSD (or $?BSD), so I think the
> basic kexec part works.
> 
> There's nothing (yet) that wants to use this measurement list obviously,
> but it should be designed such that it could be used by an unknown
> future kernel that knows the ABI.
> 
> So given what you have above, you'd use something like:
> 
> struct ima_kexec_hdr {
> 	u16 version;
> 	u16 _reserved0;
> 	u32 _reserved1;
> 	u64 buffer_size;
> 	u64 count;
> };
> 
> cheers

Thanks, I'll make this change.

Mimi
