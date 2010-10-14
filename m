Return-Path: <pku.leo@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 75F92B70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 21:08:45 +1100 (EST)
Received: by wyb32 with SMTP id 32so4760107wyb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 03:08:42 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1286971256-22878-1-git-send-email-harninder.rai@freescale.com>
References: <1286971256-22878-1-git-send-email-harninder.rai@freescale.com>
Date: Thu, 14 Oct 2010 18:08:42 +0800
Message-ID: <AANLkTinbL7Fq-FVc9Kg7pix9p6fAb2RmYah_BjjucPhA@mail.gmail.com>
Subject: Re: [PATCH][v2] powerpc/fsl: 85xx: add cache-sram support
From: Li Yang <leoli@freescale.com>
To: harninder.rai@freescale.com, Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Vivek Mahajan <vivek.mahajan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Oct 13, 2010 at 8:00 PM,  <harninder.rai@freescale.com> wrote:
> From: Harninder Rai <harninder.rai@freescale.com>
>
> It adds cache-sram support in P1/P2 QorIQ platforms as under:
>
> =C2=A0 =C2=A0* A small abstraction over powerpc's remote heap allocator
> =C2=A0 =C2=A0* Exports mpc85xx_cache_sram_alloc()/free() APIs
> =C2=A0 =C2=A0* Supports only one contiguous SRAM window
> =C2=A0 =C2=A0* Drivers can do the following in Kconfig to use these APIs
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"select FSL_85XX_CACHE_SRAM if MPC85xx"

You are missing the definition of this option in Kconfig like:

+config FSL_85XX_CACHE_SRAM
+       bool
+       select PPC_LIB_RHEAP
+

The select won't work actually.

Furthermore, MPC85xx config has been changed to FSL_SOC_BOOKE

- Leo
