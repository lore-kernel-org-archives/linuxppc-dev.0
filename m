Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7236567BAA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 07:39:13 +1000 (EST)
In-Reply-To: <5C69B7C2-1637-4B9A-BDCA-596DBE70A7DC@embeddedalley.com>
References: <44B7857A.2060101@freescale.com>
	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>
	<a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>
	<A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
	<5C69B7C2-1637-4B9A-BDCA-596DBE70A7DC@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <71D808D5-8227-4B0D-AF41-FADFC4B12463@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Mon, 17 Jul 2006 16:39:21 -0500
To: Dan Malek <dan@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2006, at 3:17 PM, Dan Malek wrote:

>
> On Jul 17, 2006, at 3:16 PM, Kumar Gala wrote:
>
>> I disagree.  You are coming from this from a board that does
>> everything under the sun.  I'd like to avoid having this type of
>> initialization in the kernel.  There is a whole additional kitchen
>> sink that could move into the kernel as well.
>
> Well, I'm going to have to disagree with your disagreement :-)
> The kernel should not assume things are properly initialized
> and rely on the boot rom to do such things.  I have several
> reasons for this.  One is that we are always pressed to make
> embedded systems boot more quickly, and taking time to
> initialize things in the boot rom just makes that a totally
> inflexible system design.  We don't need to initialize things
> we don't use, or can postpone until later.  Two, it makes
> us dependent upon a particular boot rom, or boot rom
> behavior, that not all boards may choose to support.
> Three, board designs may have external logic that requires
> a certain start up sequence or control register access
> that complicates the boot rom in it's ability to share
> code or implementation.

Well, I think there is a coupling that exists between whatever your  
boot rom is and the kernel.  If you are trying to optimize boot time  
I'd say one thing you would want is to avoid multiple writing the  
same configuration registers.

I dont have an issue if a fixed function board decides to do these  
things in their kernel init instead of their boot rom.  I however,  
don't want thousand and one config options to support all the various  
ways one can configure the Freescale board.

> There are more, but I think you see the trend.  In my
> years of doing this kind of development, you can't
> assume a boot rom is going to do much more than initialize
> memory and load the kernel.  I prefer the flexibility
> to be in the kernel, and not in the boot rom, because it
> is so much easier to develop and control.

- kumar
