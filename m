Return-Path: <michal.simek@petalogix.com>
Received: from mail-bw0-f212.google.com (mail-bw0-f212.google.com
	[209.85.218.212]) by ozlabs.org (Postfix) with ESMTP id AA636B7D1A
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 20:23:13 +1100 (EST)
Received: by bwz4 with SMTP id 4so5896661bwz.22
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 01:23:11 -0800 (PST)
Message-ID: <4B7128EF.4010503@petalogix.com>
Date: Tue, 09 Feb 2010 10:20:47 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
To: akpm@linux-foundation.org, Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] of/gpio: Introduce of_put_gpio(), add ref counting
	for OF GPIO chips
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
	<20100205205045.GC4178@oksana.dev.rtsoft.ru>
	<4B7127AC.9020600@petalogix.com>
In-Reply-To: <4B7127AC.9020600@petalogix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Michal Simek <monstr@monstr.eu>,
	David Brownell <dbrownell@users.sourceforge.net>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, David Miller <davem@davemloft.net>
Reply-To: michal.simek@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Simek wrote:
> Anton Vorontsov wrote:
>> OF GPIO infrastructure is using dynamic GPIO bases, so it is possible
>> that of_get_gpio()'s returned GPIO number will be no longer valid, or
>> worse, it may point to an unexpected GPIO controller.
> 
> I am not able to apply this last patch.
> 
> $ git-am < \[PATCH\ 3_3\]\ of_gpio\:\ Introduce\ of_put_gpio\(\)\,\ add\ 
> ref\ counting\ for\ OF\ GPIO\ chips.eml
> Applying of/gpio: Introduce of_put_gpio(), add ref counting for OF GPIO 
> chips
> error: patch failed: drivers/of/gpio.c:254
> error: drivers/of/gpio.c: patch does not apply
> Patch failed at 0001.
> When you have resolved this problem run "git-am --resolved".
> If you would prefer to skip this patch, instead run "git-am --skip".
> 
> Below is my git-log which patches I applied.
> Please fix it.

I see where the problem is. I applied Andrews patch too that's why I am 
getting the fault above.
Anyway will be good to fix it. Will test gpio and let you know.

Michal


