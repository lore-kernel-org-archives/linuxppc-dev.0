Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B72E41007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jan 2010 03:25:57 +1100 (EST)
Date: Tue, 12 Jan 2010 16:25:39 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Subject: Re: [RFC,PATCH 3/7 v2] arm/versatile: use generic struct clk
Message-ID: <20100112162539.GH27771@n2100.arm.linux.org.uk>
References: <1263279511.160127.576969496193.0.gpush@pororo>
	<1263279511.161193.484965724912.3.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1263279511.161193.484965724912.3.gpush@pororo>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
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

On Tue, Jan 12, 2010 at 05:58:31PM +1100, Jeremy Kerr wrote:
> diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
> index aae5bc0..71e7596 100644
> --- a/arch/arm/common/clkdev.c
> +++ b/arch/arm/common/clkdev.c
> @@ -85,11 +85,13 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>  }
>  EXPORT_SYMBOL(clk_get);
>  
> +#ifndef CONFIG_USE_COMMON_STRUCT_CLK
>  void clk_put(struct clk *clk)
>  {
>  	__clk_put(clk);
>  }
>  EXPORT_SYMBOL(clk_put);
> +#endif /* CONFIG_USE_COMMON_STRUCT_CLK */

This doesn't make any sense.  What are you trying to do here?

The get/put operations go together as one logical set - that's why you
get both if you're using clkdev, and why you're asked to implement both
__clk_get() and __clk_put() in arch code to do whatever's necessary
with the clock.

Let me guess, and say that clk_put() is not a release method.  It's a
method for drivers to say "I'm done with this clock" and for the arch
code to reverse the effects of __clk_get()/clk_get().

Currently, its only user is to balance module counts.
