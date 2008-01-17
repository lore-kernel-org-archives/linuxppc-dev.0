Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id C95CDDDDF2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 09:36:20 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 2/7] powerpc: allow localbus compatible serial ports for
	console device
Date: Thu, 17 Jan 2008 23:35:48 +0100
References: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
	<200801071704.23151.arnd@arndb.de>
	<20080117220357.GC4122@windriver.com>
In-Reply-To: <20080117220357.GC4122@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801172335.48817.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 January 2008, Paul Gortmaker wrote:
> +struct serial_parent {
> +=A0=A0=A0=A0=A0=A0=A0char *type;
> +=A0=A0=A0=A0=A0=A0=A0char *compat;
> +};
> +
> +static struct __init serial_parent parents[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{"soc", NULL},
> +=A0=A0=A0=A0=A0=A0=A0{"tsi-bridge", NULL},
> +=A0=A0=A0=A0=A0=A0=A0{"opb", "ibm,opb"},
> +=A0=A0=A0=A0=A0=A0=A0{NULL, "wrs,epld-localbus"},
> +};
> +
> +#define NUM_PARENTS sizeof(parents)/sizeof(struct serial_parent)
<snip>
> +       for (sp =3D parents; sp !=3D end; sp++) {
> +               for_each_compatible_node(np, "serial", "ns16550") {
> +                       struct device_node *parent =3D of_get_parent(np);
> +                       int p_type_ok =3D 0, p_is_compat =3D 0;
> +                       if (!parent)
> +                               continue;
> +                       if (sp->type && !strcmp(parent->type, sp->type))
> +                               p_type_ok =3D 1;
> +                       if (sp->compat && of_device_is_compatible(parent,
> sp->compat)) +                               p_is_compat =3D 1;
> +                       if (p_type_ok || p_is_compat) {
> +                               index =3D add_legacy_soc_port(np, np);
> +                               if (index >=3D 0 && np =3D=3D stdout)
> +                                       legacy_serial_console =3D index;
> +                       }
> +                       of_node_put(parent);

I think you can express that more densely using struct of_device_id
and of_match_node(). Otherwise, it looks good to me, thanks a lot
for following up on my suggestion!

	Arnd <><
