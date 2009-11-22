Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id D44A0100801
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:46:05 +1100 (EST)
Received: by gxk23 with SMTP id 23so5472310gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:46:03 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-19-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-18-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-19-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:45:43 -0700
Message-ID: <fa686aa40911221545x6590b92gab4a1a9a48e9d920@mail.gmail.com>
Subject: Re: [RFC PATCH 18/19] powerpc: wii: platform support
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
> Add platform support for the Nintendo Wii video game console.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> ---
> +static int wii_setup_hw_resets(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 int error =3D -ENODEV;
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, HW_RESETS_OF_COM=
PATIBLE);
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("no compatible node found for %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HW_RESETS_OF_COMPATIBLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 error =3D of_address_to_resource(np, 0, &res);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("no valid reg found for %s\n", np->n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_put;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hw_resets =3D ioremap(res.start, res.end - res.start + 1);

Or you could use of_iomap() to cut out some code.

> + =A0 =A0 =A0 if (hw_resets) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("hw_resets at 0x%08x mapped to 0x%p=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start, hw_resets);
> + =A0 =A0 =A0 }
> +
> +out_put:
> + =A0 =A0 =A0 of_node_put(np);
> +out:
> + =A0 =A0 =A0 return error;
> +}
> +
> +static int wii_setup_hw_gpio(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 struct resource res;
> + =A0 =A0 =A0 const char *path;
> + =A0 =A0 =A0 int error =3D -ENODEV;
> +
> + =A0 =A0 =A0 np =3D of_find_node_by_name(NULL, "aliases");
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("unable to find node %s\n", "aliases=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 path =3D of_get_property(np, HW_GPIO_ALIAS, NULL);
> + =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 if (!path) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("alias %s unknown\n", HW_GPIO_ALIAS)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 np =3D of_find_node_by_path(path);
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("node for alias %s unknown\n", HW_GP=
IO_ALIAS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 error =3D of_address_to_resource(np, 0, &res);
> + =A0 =A0 =A0 if (error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("no valid reg found for %s\n", np->n=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_put;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 hw_gpio =3D ioremap(res.start, res.end - res.start + 1);
> + =A0 =A0 =A0 if (hw_gpio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("hw_gpio at 0x%08x mapped to 0x%p\n=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start, hw_gpio);
> + =A0 =A0 =A0 }
> +
> +out_put:
> + =A0 =A0 =A0 of_node_put(np);
> +out:
> + =A0 =A0 =A0 return error;
> +}
> +
> +static void wii_setup(void)
> +{
> + =A0 =A0 =A0 wii_setup_hw_resets();
> + =A0 =A0 =A0 wii_setup_hw_gpio();
> +}
> +
> +static void wii_restart(char *cmd)
> +{
> + =A0 =A0 =A0 local_irq_disable();
> +
> + =A0 =A0 =A0 if (hw_resets) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* clear the system reset pin to cause a re=
set */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(0, hw_resets);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 wii_spin();
> +}
> +
> +static void wii_power_off(void)
> +{
> + =A0 =A0 =A0 local_irq_disable();
> +
> + =A0 =A0 =A0 if (hw_gpio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* make sure that the poweroff GPIO is conf=
igured as output */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(hw_gpio + HW_GPIO_DIR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_be32(hw_gpio + HW_GPI=
O_DIR) | HW_GPIO_SHUTDOWN);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* drive the poweroff GPIO high */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(hw_gpio + HW_GPIO_OUT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0in_be32(hw_gpio + HW_GPI=
O_OUT) | HW_GPIO_SHUTDOWN);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 wii_spin();
> +}
> +
> +#else
> +
> +static void wii_setup(void)
> +{
> +}
> +
> +static void wii_restart(char *cmd)
> +{
> + =A0 =A0 =A0 wii_spin();
> +}
> +
> +static void wii_power_off(void)
> +{
> + =A0 =A0 =A0 wii_spin();
> +}
> +
> +#endif /* CONFIG_STARLET_MINI */
> +
> +static void wii_halt(void)
> +{
> + =A0 =A0 =A0 if (ppc_md.restart)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.restart(NULL);
> + =A0 =A0 =A0 wii_spin();
> +}
> +
> +static void wii_show_cpuinfo(struct seq_file *m)
> +{
> + =A0 =A0 =A0 seq_printf(m, "vendor\t\t: IBM\n");
> + =A0 =A0 =A0 seq_printf(m, "machine\t\t: Nintendo Wii\n");
> +}

Drop show_cpuinfo() hook.

> +static int wii_discover_ipc_flavour(void)
> +{
> + =A0 =A0 =A0 struct mipc_infohdr *hdrp;
> + =A0 =A0 =A0 int error;
> +
> + =A0 =A0 =A0 error =3D mipc_infohdr_get(&hdrp);
> + =A0 =A0 =A0 if (!error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mipc_infohdr_put(hdrp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 starlet_ipc_flavour =3D STARLET_IPC_MINI;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wii_setup();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.restart =3D wii_restart;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ppc_md.power_off =3D wii_power_off;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void __init wii_setup_arch(void)
> +{
> + =A0 =A0 =A0 ug_udbg_init();
> + =A0 =A0 =A0 wii_discover_ipc_flavour();
> +}
> +
> +static void __init wii_init_early(void)
> +{
> +}
> +
> +static int __init wii_probe(void)
> +{
> + =A0 =A0 =A0 unsigned long dt_root;
> +
> + =A0 =A0 =A0 dt_root =3D of_get_flat_dt_root();
> + =A0 =A0 =A0 if (!of_flat_dt_is_compatible(dt_root, "nintendo,wii"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static void wii_shutdown(void)
> +{
> + =A0 =A0 =A0 flipper_quiesce();
> +}
> +
> +#ifdef CONFIG_KEXEC
> +static int wii_machine_kexec_prepare(struct kimage *image)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void wii_machine_kexec(struct kimage *image)
> +{
> + =A0 =A0 =A0 default_machine_kexec(image);
> +}

Drop unnecessary hooks.  If no kexec hook it offered, then
default_machine_kexec() gets called anyway.

> +#endif /* CONFIG_KEXEC */

> +
> +define_machine(wii) {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "wii",
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D wii_probe,
> + =A0 =A0 =A0 .setup_arch =A0 =A0 =A0 =A0 =A0 =A0 =3D wii_setup_arch,
> + =A0 =A0 =A0 .init_early =A0 =A0 =A0 =A0 =A0 =A0 =3D wii_init_early,
> + =A0 =A0 =A0 .show_cpuinfo =A0 =A0 =A0 =A0 =A0 =3D wii_show_cpuinfo,
> + =A0 =A0 =A0 .halt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D wii_halt,
> + =A0 =A0 =A0 .init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D flipper_pic_probe=
,
> + =A0 =A0 =A0 .get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D flipper_pic_get=
_irq,
> + =A0 =A0 =A0 .calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr,
> + =A0 =A0 =A0 .progress =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D udbg_progress,
> + =A0 =A0 =A0 .machine_shutdown =A0 =A0 =A0 =3D wii_shutdown,
> +#ifdef CONFIG_KEXEC
> + =A0 =A0 =A0 .machine_kexec_prepare =A0=3D wii_machine_kexec_prepare,
> + =A0 =A0 =A0 .machine_kexec =A0 =A0 =A0 =A0 =A0=3D wii_machine_kexec,
> +#endif
> +};
> +
> diff --git a/arch/powerpc/platforms/embedded6xx/wii_dev.c b/arch/powerpc/=
platforms/embedded6xx/wii_dev.c
> new file mode 100644
> index 0000000..903063e
> --- /dev/null
> +++ b/arch/powerpc/platforms/embedded6xx/wii_dev.c
> @@ -0,0 +1,47 @@
> +/*
> + * arch/powerpc/platforms/embedded6xx/wii_dev.c
> + *
> + * Nintendo Wii platform device setup.
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
> +static struct of_device_id wii_of_bus[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "nintendo,hollywood", },
> +#ifdef CONFIG_STARLET_MINI
> + =A0 =A0 =A0 { .compatible =3D "twiizers,starlet-mini-ipc", },
> +#endif
> + =A0 =A0 =A0 { },
> +};
> +
> +static int __init wii_device_probe(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> +
> + =A0 =A0 =A0 if (!machine_is(wii))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 of_platform_bus_probe(NULL, wii_of_bus, NULL);
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "nintendo,hollyw=
ood-mem2");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_platform_device_create(np, NULL, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +device_initcall(wii_device_probe);

Why is this split into a separate file?  (Same comment goes for the
Gamecube version).  Just roll all the platform support into a single
file since there is no shared code.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
