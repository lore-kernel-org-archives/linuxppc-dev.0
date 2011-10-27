Return-Path: <vapierfilter@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AFF501007D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 00:30:05 +1100 (EST)
Received: by wwf5 with SMTP id 5so3294819wwf.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 06:30:01 -0700 (PDT)
MIME-Version: 1.0
Sender: vapierfilter@gmail.com
In-Reply-To: <20111027131124.GK19187@n2100.arm.linux.org.uk>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1319720503-3183-1-git-send-email-vapier@gentoo.org>
 <20111027131124.GK19187@n2100.arm.linux.org.uk>
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Oct 2011 15:29:40 +0200
Message-ID: <CAJaTeTp_jv-b1GUEswfFzn=joj=jkMHE91zK1wnDksH60GT6Dg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux@lists.openrisc.net,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org,
 Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au,
 linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 27, 2011 at 15:11, Russell King - ARM Linux wrote:
> On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
>> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
>> index d494001..622851c 100644
>> --- a/include/asm-generic/gpio.h
>> +++ b/include/asm-generic/gpio.h
>> @@ -170,6 +170,29 @@ extern int __gpio_cansleep(unsigned gpio);
>>
>> =A0extern int __gpio_to_irq(unsigned gpio);
>>
>> +#ifndef gpio_get_value
>> +#define gpio_get_value(gpio) __gpio_get_value(gpio)
>> +#endif
>> +
>> +#ifndef gpio_set_value
>> +#define gpio_set_value(gpio, value) __gpio_set_value(gpio, value)
>> +#endif
>> +
>> +#ifndef gpio_cansleep
>> +#define gpio_cansleep(gpio) __gpio_cansleep(gpio)
>> +#endif
>> +
>> +#ifndef gpio_to_irq
>> +#define gpio_to_irq(gpio) __gpio_to_irq(gpio)
>> +#endif
>> +
>> +#ifndef irq_to_gpio
>> +static inline int irq_to_gpio(unsigned int irq)
>> +{
>> + =A0 =A0 return -EINVAL;
>> +}
>> +#endif
>> +
>
> This is extremely dangerous. =A0Consider for example this code
> (see ARM mach-davinci's gpio.h):
> ...
> This is why I didn't solve this using the preprocessor method in ARM, but
> instead used __ARM_GPIOLIB_COMPLEX to control whether these definitions
> are required.

i thought the arm mach were defining things already, but i guess i
missed some in my review

easy enough to glue the arm-specific world to the asm-generic world
... a bit ugly, but should work i think:
#ifndef __ARM_GPIOLIB_COMPLEX
/* assume the mach has defined this */
#ifndef gpio_get_value
#define gpio_get_value gpio_get_value
#endif
#ifndef gpio_set_value
#define gpio_set_value gpio_set_value
#endif
#ifndef gpio_cansleep
#define gpio_cansleep gpio_cansleep
#endif
#ifndef gpio_to_irq
#define gpio_to_irq gpio_to_irq
#endif
#ifndef irq_to_gpio
#define irq_to_gpio irq_to_gpio
#endif
...

the next step might be to drill down into the arm mach's and sprinkle
the defines into the parts that need it ...
-mike
