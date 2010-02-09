Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f203.google.com (mail-iw0-f203.google.com
	[209.85.223.203]) by ozlabs.org (Postfix) with ESMTP id D3652B7CE7
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 04:13:32 +1100 (EST)
Received: by iwn41 with SMTP id 41so2839629iwn.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 09:13:31 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100205203236.GC1475@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 10:13:11 -0700
Message-ID: <fa686aa41002090913t4c72a3b8o5fda68723bc8d089@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 5, 2010 at 1:32 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> This patch implements GPIOLIB notifier hooks, and thus makes device-enabl=
ed
> GPIO chips (i.e. the ones that have gpio_chip->dev specified) automatical=
ly
> attached to the OpenFirmware subsystem. Which means that now we can handl=
e
> I2C and SPI GPIO chips almost* transparently.
>
> * "Almost" because some chips still require platform data, and for these
> =A0chips OF-glue is still needed, though with this support the glue will
> =A0be much smaller.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> +static struct notifier_block of_gpio_nb =3D {
> + =A0 =A0 =A0 .notifier_call =3D of_gpio_notify,
> +};
> +
> +static int __init of_gpio_notifier_init(void)
> +{
> + =A0 =A0 =A0 return blocking_notifier_chain_register(&gpio_notifier, &of=
_gpio_nb);
> +}
> +arch_initcall(of_gpio_notifier_init);

Another concern;  if any gpio chips get registered before this
arch_initcall (not sure if it is possible or not), then those chips
won't get registered with the of gpio infrastructure.

g.
