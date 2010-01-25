Return-Path: <jeremy.kerr@canonical.com>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by ozlabs.org (Postfix) with ESMTP id C58371007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Jan 2010 11:35:56 +1100 (EST)
From: Jeremy Kerr <jeremy.kerr@canonical.com>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [RFC,PATCH 3/7 v2] arm/versatile: use generic struct clk
Date: Mon, 25 Jan 2010 11:35:41 +1100
References: <1263279511.160127.576969496193.0.gpush@pororo>
	<1263279511.161193.484965724912.3.gpush@pororo>
	<20100112162539.GH27771@n2100.arm.linux.org.uk>
In-Reply-To: <20100112162539.GH27771@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201001251135.41611.jeremy.kerr@canonical.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Russell,

> This doesn't make any sense.  What are you trying to do here?
> 
> The get/put operations go together as one logical set - that's why you
> get both if you're using clkdev, and why you're asked to implement both
> __clk_get() and __clk_put() in arch code to do whatever's necessary
> with the clock.

I'm assuming that clk_put will be specific to the implementation; fixed clocks 
probably won't need to do anything, but others may need a refcount, etc.

We don't have a struct clk to use clk_get on, so it remains a non-clock-
specific function.

We'll probably need the symmetry for some cases though, I think that a 
__clk_get(struct clk *) member of clk_operations would work for this, to be 
called by clk_get.

Cheers,


Jeremy
