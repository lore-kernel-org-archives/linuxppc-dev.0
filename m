Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D38E61A0312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 18:54:08 +1100 (AEDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/3] rheap: move rheap.c from arch/powerpc/lib/ to lib/
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1411613237-2271-2-git-send-email-B45475@freescale.com>
Date: Fri, 17 Oct 2014 09:53:55 +0200
Message-Id: <57D1E2E0-077A-4CBE-8534-5B9EE5C81BAE@kernel.crashing.org>
References: <1411613237-2271-1-git-send-email-B45475@freescale.com>
 <1411613237-2271-2-git-send-email-B45475@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Cc: B07421@freescale.com, R63061@freescale.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 25, 2014, at 4:47 AM, Zhao Qiang <B45475@freescale.com> wrote:

> qe need to use the rheap, so move it to public directory.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> arch/powerpc/Kconfig                                    | 3 ---
> arch/powerpc/include/asm/fsl_85xx_cache_sram.h          | 2 +-
> arch/powerpc/lib/Makefile                               | 2 --
> arch/powerpc/platforms/44x/Kconfig                      | 2 +-
> arch/powerpc/platforms/85xx/Kconfig                     | 2 +-
> arch/powerpc/platforms/Kconfig                          | 2 +-
> arch/powerpc/platforms/Kconfig.cputype                  | 2 +-
> arch/powerpc/sysdev/cpm1.c                              | 2 +-
> arch/powerpc/sysdev/cpm2.c                              | 2 +-
> arch/powerpc/sysdev/cpm_common.c                        | 2 +-
> arch/powerpc/sysdev/ppc4xx_ocm.c                        | 2 +-
> drivers/dma/bestcomm/Kconfig                            | 2 +-
> drivers/soc/qe/Kconfig                                  | 2 +-
> drivers/soc/qe/qe.c                                     | 2 +-
> drivers/soc/qe/qe_common.c                              | 2 +-
> drivers/video/Kconfig                                   | 2 +-
> include/linux/fsl/bestcomm/sram.h                       | 2 +-
> {arch/powerpc/include/asm =3D> include/linux/fsl}/rheap.h | 0
> lib/Kconfig                                             | 3 +++
> lib/Makefile                                            | 2 ++
> {arch/powerpc/lib =3D> lib}/rheap.c                       | 2 +-
> 21 files changed, 21 insertions(+), 21 deletions(-)
> rename {arch/powerpc/include/asm =3D> include/linux/fsl}/rheap.h =
(100%)
> rename {arch/powerpc/lib =3D> lib}/rheap.c (99%)

Have you guys looked at moving to lib/genalloc.c.  If we are going to =
keep rheap around the include should be just in include/linux/rheap.h =
not include/linux/fsl/rheap.h

However, I think genalloc should be used and kill off rheap usage.

- k=
