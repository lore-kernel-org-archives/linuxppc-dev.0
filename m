Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C38D2B6FCC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 12:26:49 +1100 (EST)
Received: by dady9 with SMTP id y9so1268131dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Feb 2012 17:26:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1329865853-17277-1-git-send-email-paul.gortmaker@windriver.com>
References: <1329865853-17277-1-git-send-email-paul.gortmaker@windriver.com>
Date: Sun, 26 Feb 2012 20:26:47 -0500
Message-ID: <CAP=VYLroaEKncpy7VBobJdXijnDS5UdTV7qPG2A--SicnGvFSg@mail.gmail.com>
Subject: Re: [PATCH/RFC] rapidio: temporarily exclude FSL_RIO from 64 bit
 builds
From: Paul Gortmaker <paul.gortmaker@gmail.com>
To: benh@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gang.Liu@freescale.com, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Given a week has passed with the absence of any feedback
with respect to SRIO on 64 bit, are you OK with applying the
below patch[1] pretty much as-is?

Thanks,
Paul.

[1] http://patchwork.ozlabs.org/patch/142383/

---

On Tue, Feb 21, 2012 at 6:10 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> The following are seen while using the corenet64_smp_defconfig:
>
> arch/powerpc/sysdev/fsl_rmu.c:315: error: cast from pointer to integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:320: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:330: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:332: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:339: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:340: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:341: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:348: error: cast to pointer from integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:659: error: cast from pointer to integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:659: error: format '%8.8x' expects type 'un=
signed int', but argument 5 has type 'size_t'
> arch/powerpc/sysdev/fsl_rmu.c:985: error: cast from pointer to integer of=
 different size
> arch/powerpc/sysdev/fsl_rmu.c:997: error: cast to pointer from integer of=
 different size
>
> A quick inspection of the code leaves one with the impression
> that it was not explicitly written with 64 bit support in mind,
> so just block that as a possible config selection for now.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> ---
>
> [This is seen in linux-next -- not sure if this is the right way to go
> =A0but at least it will give the issue some visibility to the right ppl.]
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 75f061e..5ad8013 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -773,7 +773,7 @@ config RAPIDIO
>
> =A0config FSL_RIO
> =A0 =A0 =A0 =A0bool "Freescale Embedded SRIO Controller support"
> - =A0 =A0 =A0 depends on RAPIDIO && HAS_RAPIDIO
> + =A0 =A0 =A0 depends on RAPIDIO && HAS_RAPIDIO && (BROKEN || !PPC64)
> =A0 =A0 =A0 =A0default "n"
> =A0 =A0 =A0 =A0---help---
> =A0 =A0 =A0 =A0 =A0Include support for RapidIO controller on Freescale em=
bedded
> --
> 1.7.9.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
