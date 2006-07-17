Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 1D60767BA8
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 08:11:46 +1000 (EST)
In-Reply-To: <71D808D5-8227-4B0D-AF41-FADFC4B12463@kernel.crashing.org>
References: <44B7857A.2060101@freescale.com>
	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>
	<a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>
	<A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
	<5C69B7C2-1637-4B9A-BDCA-596DBE70A7DC@embeddedalley.com>
	<71D808D5-8227-4B0D-AF41-FADFC4B12463@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E88826CB-074C-43CF-BD26-864E22FDB3AD@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Mon, 17 Jul 2006 18:12:03 -0400
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2006, at 5:39 PM, Kumar Gala wrote:

> Well, I think there is a coupling that exists between whatever your  
> boot rom is and the kernel.

There shouldn't be, I've always said that, but Freescale
seems to want to insist on it :-)  The problem is people
creating this evaluation/demo boards seem to think
they are workstations, which they are not.  There is
such a minimal amount of information needed to
actually get a system from the boot rom to the kernel
that I don't understand why we are complicating this
process for embedded systems.

Here is my product development experience.  People
buy these evaluation boards to test a few of the features
they need for a product.  These boards try to be everything
to everyone, but in reality have never done what someone
has wanted very well.  Products developed using Linux
and many different boot roms are very focused on a particular
set of features.  Their requirements are nothing like that of
an evaluation board, and all of these cute workstation
features we are pushing into these evaluation board ports
do nothing to help get these products customized for market.

> If you are trying to optimize boot time I'd say one thing you would  
> want is to avoid multiple writing the same configuration registers.

That's what I said.  Just do it in Linux when the feature is
started, either as a built-in driver or loadable module.  No
need to do this in a boot rom if there isn't any need for it.

> I dont have an issue if a fixed function board decides to do these  
> things in their kernel init instead of their boot rom.  I however,  
> don't want thousand and one config options to support all the  
> various ways one can configure the Freescale board.

I don't understand how configuration options fit into this
discussion.  In this particular discussion, if you have selected
the USB option, then include the proper initialization code
in the kernel for the board.  No additional options needed.

Thanks.

	-- Dan
