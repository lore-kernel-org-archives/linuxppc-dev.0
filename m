Return-Path: <hollisb@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F712DDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 14:19:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m384JEbb028573
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 00:19:14 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m384JDXj197430
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:19:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m384JDCf024546
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:19:13 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3 of 3] [KVM POWERPC] PowerPC 440 KVM implementation
Date: Mon, 7 Apr 2008 23:19:11 -0500
References: <b07f3049f16483f80322.1207601614@localhost.localdomain>
	<200804080458.17783.arnd@arndb.de>
In-Reply-To: <200804080458.17783.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804072319.11677.hollisb@us.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 April 2008 21:58:17 Arnd Bergmann wrote:
> On Monday 07 April 2008, Hollis Blanchard wrote:
> > --- a/include/asm-powerpc/kvm.h
> > +++ b/include/asm-powerpc/kvm.h
> > @@ -1,6 +1,55 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA =A002110-13=
01,
> > USA. + *
> > + * Copyright IBM Corp. 2007
> > + *
> > + * Authors: Hollis Blanchard <hollisb@us.ibm.com>
> > + */
> > +
> > =A0#ifndef __LINUX_KVM_POWERPC_H
> > =A0#define __LINUX_KVM_POWERPC_H
> > =A0
> > -/* powerpc does not support KVM */
> > +#include <asm/types.h>
> > =A0
> > -#endif
> > +struct kvm_regs {
> > +=A0=A0=A0=A0=A0=A0=A0__u32 pc;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 cr;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 ctr;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 lr;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 xer;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 msr;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 srr0;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 srr1;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 pid;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg0;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg1;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg2;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg3;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg4;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg5;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg6;
> > +=A0=A0=A0=A0=A0=A0=A0__u32 sprg7;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0__u64 fpr[32];
> > +=A0=A0=A0=A0=A0=A0=A0__u32 gpr[32];
> > +};
> > +
> > +struct kvm_sregs {
> > +};
> > +
> > +struct kvm_fpu {
> > +};
> > +
> > +#endif /* __LINUX_KVM_POWERPC_H */
>
> Since this defines part of the ABI, it would be nice if it's possible
> to have it in a platform independent way. Most of the registers here
> should probably become "unsigned long" instead of "__u32" so that
> the definition can be used for a potential 64 bit port.

If there is one thing I have learned in my various porting efforts, it's th=
at=20
using a variable-sized type in an interface is just begging for trouble.

x86 uses fixed 64-bit variables here (even with x86-32), so that might be t=
he=20
right solution here.

> Also, I noticed that you lump everything into kvm_regs, instead of
> using sregs for stuff like srr0 and kvm_fpu for the fprs. What is
> the reason for that?

The FPRs and SPRs are only really useful for two things here: debugger supp=
ort=20
and migration. We don't really support either at the moment, so this part o=
f=20
the user/kernel ABI will need change as we implement those.

I will move the FPR stuff into kvm_fpu though. (I think when I originally=20
wrote this, kvm_fpu was defined to be x86 stuff, but it obviously isn't=20
now...)

=2D-=20
Hollis Blanchard
IBM Linux Technology Center
