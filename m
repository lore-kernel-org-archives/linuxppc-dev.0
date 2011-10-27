Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 29C08B6F90
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 05:28:31 +1100 (EST)
Subject: Re: Fix for fsl_upm
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4EA9683D.8030100@dev.rtsoft.ru>
Date: Thu, 27 Oct 2011 13:28:12 -0500
Message-Id: <4BF2BC2E-1596-42D1-A403-78A1FDBC9EAC@kernel.crashing.org>
References: <4EA9683D.8030100@dev.rtsoft.ru>
To: Rusev <arusev@dev.rtsoft.ru>
Cc: Shaohui.Xie@freescale.com, linux-kernel@vger.kernel.org,
 Shengzhou.Liu@freescale.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 27, 2011, at 9:18 AM, Rusev wrote:

> patch is vs. 2.6.39, yet it applied to 3.1
>=20
>=20
>=20
> Fix of UPM driver for Freescale PowerPC processors
>=20
> If Freescale LBC driver fails to initialise itself from device tree,
> then internal structure is freed only but not NULL-fied.
> As result functions fsl_lbc_find() after checking the structure is not =
NULL are
> trying to access device registers.
>=20
> Signed-off-by: Alexandre Rusev <arusev@dev.rtsoft.ru>=20
> --- linux-2.6.39.old/arch/powerpc/sysdev/fsl_lbc.c	2011-10-27 =
03:17:28.000000000 +0400
> +++ linux-2.6.39/arch/powerpc/sysdev/fsl_lbc.c	2011-10-27 =
05:06:44.000000000 +0400
> @@ -322,6 +322,7 @@ static int __devinit fsl_lbc_ctrl_probe(
> err:
> 	iounmap(fsl_lbc_ctrl_dev->regs);
> 	kfree(fsl_lbc_ctrl_dev);
> +	fsl_lbc_ctrl_dev =3D NULL;
> 	return ret;
> }
>=20

Can you send this as a proper patch.

- k
