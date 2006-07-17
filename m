Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 3BFE867CCE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 06:23:33 +1000 (EST)
In-Reply-To: <A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
References: <44B7857A.2060101@freescale.com>
	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>
	<a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>
	<A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5C69B7C2-1637-4B9A-BDCA-596DBE70A7DC@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Mon, 17 Jul 2006 16:17:11 -0400
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


On Jul 17, 2006, at 3:16 PM, Kumar Gala wrote:

> I disagree.  You are coming from this from a board that does
> everything under the sun.  I'd like to avoid having this type of
> initialization in the kernel.  There is a whole additional kitchen
> sink that could move into the kernel as well.

Well, I'm going to have to disagree with your disagreement :-)
The kernel should not assume things are properly initialized
and rely on the boot rom to do such things.  I have several
reasons for this.  One is that we are always pressed to make
embedded systems boot more quickly, and taking time to
initialize things in the boot rom just makes that a totally
inflexible system design.  We don't need to initialize things
we don't use, or can postpone until later.  Two, it makes
us dependent upon a particular boot rom, or boot rom
behavior, that not all boards may choose to support.
Three, board designs may have external logic that requires
a certain start up sequence or control register access
that complicates the boot rom in it's ability to share
code or implementation.

There are more, but I think you see the trend.  In my
years of doing this kind of development, you can't
assume a boot rom is going to do much more than initialize
memory and load the kernel.  I prefer the flexibility
to be in the kernel, and not in the boot rom, because it
is so much easier to develop and control.

Thanks.

	-- Dan
