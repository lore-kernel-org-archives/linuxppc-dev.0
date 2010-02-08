Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6B03DB7CB6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 08:05:27 +1100 (EST)
Date: Mon, 8 Feb 2010 13:04:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] leds-gpio: Fix default state handling on OF platforms
Message-Id: <20100208130455.8cb90ff1.akpm@linux-foundation.org>
In-Reply-To: <20100205205437.GA4733@oksana.dev.rtsoft.ru>
References: <20100205205437.GA4733@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>,
	linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 5 Feb 2010 23:54:37 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> The driver wrongly sets default state for LEDs that don't specify
> default-state property.
> 
> Currently the driver handles default state this way:
> 
> memset(&led, 0, sizeof(led));
> for_each_child_of_node(np, child) {
> 	state = of_get_property(child, "default-state", NULL);
> 	if (state) {
> 		if (!strcmp(state, "keep"))
> 			led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
> 		...
> 	}
> 	ret = create_gpio_led(&led, ...);
> }
> 
> Which means that all LEDs that do not specify default-state will
> inherit the last value of the default-state property, which is wrong.


Does this actually happen in any 2.6.33 driver code?  If so, we might
want to merge this into 2.6.33.  And perhaps earlier kernels.  Or not. 
There's no way for me to tell :(
