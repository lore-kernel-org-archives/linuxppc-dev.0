Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id CEEADDDECA
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:50:20 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1037554rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 16:50:19 -0700 (PDT)
Message-ID: <fa686aa40810241650q4f195249t44a9276b20190a5d@mail.gmail.com>
Date: Fri, 24 Oct 2008 17:50:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Trent Piepho" <tpiepho@freescale.com>
Subject: Re: [PATCH 2/4] leds: Support OpenFirmware led bindings
In-Reply-To: <1224889741-4167-2-git-send-email-tpiepho@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
	<1224889741-4167-2-git-send-email-tpiepho@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 5:08 PM, Trent Piepho <tpiepho@freescale.com> wrote:
> Add bindings to support LEDs defined as of_platform devices in addition to
> the existing bindings for platform devices.
>
> New options in Kconfig allow the platform binding code and/or the
> of_platform code to be turned on.  The of_platform code is of course only
> available on archs that have OF support.
>
> The existing probe and remove methods are refactored to use new functions
> create_gpio_led(), to create and register one led, and delete_gpio_led(),
> to unregister and free one led.  The new probe and remove methods for the
> of_platform driver can then share most of the common probe and remove code
> with the platform driver.
>
> The suspend and resume methods aren't shared, but they are very short.  The
> actual led driving code is the same for LEDs created by either binding.
>
> The OF bindings are based on patch by Anton Vorontsov
> <avorontsov@ru.mvista.com>.  They have been extended to allow multiple LEDs
> per device.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>

This also looks sane.  However, since this modifies a binding, can you
please repost to the devicetree-discuss@ozlabs.org mailing list?
Also, one comment below.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> diff --git a/Documentation/powerpc/dts-bindings/gpio/led.txt b/Documentation/powerpc/dts-bindings/gpio/led.txt
> index ff51f4c..9f969c2 100644
> --- a/Documentation/powerpc/dts-bindings/gpio/led.txt
> +++ b/Documentation/powerpc/dts-bindings/gpio/led.txt
> @@ -1,15 +1,43 @@
> -LED connected to GPIO
> +LEDs connected to GPIO lines
>
>  Required properties:
> -- compatible : should be "gpio-led".
> -- label : (optional) the label for this LED. If omitted, the label is
> +- compatible : should be "gpio-leds".
> +
> +Each LED is represented as a sub-node of the gpio-leds device.  Each
> +node's name represents the name of the corresponding LED.
> +
> +LED sub-node properties:
> +- gpios :  Should specify the LED's GPIO, see "Specifying GPIO information
> +  for devices" in Documentation/powerpc/booting-without-of.txt.  Active
> +  low LEDs should be indicated using flags in the GPIO specifier.
> +- label :  (optional) The label for this LED.  If omitted, the label is
>   taken from the node name (excluding the unit address).
> -- gpios : should specify LED GPIO.
> +- linux,default-trigger :  (optional) This parameter, if present, is a
> +  string defining the trigger assigned to the LED.  Current triggers are:
> +    "backlight" - LED will act as a back-light, controlled by the framebuffer
> +                 system
> +    "default-on" - LED will turn on
> +    "heartbeat" - LED "double" flashes at a load average based rate
> +    "ide-disk" - LED indicates disk activity
> +    "timer" - LED flashes at a fixed, configurable rate

As I'm sure you can predict, I'm not thrilled with this; but it *is* a
very linux-specific sort of thing, it *is* a necessary bit of data.
:-)  My biggest worry is that the Linux internal strings will change
in the future which will force the gpio driver to insert a translation
between these names and some future internal Linux name...

... I suppose another option is to just codify them here right now
(maybe named something like "led-usage") and if Linux changes then the
driver just needs to keep up with the new trigger names (translating
the old).

Either way, I'm not going to oppose this patch over this issue.

Nice patch.
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
