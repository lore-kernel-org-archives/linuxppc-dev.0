Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id D542810080F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:34:55 +1100 (EST)
Received: by gxk23 with SMTP id 23so5467364gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:34:53 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:34:33 -0700
Message-ID: <fa686aa40911221534m6fcf14b3ted9dd181a0e264e4@mail.gmail.com>
Subject: Re: [RFC PATCH 12/19] powerpc: gamecube: platform support
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> w=
rote:
> Add platform support for the Nintendo GameCube video game console.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
> +static void gamecube_show_cpuinfo(struct seq_file *m)
> +{
> + =A0 =A0 =A0 seq_printf(m, "vendor\t\t: IBM\n");
> + =A0 =A0 =A0 seq_printf(m, "machine\t\t: Nintendo GameCube\n");
> +}

show_cpuinfo hooks have been dropped on most platforms now.

> +static void gamecube_shutdown(void)
> +{
> + =A0 =A0 =A0 /* currently not used */
> +}

Then don't add the hook.  Just drop it.  Same for other empty
functions in this file.  If it is safe to drop them, then please do.

Otherwise: Acked-by: Grant Likely <grant.likely@secretlab.ca>

> +define_machine(gamecube) {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "gamecube",
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D gamecube_prob=
e,
> + =A0 =A0 =A0 .setup_arch =A0 =A0 =A0 =A0 =A0 =A0 =3D gamecube_setup_arch=
,
> + =A0 =A0 =A0 .init_early =A0 =A0 =A0 =A0 =A0 =A0 =3D gamecube_init_early=
,
> + =A0 =A0 =A0 .show_cpuinfo =A0 =A0 =A0 =A0 =A0 =3D gamecube_show_cpuinfo=
,
> + =A0 =A0 =A0 .restart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D gamecube_restar=
t,
> + =A0 =A0 =A0 .power_off =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D gamecube_power_of=
f,
> + =A0 =A0 =A0 .halt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D gamecube_halt=
,
> + =A0 =A0 =A0 .init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D flipper_pic_probe=
,
> + =A0 =A0 =A0 .get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D flipper_pic_get=
_irq,
> + =A0 =A0 =A0 .calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr,
> + =A0 =A0 =A0 .progress =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D udbg_progress,
> + =A0 =A0 =A0 .machine_shutdown =A0 =A0 =A0 =3D gamecube_shutdown,
> +#ifdef CONFIG_KEXEC
> + =A0 =A0 =A0 .machine_kexec_prepare =A0=3D gamecube_kexec_prepare,
> + =A0 =A0 =A0 .machine_kexec =A0 =A0 =A0 =A0 =A0=3D default_machine_kexec=
,
> +#endif
> +};
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/gamecube_dev.c b/arch/pow=
erpc/platforms/embedded6xx/gamecube_dev.c
> new file mode 100644
> index 0000000..13e1f73
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/gamecube_dev.c
> @@ -0,0 +1,34 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/gamecube_dev.c
> + *
> + * Nintendo GameCube platform device setup.
> + * Copyright (C) 2008-2009 The GameCube Linux Team
> + * Copyright (C) 2008,2009 Albert Herranz
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/machdep.h>
> +
> +static struct of_device_id gamecube_of_bus[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "nintendo,flipper", },
> + =A0 =A0 =A0 { },
> +};
> +
> +static int __init gamecube_device_probe(void)
> +{
> + =A0 =A0 =A0 if (!machine_is(gamecube))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 of_platform_bus_probe(NULL, gamecube_of_bus, NULL);
> + =A0 =A0 =A0 return 0;
> +}
> +device_initcall(gamecube_device_probe);
> --
> 1.6.3.3
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
