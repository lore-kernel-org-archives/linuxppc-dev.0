Date: Wed, 28 Feb 2001 17:12:03 -0700
From: Matt Porter <mporter@mvista.com>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bogus interrupt
Message-ID: <20010228171203.A29030@beef.az.mvista.com>
References: <20010227051445.A32137@cx258813-a.chnd1.az.home.com> <NDBBIFIMCKPOADMAJOKMGEIFCPAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMGEIFCPAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Wed, Feb 28, 2001 at 09:29:18AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Feb 28, 2001 at 09:29:18AM +0100, Stefano Coluccini wrote:
> > > Hi everyone,
> > >   I'm trying to run kernel 2.5 on Motorola MVME5100 and, after the sti
> > > istruction in start_kernel, the kernel hangs due to a spurious
> > interrupt.
> > > (Bogus interrupt -1)
> > > Is this a well-known problem also in other ports ? or have
> > anyone of you a
> > > suggestion to solve this ?
> >
> > If you are using the default openpic initsenses in prep_pci.c then you
> > might see this problem since MPIC input 1 now has the 550 UART.  You'll
> > need to change the initsenses since the edge triggered ECC interrupt
> > used to be on input 1 on the older boards.
> >
> I've started working on MCPN765 port, since I think MVME5100 is an MCPN765
> with a VME Bridge and without an ISA bridge, so I think the senses of
> interrupt are correct because the 5100 and the 765 manual page related to
> the interrupt senses is exactly the same (or it is a cut&paste error ??? :))
> However this problem, like many other I've encountered, are all due to a bad
> cross-compiler :(. I start working today with a good environment after a
> month of nightmares !

Ok, I finally got time today to powerup the 5100 that's been laying
around here.  I just pushed the port to the linuxppc_2_5 tree.
Hopefully this saves some effort for others.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
