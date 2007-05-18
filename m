Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-235-friday.dmz.nerim.net
	[195.5.254.235]) by ozlabs.org (Postfix) with ESMTP id D19C3DDEFE
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 00:47:45 +1000 (EST)
Received: from kraid.nerim.net (smtp-105-friday.nerim.net [62.4.16.105])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 7B4811C66E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 16:47:36 +0200 (CEST)
Date: Fri, 18 May 2007 16:47:55 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>, Scott Wood <scottwood@freescale.com>
Subject: Re: [i2c] [PATCH 2/5] i2c: Allow preallocation of I2C bus numbers.
Message-ID: <20070518164755.0f823254@hyperion.delvare>
In-Reply-To: <200705171955.38899.david-b@pacbell.net>
References: <200705171955.38899.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 May 2007 19:55:38 -0700, David Brownell wrote:
> I confess I don't quite follow the intent of this patch.
> 
>  - i2c_alloc_bus_number() ... why not just have the platform
>    maintainer define the numbers?  (Or in the OF case, just
>    have the OF glue assign them.)   And it's pointless to
>    export this, given it supports calling a non-exported routine.
> 
>  - i2c_add_prenumbered_adapter() ... caller should just set
>    adapter->number itself and call i2c_add_numbered_adapter();
>    no need for a new routine.
> 
> Both calls seem useless to me.

I can only second David's scepticism here. I fail to see the purpose of
this patch. It looks to me like we already have everything in place to
cover all use cases:

* If you need to declare the I2C devices before the I2C adapters are
created, you have i2c_register_board_info() and
i2c_add_numbered_adapter().

* If you declare the I2C adapters first, you have i2c_add_adapter() and
i2c_new_device/i2c_new_probed_device().

Scott, what problem were you trying to solve?

-- 
Jean Delvare
