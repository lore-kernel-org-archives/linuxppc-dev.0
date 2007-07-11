Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] do firmware feature fixups after features are initialised
In-reply-to: <200707111329.51580.arnd@arndb.de> 
References: <9094.1181275235@neuling.org>
	<1184149691.6059.82.camel@localhost.localdomain>
	<200707111329.51580.arnd@arndb.de>
Date: Wed, 11 Jul 2007 18:23:45 -0500
Message-ID: <27356.1184196225@neuling.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <200707111329.51580.arnd@arndb.de> you wrote:
> On Wednesday 11 July 2007, Benjamin Herrenschmidt wrote:
> > There are two possibly solutions I see in the long run:
> > =
> 
> > =A0- We could set the FW features earlier on pseries, though that is a bit
> > annoying because that means doing it before the device-tree is
> > unflattened.
> > =
> 
> > =A0- We could constraint lmb_alloc to the first segment until the FW fixup
> > occurs, either within lmb_alloc itself, or fixup the callers such as
> > unflatten_device_tree, to pass an explicit limit.
> > =
> 
> > What do you think ?
> 
> If I'm understanding this right, the first solution should be something
> along the lines of the patch below (not tested), which even removes
> more lines than it adds. It doesn't seem that annoying to me, and it
> makes sense to assume that the fw_features are set up after returning
> from the ppc_md probe.

I'm not sure this patch is going to work as the do_feature_fixups isn't
called any earlier?

Mikey

> 
> 	Arnd <><
> 
> Index: linux-2.6/arch/powerpc/platforms/pseries/setup.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/pseries/setup.c
> +++ linux-2.6/arch/powerpc/platforms/pseries/setup.c
> @@ -327,8 +327,6 @@ static void __init pSeries_init_early(vo
>  {
>  	DBG(" -> pSeries_init_early()\n");
>  =
> 
> -	fw_feature_init();
> -
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
>  		find_udbg_vterm();
>  =
> 
> @@ -350,14 +348,21 @@ static int __init pSeries_probe_hypertas
>  					 const char *uname, int depth,
>  					 void *data)
>  {
> +	const char *hypertas;
> +	unsigned long len;
> +
>  	if (depth !=3D 1 ||
>  	    (strcmp(uname, "rtas") !=3D 0 && strcmp(uname, "rtas@0") !=3D 0))
> - 		return 0;
> +		return 0;
> +
> +	hypertas =3D of_get_flat_dt_prop(node, "ibm,hypertas-functions", &len);
> +	if (!hypertas)
> +		return 1;
>  =
> 
> -	if (of_get_flat_dt_prop(node, "ibm,hypertas-functions", NULL) !=3D NULL
)
> - 		powerpc_firmware_features |=3D FW_FEATURE_LPAR;
> +	powerpc_firmware_features |=3D FW_FEATURE_LPAR;
> +	fw_feature_init(hypertas, len);
>  =
> 
> - 	return 1;
> +	return 1;
>  }
>  =
> 
>  static int __init pSeries_probe(void)
> Index: linux-2.6/arch/powerpc/platforms/pseries/pseries.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/platforms/pseries/pseries.h
> +++ linux-2.6/arch/powerpc/platforms/pseries/pseries.h
> @@ -10,7 +10,7 @@
>  #ifndef _PSERIES_PSERIES_H
>  #define _PSERIES_PSERIES_H
>  =
> 
> -extern void __init fw_feature_init(void);
> +extern void __init fw_feature_init(const char *, unsigned long);
>  =
> 
>  struct pt_regs;
>  =
> 
> diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platf=
> orms/pseries/firmware.c
> index 29bf83b..b0c8dbd 100644
> --- a/arch/powerpc/platforms/pseries/firmware.c
> +++ b/arch/powerpc/platforms/pseries/firmware.c
> @@ -66,24 +66,14 @@ firmware_features_table[FIRMWARE_MAX_FEATURES] =3D {
>   * device-tree/ibm,hypertas-functions.  Ultimately this functionality may
>   * be moved into prom.c prom_init().
>   */
> -void __init fw_feature_init(void)
> +void __init fw_feature_init(const char *hypertas, unsigned long len)
>  {
>  	struct device_node *dn;
>  	const char *hypertas, *s;
> -	int len, i;
> +	int i;
>  =
> 
>  	DBG(" -> fw_feature_init()\n");
>  =
> 
> -	dn =3D of_find_node_by_path("/rtas");
> -	if (dn =3D=3D NULL) {
> -		printk(KERN_ERR "WARNING! Cannot find RTAS in device-tree!\n");
> -		goto out;
> -	}
> -
> -	hypertas =3D of_get_property(dn, "ibm,hypertas-functions", &len);
> -	if (hypertas =3D=3D NULL)
> -		goto out;
> -
>  	for (s =3D hypertas; s < hypertas + len; s +=3D strlen(s) + 1) {
>  		for (i =3D 0; i < FIRMWARE_MAX_FEATURES; i++) {
>  			/* check value against table of strings */
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
