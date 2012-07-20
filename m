Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 87AF92C035F
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2012 18:37:21 +1000 (EST)
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB002079C3290@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
 <10126984030.20120530140826@abatron.ch>
 <OF53CDE18C.59DD377E-ONC1257A0F.0031C7A0-C1257A0F.0031EA81@transmode.se>
 <13517672561.20120531113057@abatron.ch>
 <OF1016B1AA.DF19B646-ONC1257A0F.003647EF-C1257A0F.003699E5@transmode.se>
 <4FC7AEC9.5050203@freescale.com>
 <OF3AA5925F.E17EF6A4-ONC1257A0F.0076C23F-C1257A0F.0076D836@transmode.se>
 <4FC7E606.1070205@freescale.com>
 <OF43D61D1E.31CC8410-ONC1257A0F.0079F3A4-C1257A0F.007A237A@transmode.se>
 <4FC7EDD5.8090302@freescale.com>
 <OFDC3DAEDA.27E0B532-ONC1257A0F.007BF637-C1257A0F.007C1E26@transmode.se>
 <3E027F8168735B46AC006B1D0C7BB002079C3290@039-SN2MPN1-013.039d.mgd.msft.net>
Subject: RE: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Zang Roy-R61911 <r61911@freescale.com>
Message-ID: <OF2715F7FE.447A7381-ONC1257A41.002F433E-C1257A41.002F5BFA@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 20 Jul 2012 10:37:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Dan Malek <ppc6dev@digitaldans.com>, Support <support@abatron.ch>,
 Bob Cochran <ppc@mindchasers.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zang Roy-R61911 <r61911@freescale.com> wrote on 2012/07/20 10:27:52:
>
>
>
> > -----Original Message-----
> > From: linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org
> > [mailto:linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org]
> > On Behalf Of Joakim Tjernlund
> > Sent: Friday, June 01, 2012 6:36 AM
> > To: Wood Scott-B07421
> > Cc: linuxppc-dev@ozlabs.org; Dan Malek; Bob Cochran; Support
> > Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
> >
> > Scott Wood <scottwood@freescale.com> wrote on 2012/06/01 00:16:53:
> > >
> > > On 05/31/2012 05:14 PM, Joakim Tjernlund wrote:
> > > > Scott Wood <scottwood@freescale.com> wrote on 2012/05/31 23:43:34:
> > > >>
> > > >> On 05/31/2012 04:38 PM, Joakim Tjernlund wrote:
> > > >>> Scott Wood <scottwood@freescale.com> wrote on 2012/05/31 19:47:53:
> > > >>>>
> > > >>>> On 05/31/2012 04:56 AM, Joakim Tjernlund wrote:
> > > >>>>> Abatron Support <support@abatron.ch> wrote on 2012/05/31 11:30:57:
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>> Abatron Support <support@abatron.ch> wrote on 2012/05/30 14:08:26:
> > > >>>>>>>>
> > > >>>>>>>>>> I have tested this briefly with BDI2000 on P2010(e500) and
> > > >>>>>>>>>> it works for me. I don't know if there are any bad side
> > effects,
> > > >>>>>>>>>> therfore
> > > >>>>>>>>>> this RFC.
> > > >>>>>>>>
> > > >>>>>>>>> We used to have MSR_DE surrounded by CONFIG_something
> > > >>>>>>>>> to ensure it wasn't set under normal operation.  IIRC, if
> > MSR_DE
> > > >>>>>>>>> is set, you will have problems with software debuggers that
> > > >>>>>>>>> utilize the the debugging registers in the chip itself.  You
> > only want
> > > >>>>>>>>> to force this to be set when using the BDI, not at other times.
> > > >>>>>>>>
> > > >>>>>>>> This MSR_DE is also of interest and used for software debuggers
> > that
> > > >>>>>>>> make use of the debug registers. Only if MSR_DE is set then
> > debug
> > > >>>>>>>> interrupts are generated. If a debug event leads to a debug
> > interrupt
> > > >>>>>>>> handled by a software debugger or if it leads to a debug halt
> > handled
> > > >>>>>>>> by a JTAG tool is selected with DBCR0_EDM / DBCR0_IDM.
> > > >>>>>>>>
> > > >>>>>>>> The "e500 Core Family Reference Manual" chapter "Chapter 8
> > > >>>>>>>> Debug Support" explains in detail the effect of MSR_DE.
> > > >>>>>>
> > > >>>>>>> So what is the verdict on this? I don't buy into Dan argument
> > without some
> > > >>>>>>> hard data.
> > > >>>>>>
> > > >>>>>> What I tried to mention is that handling the MSR_DE correct is not
> > only
> > > >>>>>> an emulator (JTAG debugger) requirement. Also a software debugger
> > may
> > > >>>>>> depend on a correct handled MSR_DE bit.
> > > >>>>>
> > > >>>>> Yes, that made sense to me too. How would SW debuggers work if the
> > kernel keeps
> > > >>>>> turning off MSR_DE first chance it gets?
> > > >>>>
> > > >>>> The kernel selectively enables MSR_DE when it wants to debug.  I'm
> > not
> > > >>>> sure if anything will be bothered by leaving it on all the time.
> > This
> > > >>>> is something we need for virtualization as well, so a hypervisor can
> > > >>>> debug the guest.
> > > >>>
> > > >>> hmm, I read that as you as in favour of the patch?
> > > >>
> > > >> I'd want some confirmation that it doesn't break anything, and that
> > > >> there aren't any other places that need MSR_DE that this doesn't cover,
> > > >> but in general yes.
> > > >
> > > > Then you need to test drive the patch :)
> > >
> > > I was thinking more along the lines of someone who's more familiar with
> > > the relevant parts of the code confirming that it's really OK, not just
> > > testing that it doesn't blow up in my face.
> >
> > It just occurred to me that you guys have this already in your Linux SDK so
> > it can't be that bad.
> No. MSR_DE is ONLY added when using CW debug in SDK.
> Roy
>

Yes, and I later found that user space debugging is busted if you turn on MSR_DE in
kernel.

 Jocke
