Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87067DDEF1
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:25:04 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180983654.9632.28.camel@ld0161-tx32>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
	<A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
	<18015.48278.312517.781244@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
	<CD8461E1-1881-407C-BE62-3679AECAE5AA@kernel.crashing.org>
	<1180740531.19517.480.camel@localhost.localdomain>
	<1180983654.9632.28.camel@ld0161-tx32>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 08:24:54 +1000
Message-Id: <1180995894.31677.77.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Wei Zhang <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 14:00 -0500, Jon Loeliger wrote:
> On Fri, 2007-06-01 at 18:28, Benjamin Herrenschmidt wrote:
> > On Fri, 2007-06-01 at 14:58 -0500, Kumar Gala wrote:
> > > 
> > > So looking at the code it looks like pci_assign_all_buses should  
> > > handle numbering the busses properly when we scan the busses, so  
> > > what's the issue that causes that not to be correct? 
> > 
> > Yeah, that's what powermac uses... Any reason it wouldn't work ?
> > 
> > Ben.
> 
> Empirical testing says it doesn't work.

You may also need to tweak pcibios_assign_bus_offset to bump it to a
higher value. There are issues when renumbering bus numbers when during
the probe, a bus is renumbered to the same number as a not-yet probed
bridge on the same segment.

That is fixed on powermac by adding an artificial "offset" of 16 between
bus numbers of different domains via this offset variable.

Ben.
