Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82D60B6EEE
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jul 2010 01:59:51 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o69Fxmn5024123
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 08:59:48 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o69FxstI028510
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 10:59:54 -0500 (CDT)
Date: Fri, 9 Jul 2010 10:59:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
Message-ID: <20100709105946.68832b3e@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTinNSzP-WvxC2kqZop2kvd1kSUMDuwI01GOBXApE@mail.gmail.com>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
	<20100706152110.4f25e96b@schlenkerla.am.freescale.net>
	<AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
	<20100706181811.4542df5a@schlenkerla.am.freescale.net>
	<AANLkTimUxcsTMXNPOFfJxybp8u7Wv7Mt_nhW1EE01RqG@mail.gmail.com>
	<AANLkTinNSzP-WvxC2kqZop2kvd1kSUMDuwI01GOBXApE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 9 Jul 2010 00:35:43 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> I changed my toolchain and rebuilt the kernel image. This time all the
> messages below magically displayed on the serial port. :-D Are all
> these the early debugging messages?

Yes, it's an alternate output for the regular console (there are
sometimes more messages, if you hook up .progress in your ppc_md, but
that's mainly of interest if you don't get this far).

> Now the kernel stuck at the while loop that waits for transmitter fifo
> to be empty. It seems that the CPM UART stopped working in the middle
> of printing a message. I'm using minicom to connect to the serial
> port. I heard minicom is problematic. Will it be the cause here?

I doubt it...

You're probably getting to the point where udbg is disabled because the
real serial driver is trying to take over -- and something's going
wrong with the real serial port driver.  Check to make sure the brg
config is correct (both the input clock and the baud rate you're trying
to switch to).  Commenting out the call to cpm_set_brg can be
a quick way of determining if that's the problem.

-Scott
