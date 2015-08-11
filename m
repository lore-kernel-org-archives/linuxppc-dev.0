Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 575D61A1D04
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 04:25:52 +1000 (AEST)
Received: by pawu10 with SMTP id u10so169501592paw.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 11:25:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
 "Tang Yuantian" <Yuantian.Tang@freescale.com>
From: Michael Turquette <mturquette@linaro.org>
In-Reply-To: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "Liberman Igal-B31950" <Igal.Liberman@freescale.com>,
 "Bucur Madalin-Cristian-B32716" <madalin.bucur@freescale.com>,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, "Scott Wood" <scottwood@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
Message-ID: <20150811182535.31346.52965@quantum>
Subject: Re: [RFC PATCH 0/8] clk: qoriq: Move chip-specific knowledge into
 driver
Date: Tue, 11 Aug 2015 11:25:35 -0700
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

Quoting Scott Wood (2015-06-18 19:49:10)
> The existing device tree bindings are error-prone and inflexible. =

> Correct the mistake by moving the knowledge into the driver, which
> has more flexibility in describing the quirks of each chip.  This leaves
> the device tree to its proper role of identifying a programming interface
> rather than describing its individual registers.

Sorry for not responding to this one sooner. Fell through the cracks.

All of the changes to drives/clk/clk-qoriq.c look great to me. I assume
you need to keep all of these patches together and want to the take
through the freescale tree? If so feel free to add,

Acked-by: Michael Turquette <mturquette@baylibre.com>

Regards,
Mike

> =

> For more detail, see the commit message of patch 4.
> =

> Scott Wood (8):
>   ARM: dts: ls1021a: Fix clockgen node
>   cpufreq: qoriq: Don't look at clock implementation details
>   powerpc/fsl: Move fsl_guts.h out of arch/powerpc
>   clk: qoriq: Move chip-specific knowledge into driver
>   clk: qoriq: Redirect legacy clock nodes to new clocks
>   cpufreq: qoriq: Remove frequency masking and minimum
>   clk: qoriq: Expose OF clocks directly from the clockgen node
>   powerpc/fsl: Use new clockgen binding
> =

>  .../devicetree/bindings/clock/qoriq-clock.txt      |   57 +-
>  arch/arm/boot/dts/ls1021a.dtsi                     |    3 +
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |    4 +-
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |    8 +-
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   15 -
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   18 -
>  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |    8 +-
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   18 -
>  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |    8 +-
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   70 --
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   16 +-
>  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |    4 +-
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   18 -
>  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |    8 +-
>  arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |   50 +-
>  arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |   33 +-
>  arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |   16 -
>  arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |    4 +-
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   44 -
>  arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |    8 +-
>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |   22 -
>  arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |    8 +-
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |   61 -
>  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |   24 +-
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    2 +-
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |    2 +-
>  arch/powerpc/platforms/85xx/p1022_ds.c             |    2 +-
>  arch/powerpc/platforms/85xx/p1022_rdk.c            |    2 +-
>  arch/powerpc/platforms/85xx/smp.c                  |    2 +-
>  arch/powerpc/platforms/85xx/twr_p102x.c            |    2 +-
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    2 +-
>  drivers/clk/clk-qoriq.c                            | 1191 ++++++++++++++=
++----
>  drivers/cpufreq/qoriq-cpufreq.c                    |  139 +--
>  drivers/iommu/fsl_pamu.c                           |    2 +-
>  .../asm/fsl_guts.h =3D> include/linux/fsl/guts.h     |    6 +-
>  sound/soc/fsl/mpc8610_hpcd.c                       |    2 +-
>  sound/soc/fsl/p1022_ds.c                           |    2 +-
>  sound/soc/fsl/p1022_rdk.c                          |    2 +-
>  38 files changed, 1107 insertions(+), 776 deletions(-)
>  rename arch/powerpc/include/asm/fsl_guts.h =3D> include/linux/fsl/guts.h=
 (98%)
> =

> -- =

> 2.1.4
>=20
