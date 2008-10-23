Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 367E7DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 08:32:50 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so211660qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 14:32:49 -0700 (PDT)
Message-ID: <4900ED81.3040202@genesi-usa.com>
Date: Thu, 23 Oct 2008 16:32:49 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
Subject: GPIO - marking individual pins (not) available in device tree
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

I'm a little perplexed as to how I would define a GPIO 
controller in a device tree but mark off pins as available or 
not, so users can geek around in their own drivers without 
defining in a device tree exactly what they intend to use it 
for (especially if it's something really weird).

Easiest example - the Efika runs an MPC5200B has 3 GPIO pins 
on the board. It's not much, but they're there for use. All 
the other GPIOs are absolutely out of bounds, off limits and 
probably dangerous to touch, but since each GPIO block has a 
32-bit register to handle them, you can twiddle any bit you 
like with impunity and cause all the damage you want. A simple 
thought comes to mind in that the gpiolib should not allow a 
request for one of these "bad" GPIO pins to succeed.

So, how do we define in a bank of GPIOs, which ones are free 
for use, without them being attached to a device and given as 
a "gpios" property?

Would we suggest a node;

gpio-header {
	compatible = "bplan,efika-gpio";
	gpios = <&gpio-standard 16 0 17 0>;
};

gpio-header2 {
	compatible = "bplan,efika-gpio-wkup";
	gpios = <&gpio-wkup 18 0>;
};

Which a driver can then look for? I would much rather I did 
not have to come up with a special compatible property though, 
after all, MPC5200B GPIO are not special and the Efika does 
not do fancy magic with them :)

My goal is basically to give an entry in the device tree 
whereby (using a forth script) you can pick between IrDA, 
GPIO, a Sleep Switch (for Sylvain's patch for Lite5200 and 
Efika from a year or two ago..), or whatever else you like. 
But a generic GPIO "geek port" is basically then undefined and 
left hanging.

By the way I did notice that none of the GPT timer entries in 
the lite5200b.dts have GPIO references and the GPT GPIO block 
is not defined. Is this because the timers are not exposed on 
the board for GPIO or just no need for it? Each timer has a 
pin it can sample, drive and do PWM on.. this leads me to 
wonder how the PWM driver framework as announced/proposed last 
week would work here, and if the device tree should 
specifically pick which operation works on which timer (after 
all if you have a PWM fan controller on a timer pin, you would 
want to advertise the fact, but having the full 8 timers as a 
"gpio-controller" and "pwm-controller" both at the same time, 
sharing the same reg property but supporting only a subset of 
that controller, needs addressing.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
