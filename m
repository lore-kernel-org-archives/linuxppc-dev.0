Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196]) by ozlabs.org (Postfix) with ESMTP id D988FB7CC2
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 06:40:06 +1100 (EST)
Received: by yxe34 with SMTP id 34so2608800yxe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Feb 2010 11:40:04 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100205205437.GA4733@oksana.dev.rtsoft.ru>
References: <20100205205437.GA4733@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 15 Feb 2010 12:39:44 -0700
Message-ID: <fa686aa41002151139yf7035d9kdfb6b9b592486fe4@mail.gmail.com>
Subject: Re: [PATCH] leds-gpio: Fix default state handling on OF platforms
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Trent Piepho <xyzzy@speakeasy.org>, linux-kernel@vger.kernel.org,
	Richard Purdie <rpurdie@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 1:54 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> The driver wrongly sets default state for LEDs that don't specify
> default-state property.
>
> Currently the driver handles default state this way:
>
> memset(&led, 0, sizeof(led));
> for_each_child_of_node(np, child) {
> =A0 =A0 =A0 =A0state =3D of_get_property(child, "default-state", NULL);
> =A0 =A0 =A0 =A0if (state) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!strcmp(state, "keep"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0led.default_state =3D LEDS=
_GPIO_DEFSTATE_KEEP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0ret =3D create_gpio_led(&led, ...);
> }
>
> Which means that all LEDs that do not specify default-state will
> inherit the last value of the default-state property, which is wrong.
>
> This patch fixes the issue by moving LED's template initialization
> into the loop body.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Richard, I assume you'll pick this one up via your tree?

g.

> ---
> =A0drivers/leds/leds-gpio.c | =A0 =A03 +--
> =A01 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
> index e5225d2..0823e26 100644
> --- a/drivers/leds/leds-gpio.c
> +++ b/drivers/leds/leds-gpio.c
> @@ -211,7 +211,6 @@ static int __devinit of_gpio_leds_probe(struct of_dev=
ice *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0const struct of_device_id *match)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np =3D ofdev->node, *child;
> - =A0 =A0 =A0 struct gpio_led led;
> =A0 =A0 =A0 =A0struct gpio_led_of_platform_data *pdata;
> =A0 =A0 =A0 =A0int count =3D 0, ret;
>
> @@ -226,8 +225,8 @@ static int __devinit of_gpio_leds_probe(struct of_dev=
ice *ofdev,
> =A0 =A0 =A0 =A0if (!pdata)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> - =A0 =A0 =A0 memset(&led, 0, sizeof(led));
> =A0 =A0 =A0 =A0for_each_child_of_node(np, child) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_led led =3D {};
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum of_gpio_flags flags;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *state;
>
> --
> 1.6.5.7
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
