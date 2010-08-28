Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id CF7A6B710E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Aug 2010 08:34:20 +1000 (EST)
Received: by iwn4 with SMTP id 4so3663921iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Aug 2010 15:34:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1282946147-28164-1-git-send-email-msm@freescale.com>
References: <1282946147-28164-1-git-send-email-msm@freescale.com>
Date: Sat, 28 Aug 2010 17:34:18 -0500
Message-ID: <AANLkTimYz6v2tMJRYnki9Ph33HL9yGsOcpgJ78LTDCTG@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl_soc: Search all global-utilities nodes for
	rstccr
From: Timur Tabi <timur.tabi@gmail.com>
To: Matthew McClintock <msm@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> <msm@freescale.com> wrote:

> +
> + =A0 =A0 =A0 for_each_node_by_name(np, "global-utilities") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((of_get_property(np, "fsl,has-rstcr", N=
ULL))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rstcr =3D of_iomap(np, 0) +=
 0xb0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rstcr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk (KER=
N_EMERG "Error: reset control "

I'm not sure KERN_EMERG is warranted for this kind of error.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "register not mapped!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

So if a node has an fsl,rstcr property, but the of_iomap() fails, we
jump to the next global-utilities node?  Perhaps you need a 'break'
after the printk()?

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!rstcr && ppc_md.restart =3D=3D fsl_rstcr_restart)

Wouldn't it make more sense to assign fsl_rstcr_restart to
ppc_md.restart only if we find a valid fsl,has-rstcr property?

--=20
Timur Tabi
Linux kernel developer at Freescale
