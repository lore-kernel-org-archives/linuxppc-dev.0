Return-Path: <mj.embd@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 56E7FB6F10
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Aug 2010 02:16:00 +1000 (EST)
Received: by eyh6 with SMTP id 6so196624eyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Aug 2010 09:15:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
Date: Wed, 11 Aug 2010 21:45:58 +0530
Message-ID: <AANLkTikNt7hrxA+QR-omUiiLKVBnjqCw+HTDQh_5B5Ff@mail.gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
From: MJ embd <mj.embd@gmail.com>
To: Ravi Gupta <dceravigupta@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

u can directly access GPIO registers in kernel, by ioremap of GPIO
memory mapped registers.
you might need to check
- muxing of gpio

-mj

On Wed, Aug 11, 2010 at 6:57 PM, Ravi Gupta <dceravigupta@gmail.com> wrote:
> Hi,
>
> I am new to device driver development. I am trying to access the GPIO of
> MPC837xERDB eval board. I have upgraded its kernel to linux-2.6.28.9 and
> enable support for mpc8xxx_gpio.c. On boot up, it successfully detect two
> gpio controllers. Now my question is how I am going to use it to communic=
ate
> with the gpio pins? Do I have to modify the code in mpc8xxx_gpio.c file t=
o
> do whatever I want to do with gpios or I can use the standard gpio API
> provided in kernel ( gpio_request()/gpio_free() ). I also tries the stand=
ard
> kernel API, but it fails. Here is my code :
>
> #include <linux/module.h>
> #include <linux/errno.h>=A0 /* error codes */
> #include <linux/gpio.h>
>
> static __init int sample_module_init(void)
> {
> =A0 int ret;
>
> =A0 int i;
> =A0 for (i=3D1; i<32; i++) {
> =A0=A0=A0 ret =3D gpio_request(i, "Sample Driver");
> =A0=A0=A0 if (ret) {
> =A0=A0=A0=A0=A0 printk(KERN_WARNING "sample_driver: unable to request GPI=
O_PG%d\n",
> i);
> =A0=A0=A0=A0=A0 //return ret;
> =A0=A0=A0 }
> =A0 }
>
> =A0 return 0;
> }
>
> static __exit void sample_module_exit(void)
> {
> =A0 gpio_free(9);
> }
>
> MODULE_LICENSE("GPL");
>
> module_init(sample_module_init);
> module_exit(sample_module_exit);
>
> It give the following O/P:
>
> [=A0 617.075329] sample_driver: unable to request GPIO_PG1
> [=A0 617.080418] sample_driver: unable to request GPIO_PG2
> [=A0 617.085470] sample_driver: unable to request GPIO_PG3
> [=A0 617.090522] sample_driver: unable to request GPIO_PG4
> [=A0 617.095574] sample_driver: unable to request GPIO_PG5
> [=A0 617.100625] sample_driver: unable to request GPIO_PG6
> [=A0 617.105676] sample_driver: unable to request GPIO_PG7
> [=A0 617.110727] sample_driver: unable to request GPIO_PG8
> [=A0 617.115779] sample_driver: unable to request GPIO_PG9
> [=A0 617.120830] sample_driver: unable to request GPIO_PG10
> [=A0 617.125968] sample_driver: unable to request GPIO_PG11
> [=A0 617.131106] sample_driver: unable to request GPIO_PG12
> [=A0 617.136245] sample_driver: unable to request GPIO_PG13
> [=A0 617.141383] sample_driver: unable to request GPIO_PG14
> [=A0 617.146521] sample_driver: unable to request GPIO_PG15
> [=A0 617.151660] sample_driver: unable to request GPIO_PG16
> [=A0 617.156798] sample_driver: unable to request GPIO_PG17
> [=A0 617.161936] sample_driver: unable to request GPIO_PG18
> [=A0 617.167074] sample_driver: unable to request GPIO_PG19
> [=A0 617.172213] sample_driver: unable to request GPIO_PG20
> [=A0 617.177351] sample_driver: unable to request GPIO_PG21
> [=A0 617.182489] sample_driver: unable to request GPIO_PG22
> [=A0 617.187628] sample_driver: unable to request GPIO_PG23
> [=A0 617.192767] sample_driver: unable to request GPIO_PG24
> [=A0 617.197905] sample_driver: unable to request GPIO_PG25
> [=A0 617.203042] sample_driver: unable to request GPIO_PG26
> [=A0 617.208182] sample_driver: unable to request GPIO_PG27
> [=A0 617.213319] sample_driver: unable to request GPIO_PG28
> [=A0 617.218458] sample_driver: unable to request GPIO_PG29
> [=A0 617.223597] sample_driver: unable to request GPIO_PG30
> [=A0 617.228735] sample_driver: unable to request GPIO_PG31
> [=A0 617.233873] sample_driver: unable to request GPIO_PG32
>
> Can someone provide me a sample code or something else. Actually I am try=
ing
> to set the GPIO pin no. 9 to active low as it is connected to a LED on
> board.
>
> Thanks in advance
> Ravi Gupta
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
-mj
