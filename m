Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id BE294B6EEC
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 07:28:28 +1000 (EST)
Received: by vws20 with SMTP id 20so86195vws.15
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 14:28:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4B86E05A.1080705@freescale.com>
References: <4B86E05A.1080705@freescale.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 29 Jun 2010 16:27:57 -0500
Message-ID: <AANLkTimEt2YMXHtsHoqTCdfLW_vmTFl2PJNPV_eJy02m@mail.gmail.com>
Subject: Re: CONFIG_ISA_DMA_API without CONFIG_GENERIC_ISA_DMA
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2010 at 3:40 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> Commit fb4f0e8832e0075849b41b65f6bb9fdfa7593b99 (Enable GENERIC_ISA_DMA i=
f
> FSL_ULI1575 to fix compile issue) tries to deal with this, but it ties it=
 to
> CONFIG_FSL_ULI1575, which is not selected in a p4080ds-only config.
>
> It seems that ULI isn't really relevant to the actual problem, which is t=
hat
> we enable ISA DMA API support without selecting an implementation. =A0Whe=
ther
> a certain chip is on the board that has an actual ISA interface is
> irrelevant to the build breakage.
>
> Where did the dependency list for GENERIC_ISA_DMA come from? =A0Are there=
 any
> legitimate cases on powerpc where we want to select ISA_DMA_API but not
> GENERIC_ISA_DMA (i.e. we have an alternate implementation)?

I've been bitten by this issue as well on the P1022DS.  If I enable
ALSA, then some ISA support also gets compile (by itself, that's
probably a bug), and that code calls claim_dma_lock().

This problem's been around for a long time.  I would have encountered
it on the MPC8610 HPCD, but that board has an ULI 1575.  The P1022Ds
doesn't.

--=20
Timur Tabi
Linux kernel developer at Freescale
