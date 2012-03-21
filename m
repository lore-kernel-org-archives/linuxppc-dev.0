Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 76CBBB6FEF
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 04:22:26 +1100 (EST)
Subject: Re: [PATCH] [v3] powerpc/8xxx: remove 85xx/86xx restrictions from
 fsl_guts.h
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332173199-25877-1-git-send-email-timur@freescale.com>
Date: Wed, 21 Mar 2012 12:22:12 -0500
Message-Id: <7B496830-BF31-451E-9BE6-BB2FEE9B5BD0@kernel.crashing.org>
References: <1332173199-25877-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
 broonie@opensource.wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 19, 2012, at 11:06 AM, Timur Tabi wrote:

> Remove the check for CONFIG_PPC_85xx and CONFIG_PPC_86xx from =
fsl_guts.h.
> The check was originally intended to allow the same header file to
> be used on 85xx and 86xx systems, even though the Global Utilities
> register could be different.  It turns out that they're not actually
> different, and so the check is not necessary.  In addition, neither
> macro is defined for 64-bit e5500 kernels, so that causes a build
> break.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> The ASoC part of this patch applies cleanly to the ASoC for-3.4 =
branch,
> so this patch should not cause any merge conflicts if carried on the
> PowerPC branch, so I suggest that Kumar pick this up for 3.4 (it fixes =
a
> potential 64-bit book-e build break), with an ACK from Mark.=20
>=20
> arch/powerpc/include/asm/fsl_guts.h        |   26 =
+++++---------------------
> arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
> arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |    2 +-
> arch/powerpc/platforms/85xx/p1022_ds.c     |    4 ++--
> arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    2 +-
> sound/soc/fsl/mpc8610_hpcd.c               |    8 ++++----
> sound/soc/fsl/p1022_ds.c                   |   10 +++++-----
> 7 files changed, 19 insertions(+), 35 deletions(-)

applied

- k=
