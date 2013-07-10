Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0FE9A2C02FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 07:48:25 +1000 (EST)
Date: Wed, 10 Jul 2013 16:48:13 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
 detection
To: Haijun Zhang <Haijun.Zhang@freescale.com>
In-Reply-To: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Wed Jul 10 02:39:01 2013)
Message-ID: <1373492893.8183.236@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>, linux-mmc@vger.kernel.org,
 r39252@freescale.com, AFLEMING@freescale.com,
 Haijun Zhang <Haijun.Zhang@freescale.com>, cbouatmailru@gmail.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2013 02:39:01 AM, Haijun Zhang wrote:
> +/* Get current SOC Version */
> +#define GET_SVR()	(mfspr(SPRN_SVR))

Unnecessary parens.  Why do we need GET_SVR(), versus opencoding it?  =20
Note that U-Boot (which this is patterned after) doesn't have =20
GET_SVR(), so code that wants to work on both can't use it anyway.

> +#define IS_SVR_REV(svr, maj, min) \
> +	((SVR_MAJ(svr) =3D=3D (maj)) && (SVR_MIN(svr) =3D=3D (min)))

I don't think IS_SVR_REV is needed.  Callers can just do "if =20
(SVR_REV(svr) =3D=3D 0x30)" or whatever, especially since we're relying on =
=20
them to do this for greater/less than comparisons.

-Scott=
