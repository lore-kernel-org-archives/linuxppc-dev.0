Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B7EBB6F99
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 03:17:36 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Fan Zhicheng-B32736 <B32736@freescale.com>
Subject: Re: [PATCH 1/2 v2] P1025RDB: Add Quicc Engine support
Date: Thu, 9 Feb 2012 16:17:29 +0000
Message-ID: <CAOZdJXV-8f+_0FF2w7rG=xY3euxv9=G-O5z5v8pbCrs4ax8N3A@mail.gmail.com>
References: <1328694779-24024-1-git-send-email-B32736@freescale.com>
 <1328694779-24024-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1328694779-24024-2-git-send-email-B32736@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#ifdef CONFIG_QUICC_ENGINE
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 qe_ic_casca=
de_high_mpic);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Could not find qe-ic node\n");

Since you have to use pr_err instead of dev_err, please add a prefix
to the message.  Like this:

pr_err("mpc85xx-rdb: could not find qe-ic node\n");

or maybe something like this:

pr_err("%s: could not find qe-ic node\n", __func__);


> + =A0 =A0 =A0 if (machine_is(p1025_rdb)) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __be32 __iomem *pmuxcr;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 np =3D of_find_node_by_name(NULL, "global-u=
tilities");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmuxcr =3D of_iomap(np, 0) =
+ MPC85xx_PMUXCR_OFFSET;

Use the ccsr_guts_85xx structure instead of hard-coded offsets.

MPC85xx_PMUXCR_OFFSET should be deleted.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pmuxcr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(KERN=
_EMERG "Error: Alternate function"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 " signal multiplex control register not"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 " mapped!\n");

A missing node in the device tree is NOT an emergency.  Also, the
KERN_xxx macros are not supposed to be used in a pr_xxx macro.  Please
don't blindly copy/paste code from somewhere else without thinking
about it.

--=20
Timur Tabi
Linux kernel developer at Freescale=
