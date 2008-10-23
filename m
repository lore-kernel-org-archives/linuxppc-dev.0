Return-Path: <wmb@firmworks.com>
Message-ID: <4900F90B.80703@firmworks.com>
Date: Thu, 23 Oct 2008 12:22:03 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com>
In-Reply-To: <4900ED81.3040202@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You could have the gpio node define an "address space" where each 
"address" is a GPIO pin number.

The node would have one address cell and one size cell, and the 
"decode-unit" and "encode-unit" methods would be the garden-variety 
flavors that just convert integers between binary and ASCII.  Since this 
is not a memory mapped address space, a "ranges" property wouldn't be 
necessary or appropriate.

The node could have an "available" property with address/size pairs 
defining pins that can be freely used.  For example, if pins 4 and 7-9 
were free, the available property would contain

   000000004 00000001   \ 1 pin starting at #4
   000000007 00000003   \ 3 pins starting at 7

This is modeled on the /memory node's "available" property.

Subordinate nodes could represent specific preassigned GPIO functions, 
for example

   /<whatever>/gpio/wakeup@12

As an alternative to the "available" property, you could instead have 
subordinate nodes for the user-assignable GPIOs, e.g.:

  /<whatever>/gpio/usergpio@4
  /<whatever>/gpio/usergpio@7
  ...

That last idea is probably a bit over-the-top, though, especially if 
there are a lot of unassigned GPIOs.

You could adopt the convention that preassigned GPIOs must be 
represented by subordinate nodes, and any GPIO that is not covered by a 
subordinate node's "reg" property is implicitly available.  That's the 
way it works for other address spaces.

Mitch Bradley


> Hi guys,
>
> I'm a little perplexed as to how I would define a GPIO controller in a 
> device tree but mark off pins as available or not, so users can geek 
> around in their own drivers without defining in a device tree exactly 
> what they intend to use it for (especially if it's something really 
> weird).
>
> Easiest example - the Efika runs an MPC5200B has 3 GPIO pins on the 
> board. It's not much, but they're there for use. All the other GPIOs 
> are absolutely out of bounds, off limits and probably dangerous to 
> touch, but since each GPIO block has a 32-bit register to handle them, 
> you can twiddle any bit you like with impunity and cause all the 
> damage you want. A simple thought comes to mind in that the gpiolib 
> should not allow a request for one of these "bad" GPIO pins to succeed.
>
> So, how do we define in a bank of GPIOs, which ones are free for use, 
> without them being attached to a device and given as a "gpios" property?
>
> Would we suggest a node;
>
> gpio-header {
>     compatible = "bplan,efika-gpio";
>     gpios = <&gpio-standard 16 0 17 0>;
> };
>
> gpio-header2 {
>     compatible = "bplan,efika-gpio-wkup";
>     gpios = <&gpio-wkup 18 0>;
> };
>
> Which a driver can then look for? I would much rather I did not have 
> to come up with a special compatible property though, after all, 
> MPC5200B GPIO are not special and the Efika does not do fancy magic 
> with them :)
>
> My goal is basically to give an entry in the device tree whereby 
> (using a forth script) you can pick between IrDA, GPIO, a Sleep Switch 
> (for Sylvain's patch for Lite5200 and Efika from a year or two ago..), 
> or whatever else you like. But a generic GPIO "geek port" is basically 
> then undefined and left hanging.
>
> By the way I did notice that none of the GPT timer entries in the 
> lite5200b.dts have GPIO references and the GPT GPIO block is not 
> defined. Is this because the timers are not exposed on the board for 
> GPIO or just no need for it? Each timer has a pin it can sample, drive 
> and do PWM on.. this leads me to wonder how the PWM driver framework 
> as announced/proposed last week would work here, and if the device 
> tree should specifically pick which operation works on which timer 
> (after all if you have a PWM fan controller on a timer pin, you would 
> want to advertise the fact, but having the full 8 timers as a 
> "gpio-controller" and "pwm-controller" both at the same time, sharing 
> the same reg property but supporting only a subset of that controller, 
> needs addressing.
>
> -- 
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@ozlabs.org
> https://ozlabs.org/mailman/listinfo/devicetree-discuss
