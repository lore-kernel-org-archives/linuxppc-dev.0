Return-Path: <michal.simek@petalogix.com>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218]) by ozlabs.org (Postfix) with ESMTP id 62307B7D57
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 20:43:19 +1100 (EST)
Received: by fxm10 with SMTP id 10so2528040fxm.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 01:43:18 -0800 (PST)
Message-ID: <4B712DA5.4000802@petalogix.com>
Date: Tue, 09 Feb 2010 10:40:53 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH RFC 0/3] Implement refcounting for OF GPIO chips
References: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
In-Reply-To: <20100205204949.GA2575@oksana.dev.rtsoft.ru>
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

Anton Vorontsov wrote:
> Hi all,
> 
> OF GPIO infrastructure is using dynamic GPIO bases, so it is possible
> that of_get_gpio()'s returned GPIO number will be no longer valid, or
> worse, it may point to an unexpected GPIO controller.
> 
> This scenario is possible:
> 
> driver A:               driver B:              driver C:
> ---------               ---------              ---------
>                         gpiochip_add()
> gpio = of_get_gpio()
>                         gpiochip_remove()
>                                                gpiochip_add()
> gpio_request(gpio);
> gpio_set_value(gpio);
> 
> That is, driver A assumes that it is working with GPIO from driver B,
> but in practice it may disappear and driver C will take its GPIO base
> number, so it will provide the same GPIO numbers.
> 
> The above situation is hard to trigger, but the issue is there
> nonetheless, and so needs fixing.


I tested xilinx gpio driver, heartbeat trigger and access through sysfs 
and I haven't found any problem. There is only small part of code for 
Microblaze and it is the same with PowerPC. If is Ben OK with it, I am 
ok too.

Thanks,
Michal


> 
> Thanks,
> 
> p.s. The patches are based on top of
>      '[PATCH v2 0/4] OF GPIO integration for I2C/SPI GPIO chips'
>      http://lkml.org/lkml/2010/2/5/243
> 


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
