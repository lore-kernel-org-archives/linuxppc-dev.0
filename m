Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BEBF6B6FF4
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2012 20:34:46 +1000 (EST)
In-Reply-To: <1338541971.16119.47.camel@pasglop>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>	
 <6F7E3816-E71B-466A-9C6F-9928E1CFD7B1@digitaldans.com>
 <10126984030.20120530140826@abatron.ch>	
 <OF53CDE18C.59DD377E-ONC1257A0F.0031C7A0-C1257A0F.0031EA81@transmode.se>
 <1338541971.16119.47.camel@pasglop>
Subject: Re: Re[2]: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF0A771176.8E50D0D7-ONC1257A10.0039C9DF-C1257A10.003A1AFE@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 1 Jun 2012 12:34:39 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2012/06/01 11:12:51:
>
> On Thu, 2012-05-31 at 11:05 +0200, Joakim Tjernlund wrote:
> > Abatron Support <support@abatron.ch> wrote on 2012/05/30 14:08:26:
> > >
> > > >> I have tested this briefly with BDI2000 on P2010(e500) and
> > > >> it works for me. I don't know if there are any bad side effects,
> > > >> therfore
> > > >> this RFC.
> > >
> > > > We used to have MSR_DE surrounded by CONFIG_something
> > > > to ensure it wasn't set under normal operation.  IIRC, if MSR_DE
> > > > is set, you will have problems with software debuggers that
> > > > utilize the the debugging registers in the chip itself.  You only want
> > > > to force this to be set when using the BDI, not at other times.
> > >
> > > This MSR_DE is also of interest and used for software debuggers that
> > > make use of the debug registers. Only if MSR_DE is set then debug
> > > interrupts are generated. If a debug event leads to a debug interrupt
> > > handled by a software debugger or if it leads to a debug halt handled
> > > by a JTAG tool is selected with DBCR0_EDM / DBCR0_IDM.
> > >
> > > The "e500 Core Family Reference Manual" chapter "Chapter 8
> > > Debug Support" explains in detail the effect of MSR_DE.
> >
> > So what is the verdict on this? I don't buy into Dan argument without some
> > hard data.
>
> The kernel normally controls when to set or not set MSR:DE, at least
> when using SW breakpoints. Setting it globally should remain some kind
> of specific debug option.
>
> In fact on some CPUs, we even leave user set dbcr settings and rely on
> DE being off in kernel space to avoid user->kernel attacks via the debug
> registers (I think we still do that on 64-bit BookE though it should
> eventually change).

hmm, would it not be better to always clear out/control dbcr settings and always have MSR:DE
on? It would be much easier to control dbcr, even dynamically, than MSR:DE

 Jocke
