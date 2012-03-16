Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1AFDFB6EF1
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 06:06:56 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc/8xxx: remove 85xx/86xx restrictions from
 fsl_guts.h
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1329412870-16716-1-git-send-email-timur@freescale.com>
Date: Fri, 16 Mar 2012 14:06:51 -0500
Message-Id: <177AB6E4-E148-43EE-BBD5-1348B6796EAA@kernel.crashing.org>
References: <1329412870-16716-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 16, 2012, at 11:21 AM, Timur Tabi wrote:

> Remove the check for CONFIG_PPC_85xx and CONFIG_PPC_86xx from =
fsl_guts.h.
> The check was originally intended to allow the same header file to
> be used on 85xx and 86xx systems, even though the Global Utilities
> register could be different.  It turns out that they're not actually
> different, and so the check is not necessary.  In addition, neither
> macro is defined for 64-bit e5500 kernels, so that causes a build
> break.
>=20
> To maintain backwards compatibility, we also define macros for
> ccsr_guts_85xx and ccsr_guts_86xx.  This eliminates the need to
> change all the files that #include fsl_guts.h.  Those files will
> be updated at a later time, and then the macros can be deleted.

If you are doing this clean, just finish it.  There are only a small =
handful of users of ccsr_guts_8{5,6}xx:

arch/powerpc/include/asm/fsl_guts.h:static inline void =
guts_set_dmacr(struct ccsr_guts_86xx __iomem *guts,
arch/powerpc/include/asm/fsl_guts.h:static inline void =
guts_set_pmuxcr_dma(struct ccsr_guts_86xx __iomem *guts,
arch/powerpc/platforms/86xx/mpc8610_hpcd.c:     struct ccsr_guts_86xx =
__iomem *guts;
arch/powerpc/platforms/85xx/p1022_ds.c: struct ccsr_guts_85xx __iomem =
*guts;
arch/powerpc/platforms/85xx/p1022_ds.c: struct ccsr_guts_85xx __iomem =
*guts;

- k
