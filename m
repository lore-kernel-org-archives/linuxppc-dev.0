Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D16F367BE3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 02:22:42 +1000 (EST)
Date: Wed, 27 Sep 2006 11:22:01 -0500
From: Olof Johansson <olof@lixom.net>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Message-ID: <20060927112201.293fef44@localhost.localdomain>
In-Reply-To: <CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul, Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 27 Sep 2006 10:42:17 -0400 Dan Malek <dan@embeddedalley.com> wrote:

> Since BCSRs are board specific, does anyone remember
> the day when a simple #define, ioremap, and a few lines
> of code in the board setup file was all that was needed? :-)

Yes, also called "board port hell". One of the major points with the
device tree is that the needed information for the system is in there,
not compiled into the kernel. So you can boot the same kernel binary on
several boards, as long as the drivers are built in and the correct
device tree is used. Has everyone missed/forgotten that objective
completely?

> What wrong with still doing that?  It seems everyone is
> obsessed with device tree syntax and forget that a
> few lines of code may still be a reasonable solution.

The device tree describes the system, not how to program it. I think
that's where the confusion might be.

I.e. create a generic "board-controller" device node, and put a
suitable "compatible" property in there, so the right board controller
driver can be chosen based on it. Having the address of the controller
in there helps too, especially if there are two boards out there with
the same controller but at different memory location.


-Olof