> 
> Thanks,
> Michal
> 
> 99d5baaa53562252a896080bf426b4ae71a5e55f of: Introduce safe accessors 
> for node->data
> df6d71af9c0691716ad8a368609a7e26a8dfdaa0 of platforms: Move common 
> static initialization to of_node_init()
> 566969302a9dd70ce8a07c978bd08804ee73d0d6 powerpc/mcu_mpc8349emitx: 
> Remove OF GPIO handling stuff
> 816932ea74919867c1f899758ea4cdd138145453 of/gpio: Implement GPIOLIB 
> notifier hooks
> 3ea035a9e0f446b2b9cd9bacf73395a0c80ae3e9 of/gpio: Implement GPIOLIB 
> notifier hooks
> b7b96a9ee215c800476d002b06a338c4499f3813 of/gpio: Add support for 
> two-stage registration for the of_gpio_chips
> 15678cc192c03a2b1bbb36da18ff2a3fe2d78897 gpiolib: Introduce chip 
> addition/removal notifier
> deb0c98c7f6035d47a247e548384517a955314a5 Merge branch 'for-2.6.33' of 
> git://linux-nfs.org/~bfields/linux
> 
> 
> 
>>
>> This scenario is possible:
>>
>> driver A:               driver B:              driver C:
>> ---------               ---------              ---------
>>                         gpiochip_add()
>> gpio = of_get_gpio()
>>                         gpiochip_remove()
>>                                                gpiochip_add()
>> gpio_request(gpio);
>> gpio_set_value(gpio);
>>
>> That is, driver A assumes that it is working with GPIO from driver B,
>> but in practice it may disappear and driver C will take its GPIO base
>> number, so it will provide the same GPIO numbers.
>>
>> With this patch that situation is no longer possible. Though drivers
>> will need to learn to put GPIOs back, so that GPIO controllers could
>> be removed.
>>
>> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
>> ---
>>  drivers/of/gpio.c       |   82 
>> ++++++++++++++++++++++++++++++++++++++++-------
>>  include/linux/of_gpio.h |    5 +++
>>  2 files changed, 75 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/of/gpio.c b/drivers/of/gpio.c
>> index 9d8df77..e94c5c8 100644
>> --- a/drivers/of/gpio.c
>> +++ b/drivers/of/gpio.c
>> @@ -28,6 +28,8 @@
>>   * Returns GPIO number to use with Linux generic GPIO API, or one of 
>> the errno
>>   * value on the error condition. If @flags is not NULL the function 
>> also fills
>>   * in flags for the GPIO.
>> + *
>> + * Remeber to put the GPIO back using of_put_gpio() call.
>>   */
>>  int of_get_gpio_flags(struct device_node *np, int index,
>>                enum of_gpio_flags *flags)
>> @@ -46,6 +48,8 @@ int of_get_gpio_flags(struct device_node *np, int 
>> index,
>>          goto err0;
>>      }
>>  
>> +    spin_lock(&gc->data_lock);
>> +
>>      of_gc = gc->data;
>>      if (!of_gc) {
>>          pr_debug("%s: gpio controller %s isn't registered\n",
>> @@ -72,15 +76,62 @@ int of_get_gpio_flags(struct device_node *np, int 
>> index,
>>          goto err1;
>>  
>>      ret += of_gc->chip->base;
>> +
>> +    if (!try_module_get(of_gc->chip->owner)) {
>> +        ret = -EINVAL;
>> +        goto err1;
>> +    }
>> +
>> +    of_gc->refcnt++;
>>  err1:
>> +    spin_unlock(&gc->data_lock);
>> +
>>      of_node_put(gc);
>>  err0:
>>      pr_debug("%s exited with status %d\n", __func__, ret);
>> +
>>      return ret;
>>  }
>>  EXPORT_SYMBOL(of_get_gpio_flags);
>>  
>>  /**
>> + * of_put_gpio - Put a GPIO back to the OF subsystem
>> + * @np:        device node of the GPIO owner
>> + * @index:    index of the GPIO
>> + */
>> +static inline void of_put_gpio(struct device_node *np, int index)
>> +{
>> +    int ret;
>> +    struct device_node *gc;
>> +    struct of_gpio_chip *of_gc;
>> +
>> +    ret = of_parse_phandles_with_args(np, "gpios", "#gpio-cells", index,
>> +                      &gc, NULL);
>> +    if (ret) {
>> +        pr_debug("%s: can't parse gpios property\n", __func__);
>> +        return;
>> +    }
>> +
>> +    spin_lock(&gc->data_lock);
>> +
>> +    of_gc = gc->data;
>> +    if (!of_gc) {
>> +        pr_debug("%s: gpio controller %s isn't registered\n",
>> +             np->full_name, gc->full_name);
>> +        goto err;
>> +    }
>> +
>> +    if (of_gc->refcnt)
>> +        of_gc->refcnt--;
>> +    else
>> +        WARN_ON(1);
>> +
>> +    module_put(of_gc->chip->owner);
>> +err:
>> +    spin_unlock(&gc->data_lock);
>> +}
>> +
>> +/**
>>   * of_gpio_count - Count GPIOs for a device
>>   * @np:        device node to count GPIOs for
>>   *
>> @@ -254,11 +305,7 @@ static int of_gpiochip_register_simple(struct 
>> gpio_chip *chip,
>>                         struct device_node *np)
>>  {
>>      struct of_gpio_chip *of_gc;
>> -
>> -    if (np->data) {
>> -        WARN_ON(1);
>> -        return -EBUSY;
>> -    }
>> +    int ret;
>>  
>>      of_gc = kzalloc(sizeof(*of_gc), GFP_KERNEL);
>>      if (!of_gc)
>> @@ -267,10 +314,12 @@ static int of_gpiochip_register_simple(struct 
>> gpio_chip *chip,
>>      of_gc->gpio_cells = 2;
>>      of_gc->xlate = of_gpio_simple_xlate;
>>      of_gc->chip = chip;
>> -    np->data = of_gc;
>> -    of_node_get(np);
>>  
>> -    return 0;
>> +    ret = of_node_set_data(np, of_gc);
>> +    if (ret)
>> +        kfree(of_gc);
>> +
>> +    return ret;
>>  }
>>  EXPORT_SYMBOL(of_gpiochip_register_simple);
>>  
>> @@ -286,17 +335,26 @@ static int of_gpiochip_unregister(struct 
>> gpio_chip *chip,
>>                    struct device_node *np)
>>  {
>>      struct of_gpio_chip *of_gc = np->data;
>> +    int ret = 0;
>>  
>>      if (!of_gc || of_gc->chip != chip) {
>>          WARN_ON(1);
>>          return -EINVAL;
>>      }
>>  
>> -    np->data = NULL;
>> -    kfree(of_gc);
>> -    of_node_put(np);
>> +    spin_lock(&np->data_lock);
>>  
>> -    return 0;
>> +    if (of_gc->refcnt)
>> +        ret = -EBUSY;
>> +    else
>> +        of_node_release_data_unlocked(np);
>> +
>> +    spin_unlock(&np->data_lock);
>> +
>> +    if (!ret)
>> +        kfree(of_gc);
>> +
>> +    return ret;
>>  }
>>  
>>  static int of_gpio_notify(struct notifier_block *nb, unsigned long msg,
>> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
>> index c74cb37..aca7ab1 100644
>> --- a/include/linux/of_gpio.h
>> +++ b/include/linux/of_gpio.h
>> @@ -38,6 +38,7 @@ enum of_gpio_flags {
>>  struct of_gpio_chip {
>>      struct gpio_chip gc; /* legacy, don't use for a new code */
>>      struct gpio_chip *chip;
>> +    unsigned int refcnt;
>>      int gpio_cells;
>>      int (*xlate)(struct of_gpio_chip *of_gc, struct device_node *np,
>>               const void *gpio_spec, enum of_gpio_flags *flags);
>> @@ -83,6 +84,8 @@ static inline int of_get_gpio_flags(struct 
>> device_node *np, int index,
>>      return -ENOSYS;
>>  }
>>  
>> +static inline void of_put_gpio(struct device_node *np, int index) {}
>> +
>>  static inline unsigned int of_gpio_count(struct device_node *np)
>>  {
>>      return 0;
>> @@ -97,6 +100,8 @@ static inline unsigned int of_gpio_count(struct 
>> device_node *np)
>>   *
>>   * Returns GPIO number to use with Linux generic GPIO API, or one of 
>> the errno
>>   * value on the error condition.
>> + *
>> + * Remeber to put the GPIO back using of_put_gpio() call.
>>   */
>>  static inline int of_get_gpio(struct device_node *np, int index)
>>  {
> 
> 


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
