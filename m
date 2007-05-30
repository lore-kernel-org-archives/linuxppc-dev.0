Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 715CCDDFCC
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 06:47:15 +1000 (EST)
Date: Wed, 30 May 2007 15:52:39 -0500
To: Steve Munroe <sjmunroe@us.ibm.com>
Subject: Re: Saving to 32 bits of GPRs in signal context
Message-ID: <20070530205239.GA9462@lixom.net>
References: <BE207C16-E909-43B1-AA2B-BBC9E026F300@kernel.crashing.org>
	<OF3CF62163.CD3DCA16-ON862572EB.006C0F2C-862572EB.006CBB1C@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF3CF62163.CD3DCA16-ON862572EB.006C0F2C-862572EB.006CBB1C@us.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 30, 2007 at 02:47:37PM -0500, Steve Munroe wrote:
> 
> Kumar Gala <galak@kernel.crashing.org> wrote on 05/30/2007 12:31:32 AM:
> 
> >
> > On May 29, 2007, at 9:54 PM, Steve Munroe wrote:
> >
> > >
> > > Kumar Gala <galak@kernel.crashing.org> wrote on 05/29/2007 07:43:05
> > > PM:
> > >
> > >>
> > >> On May 29, 2007, at 6:46 PM, Olof Johansson wrote:
> > >>
> > >>> On Wed, May 30, 2007 at 07:32:33AM +1000, Benjamin Herrenschmidt
> > >>> wrote:
> > >>>> On Tue, 2007-05-29 at 08:10 -0500, Kumar Gala wrote:
> > >>>>> This is all problematic since some 64-bit implementations may not
> > >>>>> guarantee the upper bits are valid when in 32-bit mode.  Look
> > >>>>> at the
> > >>>>> 'Computation Modes' section in the architecture specs 2.03 or
> > >>>>> greater
> > >>>>> for embedded processors.
> > >>>>
> > >>>> Yuck. Well, we might need to export a spearate CPU feature bit to
> > >>>> indicate that it's the case then.
> > >>>
> > >>> No need for a new bit, you should be able to key off of
> > >>> PPC_FEATURE_64
> > >>> && !PPC_FEATURE_BOOKE.
> > >>
> > >> Nope, the architecture allows embedded to behave like server parts
> > >> and support the full 64-bit registers.  We really should have a new
> > >> feature bit so that if someone has an implementation of an embedded
> > >> part that supports the functionality, they get the benefit.
> > >>
> > > When such exists we can add a bit, until then we can wait. The current
> > > 32-bit AT_HWCAP is almost full. so we should not allocate bits on
> > > speculation.
> >
> > Understandable.. dare I ask about a few of the current AT_HWCAPs we
> > do have:
> >
> > #define PPC_FEATURE_POWER4              0x00080000
> > #define PPC_FEATURE_POWER5              0x00040000
> > #define PPC_FEATURE_POWER5_PLUS         0x00020000
> > #define PPC_FEATURE_ARCH_2_05           0x00001000
> > #define PPC_FEATURE_PA6T                0x00000800
> > #define PPC_FEATURE_POWER6_EXT          0x00000200
> >
> > What exactly are we using these for?  Can we not use platform for
> > some of these?
> >
> These are poorly named ISA versions
> 
> PPC_FEATURE_POWER4 == PPC_FEATURE_ARCH_2_0
> PPC_FEATURE_POWER5 == PPC_FEATURE_ARCH_2_02
> PPC_FEATURE_POWER5+ == PPC_FEATURE_ARCH_2_03
> 
> Ask Olof about this but I think
> PPC_FEATURE_PA6T == PPC_FEATURE_ARCH_2_04
> but I think it is more then 2_04 and less than 2_05.

The problem is that IBM has never (before) had to care about what was
implementation and what was architecture. The implementation WAS the
architecture up until POWER5+, and the PPC ISA went lock-step with the
new server processor releases.

PA6T is 2.04 + a few 2.05 bits, give or take. But it's not equivalent of
POWER6 (nor is it equivalent of POWER5+, since they implement different
optional features of the architecture).

I'm not sure just how to make this scale down the road -- if we are to
use a PPC_FEATURE_* for every optional feature in the ISA, we'll run
out of bits in no time. If we end up using a flag per implementation,
it probably won't be quite as bad, but I'm guessing the actual code that
uses it will get hairier.


-Olof
