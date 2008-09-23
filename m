Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id B4C54DDF45
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 01:03:00 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1971373rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 08:02:59 -0700 (PDT)
Date: Tue, 23 Sep 2008 09:02:56 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [RFC] GPIO-Watchdog in devicetree
Message-ID: <20080923150256.GC13593@secretlab.ca>
References: <20080922194357.GA32041@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080922194357.GA32041@pengutronix.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 22, 2008 at 09:43:57PM +0200, Wolfram Sang wrote:
> Hello all,
> 
> I understood that the device-tree is for describing hardware and should
> not contain driver specific information. I have problems drawing this
> line right now. I made a driver for watchdogs which are pinged by
> toggling a gpio. Currently the device-tree entry looks like this:
> 
> 	watchdog@gpio {
> 		compatible = "gpio-watchdog";
> 		gpios =	<&gpio_simple 19 0>;
> 	};
> 
> Then, there are two module parameters. One to define the initial state of
> the gpio (0 or 1), one to define the length of the pulse when serving
> the watchdog (default 1 us). Now my question is:
> 
> Is it plausible to say that the module parameters would also fit to the
> device-tree as properties? Recently, I tend to say so as otherwise the
> description of the watchdog is incomplete. Then again, one might argue
> to develop a specific watchdog driver instead of a generic one, and use
> something like compatible = "<myvendor>, <mywatchdog>" which would
> result in lots of duplicated code per watchdog. So, which way to go? I
> am really undecided and would be happy to hear opinions.

Since this is *very* board specific and there are a lot of parameters
that come into play that affect how the GPIO should be twiddled, I'd
consider leaving it out of the device tree entirely and coding it in the
platform code for your board (arch/powerpc/platforms/*/*).  Or, if you
still want to describe the gpio pin used the device tree, then add a
property to the base of the device tree that only your board platform
code looks at.

For example:
/ {
	model = "pengutronix,super-sexy-board";
	#address-cells = <1>;
	#size-cells = <1>;
	super-sexy-board,watchdog-gpio = <&gpio_simple 19 0>;
	...
}

Decoding a GPIO from the tree is quite simple so this should not result
in great swaths of duplicated code.

g.
