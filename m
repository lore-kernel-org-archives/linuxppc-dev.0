Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E7DF2C0082
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2012 09:27:26 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return path
Date: Mon, 6 Aug 2012 23:27:18 +0000
Message-ID: <CAOZdJXWftkUSw57-Qbe9JFP9NwodkHprKr6_1xi6ZzzLN8A4wA@mail.gmail.com>
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2012 at 3:15 AM, Tiejun Chen <tiejun.chen@windriver.com> wr=
ote:
> We miss that correct WDIOC_GETSUPPORT return path when perform
> copy_to_user() properly.

Thanks for catching this.  I'm amazed that this driver still has bugs like =
this.

> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 3fe82d0..2be7f29 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -162,12 +162,13 @@ static long booke_wdt_ioctl(struct file *file,
>                                 unsigned int cmd, unsigned long arg)
>  {
>         u32 tmp =3D 0;
> -       u32 __user *p =3D (u32 __user *)arg;
> +       void __user *argp =3D (u32 __user *)arg;
> +       u32 __user *p =3D argp;

You don't need to create 'argp'.  The existing 'p' variable will work
in the copy_to_user() call.

> +               return copy_to_user(argp, &ident,
> +                               sizeof(ident)) ? -EFAULT : 0;

This can fit in one line, especially if you use 'p' instead of 'argp'.

--=20
Timur Tabi
Linux kernel developer at Freescale=
