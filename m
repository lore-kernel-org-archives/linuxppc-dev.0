Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809140706i599d70b2q12d3582c7a95498c@mail.gmail.com>
Date: Sun, 14 Sep 2008 10:06:43 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: demuxing irqs
In-Reply-To: <9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809131206j125e7e25of07c19028ac07339@mail.gmail.com>
	<adaprn7is80.fsf@cisco.com>
	<9e4733910809131554mb0c6660r3bcc993bb2ca082d@mail.gmail.com>
	<adaljxvir57.fsf@cisco.com>
	<9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

How do the virq numbers get assigned?
What do I pass into request_irq when I use one of these pins?

The gpio device...
		gpio_wkup: gpio-wkup@c00 {
			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
			reg = <0xc00 0x40>;
			interrupts = <0x1 0x8 0x0 0x0 0x3 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			gpio-controller;
			#gpio-cells = <4>;
		};

use of a gpio from the device...
		ir@0 {
			compatible = "digispeaker,gpio-ir";

			gpios = <&gpio_wkup 0 0 1 0>;
		};


0 - gpio number in the device
0 - enable open drain
1 - class of interrupt, normal or wakeup
0 - type of interrupt, rising, falling, both, pulse


-- 
Jon Smirl
jonsmirl@gmail.com
