Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EF76A67DA7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 16:29:28 +1000 (EST)
Date: Wed, 4 Oct 2006 23:29:26 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Message-ID: <20061005062926.GB1985@gate.ebshome.net>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<17699.769.632098.479906@cargo.ozlabs.ibm.com>
	<2867EA41-5135-43F7-9873-044C617EAC1B@embeddedalley.com>
	<17700.20834.792693.853677@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17700.20834.792693.853677@cargo.ozlabs.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 05, 2006 at 10:27:14AM +1000, Paul Mackerras wrote:
> Dan Malek writes:
> 
> > I'm not against using the device tree (or platform data
> > or #defines) when it's appropriate to do so.  I think our
> > obsession to represent everything there is what is
> > creating the complexity.  If a #define in a board
> > specific port file makes sense, then just do that,
> > even if it is a BSCR address.
> 
> So, where this discussion started was that I saw an ioremap in an
> ethernet driver using a physical address defined with #define, and I
> said "that should go in the device tree".  And I would still say that
> if the ioremap was still there, since the driver is one that is useful
> across a range of boards and chips.
> 
> My other point would be that what you say is valid *until* the
> hardware engineers come to you and say "we're doing rev 2 of the
> board, and we had to move the BCSR a bit.  That's OK with you, isn't
> it?".
> 
> If you have the BCSR address in the device tree, you don't even need
> to recompile your kernel.  You can just copy your board.dts to
> board-rev2.dts, change the address in there, and rerun the wrapper
> script to create the flash image to put on the new board.  Or if you
> are using a bootloader that knows how to supply a device-tree blob,
> you just put board-rev2.dtb into flash along with your existing kernel
> image.

Paul,

it doesn't really matter if you have to rebuild a kernel or some 
other blob and have it re-flashed in the actual board.

Having something in device tree doesn't change a simple fact that you 
have to update some firmware component, be it boot code, kernel or 
some dts blob. You still have to prepare new flash image, period.

-- 
Eugene
