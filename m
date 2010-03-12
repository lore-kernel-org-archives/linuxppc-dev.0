Return-Path: <glikely@secretlab.ca>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.221.172]) by ozlabs.org (Postfix) with ESMTP id 20B8FB7D28
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 08:38:25 +1100 (EST)
Received: by qyk2 with SMTP id 2so1629081qyk.1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 13:38:23 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100312130723.43308ccd.akpm@linux-foundation.org>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
	<20100312130723.43308ccd.akpm@linux-foundation.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 12 Mar 2010 14:38:02 -0700
Message-ID: <fa686aa41003121338oe34eb89o22177cb0a309cc85@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
To: Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 12, 2010 at 2:07 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 5 Feb 2010 23:32:36 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
>
>> This patch implements GPIOLIB notifier hooks, and thus makes device-enab=
led
>> GPIO chips (i.e. the ones that have gpio_chip->dev specified) automatica=
lly
>> attached to the OpenFirmware subsystem. Which means that now we can hand=
le
>> I2C and SPI GPIO chips almost* transparently.
>>
>> ...
>>
>> +static int of_gpiochip_register_simple(struct gpio_chip *chip,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0struct device_node *np)
>
> Why is this called "register_simple" but the unregistration function
> isn't called "unregister_simple"?
>
>> +{
>> + =A0 =A0 struct of_gpio_chip *of_gc;
>> +
>> + =A0 =A0 if (np->data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 of_gc =3D kzalloc(sizeof(*of_gc), GFP_KERNEL);
>> + =A0 =A0 if (!of_gc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 of_gc->gpio_cells =3D 2;
>> + =A0 =A0 of_gc->xlate =3D of_gpio_simple_xlate;
>> + =A0 =A0 of_gc->chip =3D chip;
>> + =A0 =A0 np->data =3D of_gc;
>> + =A0 =A0 of_node_get(np);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(of_gpiochip_register_simple);
>
> Makes no sense to export a static symbol and to provide no declaration
> of it in a .h file. =A0I assume the export was unintended.
>
>
> My plot is somewhat lost. =A0Grant, could you please summarise in
> easy-for-akpm-to-understand terms what your issues are with this
> patchset and how you think we should proceed?

Sure.
I suggested the notifier approach in the first place, but now that I
see what is required to implement it I don't like it.  I also don't
like the potential race condition between registering GPIO devices and
registering the OF gpio notifier.  It is simpler and less code to put
the of_gpio hook directly into the GPIO registration path.  If
CONFIG_OF is not set, then the OF hooks can resolve to empty static
inline functions.

How to proceed:  I'd like to leave this series out for the 2.6.34
cycle and I'll pick it into my OF tree before the 2.6.35 merge window,
but I'll probably modify it to call the OF hooks directly and leave
out the unnecessary notifier infrastructure.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
