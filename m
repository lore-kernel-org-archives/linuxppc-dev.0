Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id E590BDDF92
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Feb 2008 06:43:56 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1055483anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 08 Feb 2008 11:43:54 -0800 (PST)
Message-ID: <fa686aa40802081143s1dd8fd46u97e3e11da5049380@mail.gmail.com>
Date: Fri, 8 Feb 2008 12:43:54 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Simon Kagstrom" <simon.kagstrom@ericsson.com>
Subject: Re: Leds
In-Reply-To: <20080208112002.42a15c0d@seasc0532.dyn.rnd.as.sw.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47AC28A8.5030609@coritel.it>
	<20080208112002.42a15c0d@seasc0532.dyn.rnd.as.sw.ericsson.se>
Cc: Marco Stornelli <marco.stornelli@coritel.it>,
	LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Feb 8, 2008 3:20 AM, Simon Kagstrom <simon.kagstrom@ericsson.com> wrote:
> Hi Marco,
>
> On Fri, 08 Feb 2008 11:02:16 +0100
> Marco Stornelli <marco.stornelli@coritel.it> wrote:
>
> > how can specify a led device in a dts file? These leds are connected
> > with gpio to the microprocessor. I can't find anything like a led node
> > in the dts files of the other boards. Have you got any suggestions?
>
> Although I'm not sure if it's the "standard" way, we just added a
> "home-made" node like this:
>
>         resetLED@c0018000 {
>                 device_type = "leds";
>                 compatible = "reset-leds";
>                 reg = <c0018000 00008000>;
>         };

I've been thinking about this a bit over the last couple of months,
and I think that there is a better way.  Since many LEDs are simply
hooked up to GPIO blocks and we're moving towards a common GPIO api
(and device tree binding), I think it would be better to use two
nodes; a node for the gpio block and a node for all the LEDs in the
system.  For example (the GPIO dt bindings may differ from my example
here, but you get the gist):

GPIO0: gpio-controller@1418 {
        #gpio-cells = <2>;
        compatible = "fsl,qe-pario-bank";
        reg = <0x1418 0x18>;
        gpio-controller;
};
GPIO1: gpio-controller@1460 {
        #gpio-cells = <2>;
        compatible = "fsl,qe-pario-bank";
        reg = <0x1460 0x18>;
        gpio-controller;
};

leds@0 {
        compatible = "gpio-leds";
        led-labels = "led1", "led2", "led3", "led4";
        gpios = <&GPIO0  2 0 /* LED1 */
                 &GPIO0  3 0 /* LED2 */
                 &GPIO1  8 0 /* LED3 */
                 &GPIO1  9 0 /* LED4 */
                 >;
        /* More properties are probably needed here to correctly setup
the output levels */
};

Doing it this way means the GPIO block will be usable for more than
just LEDs.  Plus once the 'gpio-leds' driver is written leds can be
hooked up almost trivially on new boards.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
