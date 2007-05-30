Return-Path: <sjmunroe@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 004BBDDFD7
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 05:47:55 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4UJlk4p020020
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 15:47:46 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4UJlkDG557846
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 15:47:46 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4UJlja9020954
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 15:47:46 -0400
In-Reply-To: <BE207C16-E909-43B1-AA2B-BBC9E026F300@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <OF3CF62163.CD3DCA16-ON862572EB.006C0F2C-862572EB.006CBB1C@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Wed, 30 May 2007 14:47:37 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kumar Gala <galak@kernel.crashing.org> wrote on 05/30/2007 12:31:32 AM:

>
> On May 29, 2007, at 9:54 PM, Steve Munroe wrote:
>
> >
> > Kumar Gala <galak@kernel.crashing.org> wrote on 05/29/2007 07:43:05
> > PM:
> >
> >>
> >> On May 29, 2007, at 6:46 PM, Olof Johansson wrote:
> >>
> >>> On Wed, May 30, 2007 at 07:32:33AM +1000, Benjamin Herrenschmidt
> >>> wrote:
> >>>> On Tue, 2007-05-29 at 08:10 -0500, Kumar Gala wrote:
> >>>>> This is all problematic since some 64-bit implementations may not
> >>>>> guarantee the upper bits are valid when in 32-bit mode.  Look
> >>>>> at the
> >>>>> 'Computation Modes' section in the architecture specs 2.03 or
> >>>>> greater
> >>>>> for embedded processors.
> >>>>
> >>>> Yuck. Well, we might need to export a spearate CPU feature bit to
> >>>> indicate that it's the case then.
> >>>
> >>> No need for a new bit, you should be able to key off of
> >>> PPC_FEATURE_64
> >>> && !PPC_FEATURE_BOOKE.
> >>
> >> Nope, the architecture allows embedded to behave like server parts
> >> and support the full 64-bit registers.  We really should have a new
> >> feature bit so that if someone has an implementation of an embedded
> >> part that supports the functionality, they get the benefit.
> >>
> > When such exists we can add a bit, until then we can wait. The current
> > 32-bit AT_HWCAP is almost full. so we should not allocate bits on
> > speculation.
>
> Understandable.. dare I ask about a few of the current AT_HWCAPs we
> do have:
>
> #define PPC_FEATURE_POWER4              0x00080000
> #define PPC_FEATURE_POWER5              0x00040000
> #define PPC_FEATURE_POWER5_PLUS         0x00020000
> #define PPC_FEATURE_ARCH_2_05           0x00001000
> #define PPC_FEATURE_PA6T                0x00000800
> #define PPC_FEATURE_POWER6_EXT          0x00000200
>
> What exactly are we using these for?  Can we not use platform for
> some of these?
>
These are poorly named ISA versions

PPC_FEATURE_POWER4 == PPC_FEATURE_ARCH_2_0
PPC_FEATURE_POWER5 == PPC_FEATURE_ARCH_2_02
PPC_FEATURE_POWER5+ == PPC_FEATURE_ARCH_2_03

Ask Olof about this but I think
PPC_FEATURE_PA6T == PPC_FEATURE_ARCH_2_04
but I think it is more then 2_04 and less than 2_05.

This one PPC_FEATURE_POWER6_EXT is for the mftgpr/mffgpr instructions
unique to power6 native mode.

These support inline runtime tests to use instructions for newer versions
of the ISA

AT_PLATFORM is for slecting whole libraries. Not appropriate for inline
tests.
