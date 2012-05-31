Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07F6CB6FE0
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2012 07:38:10 +1000 (EST)
In-Reply-To: <4FC7AEC9.5050203@freescale.com>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
 <10126984030.20120530140826@abatron.ch>
 <OF53CDE18C.59DD377E-ONC1257A0F.0031C7A0-C1257A0F.0031EA81@transmode.se>
 <13517672561.20120531113057@abatron.ch>
 <OF1016B1AA.DF19B646-ONC1257A0F.003647EF-C1257A0F.003699E5@transmode.se>
 <4FC7AEC9.5050203@freescale.com>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF3AA5925F.E17EF6A4-ONC1257A0F.0076C23F-C1257A0F.0076D836@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 31 May 2012 23:38:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Dan Malek <ppc6dev@digitaldans.com>,
 Bob Cochran <ppc@mindchasers.com>, Support <support@abatron.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 2012/05/31 19:47:53:
>
> On 05/31/2012 04:56 AM, Joakim Tjernlund wrote:
> > Abatron Support <support@abatron.ch> wrote on 2012/05/31 11:30:57:
> >>
> >>
> >>> Abatron Support <support@abatron.ch> wrote on 2012/05/30 14:08:26:
> >>>>
> >>>>>> I have tested this briefly with BDI2000 on P2010(e500) and
> >>>>>> it works for me. I don't know if there are any bad side effects,
> >>>>>> therfore
> >>>>>> this RFC.
> >>>>
> >>>>> We used to have MSR_DE surrounded by CONFIG_something
> >>>>> to ensure it wasn't set under normal operation.  IIRC, if MSR_DE
> >>>>> is set, you will have problems with software debuggers that
> >>>>> utilize the the debugging registers in the chip itself.  You only want
> >>>>> to force this to be set when using the BDI, not at other times.
> >>>>
> >>>> This MSR_DE is also of interest and used for software debuggers that
> >>>> make use of the debug registers. Only if MSR_DE is set then debug
> >>>> interrupts are generated. If a debug event leads to a debug interrupt
> >>>> handled by a software debugger or if it leads to a debug halt handled
> >>>> by a JTAG tool is selected with DBCR0_EDM / DBCR0_IDM.
> >>>>
> >>>> The "e500 Core Family Reference Manual" chapter "Chapter 8
> >>>> Debug Support" explains in detail the effect of MSR_DE.
> >>
> >>> So what is the verdict on this? I don't buy into Dan argument without some
> >>> hard data.
> >>
> >> What I tried to mention is that handling the MSR_DE correct is not only
> >> an emulator (JTAG debugger) requirement. Also a software debugger may
> >> depend on a correct handled MSR_DE bit.
> >
> > Yes, that made sense to me too. How would SW debuggers work if the kernel keeps
> > turning off MSR_DE first chance it gets?
>
> The kernel selectively enables MSR_DE when it wants to debug.  I'm not
> sure if anything will be bothered by leaving it on all the time.  This
> is something we need for virtualization as well, so a hypervisor can
> debug the guest.

hmm, I read that as you as in favour of the patch?
