Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 0BA4C67A7A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 09:27:52 +1100 (EST)
Date: Thu, 24 Feb 2005 15:27:44 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050224152744.E20498@cox.net>
References: <c3d0340b05022310396240c8ac@mail.gmail.com>
	<20050223142426.B13087@cox.net>
	<c3d0340b05022413437aa5b729@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05022413437aa5b729@mail.gmail.com>;
	from shawnxjin@gmail.com on Thu, Feb 24, 2005 at 01:43:57PM -0800
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Ebony's UBoot awareness
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 01:43:57PM -0800, Shawn Jin wrote:
> Hi Matt,
> 
> > Can you use the ocotea/luan approach and create an openbios stub
> > in arch/ppc/boot to create the bi_enetaddr infos? The PIBS stub
> > in arch/ppc/boot does this so we can have one path in the platform
> > file that parses the bootinfos.
> 
> I'd like to help if I can follow you. What does PIBS stand for? What
> is the ocotea/luan approach you were talking about? I thought I
> followed the ocotea approach to set up mac addresses.

PIBS is the firmware on all post 440GP ref brds from IBM/AMCC. Take
a look at how both the stock PIBS f/w and U-Boot are supported on
Ocotea by reviewing arch/ppc/boot/simple/pibs.c and
arch/ppc/platforms/4xx/ocotea.c

In this implementation, ocotea.c always expects the enetaddrs in
a birec. Whether they come direct from U-Boot or from some massaging
by the arch/ppc/boot/simple/pibs.c shim doesn't matter. I suggest
following that model which requires creating something like
arch/ppc/boot/simple/openbios.c with a strong symboled load_kernel()
routine that builds the bi-rec for the stock firmware case.

This hides the ugliness in the boot wrapper glue.

-Matt
