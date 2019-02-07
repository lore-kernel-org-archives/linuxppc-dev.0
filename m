Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BACC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:10:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D19C2147C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAUx0NNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D19C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5x00kZXzDqGB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:10:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WAUx0NNG"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w5vD4zhYzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 16:08:56 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id c25so3996592pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Feb 2019 21:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:references:in-reply-to:mime-version:user-agent
 :message-id:content-transfer-encoding;
 bh=tuoQwpUuw8hij5YiZ1uR/Fhfo9i1t/Ht9mL9Tpk+hDE=;
 b=WAUx0NNGGMyUf2Mkqx5HuaV39H9QBlI4uSD4P2cVrUCUXsIb5o1+iYmCLXBVRMcJ4J
 mutaRWhzZguH1ZfLmuwJYAz+gU26/KFr7vNfbthEiK7VOachecx/8zRfL0AMfo3fz7QO
 klDqUlD1Jp1OQZ+tWyi7o+2RRIVTf4Q0zI8Yj1tJES37Mn92z1k2QmJlAsva/G+w1kvq
 WFF1fi+tYkU2gimRCc5Lr9z/CKmZg0p5hMyxlZozjGGA0pEtdUDVOF3ogL3/mj+uQnDI
 GN9LXGcY97tc54k0SIZzzZMM3nOiF2+/bYZiL53CbT0Lx4jyb48VHkqIgAdftvjen6op
 S7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=tuoQwpUuw8hij5YiZ1uR/Fhfo9i1t/Ht9mL9Tpk+hDE=;
 b=m8U2OG6WCItAnmy3UFicRztr04C1KHL/xMHGBored/5+zxui/hK+l5Vx/WbApi0mB/
 +XmTc24q0wqRRbBoeBl9cguyf5yc01VAnH9IGggPw5Ypm9bQBsBvgEicmfZ+kTg6jNP1
 49hj9s6LdNlKFilvqwJpNx55N3flhGfz67SDMA+OEDWaikXwcqFJOBLw2TSWgOx9Hb4n
 EczFqwEoZjgcJ77TgA61Ppavh646BFTw2PRpQ6PSb7vg8PoFiRts66JFcfNAFA5zKkuF
 qAhkvR9yX9uEMqRJtxsduYUDkoJjYHn7CW1dRTj7+WDsmqaG9vJplAmKaG/VbHReG906
 Px8A==
X-Gm-Message-State: AHQUAuYK41WVbJKIeDuk4Ys6x2nOphOqojA23l9GqlnjXtzDjtZuZ1pa
 q2kH5Or+6Xz32V6zOy9MsQgDgzlj
X-Google-Smtp-Source: AHgI3IZ2u8TAYSQpPq6ChuxDv0NEXrXx8G0tw9hANpVl1H6X08NFTsG/l6GL7l9MDymeCKtimyJgzQ==
X-Received: by 2002:a63:105a:: with SMTP id 26mr3274243pgq.184.1549516134192; 
 Wed, 06 Feb 2019 21:08:54 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id v11sm1240723pfa.49.2019.02.06.21.08.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 21:08:53 -0800 (PST)
Date: Thu, 07 Feb 2019 15:08:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>
References: <20190206062837.26917-1-ruscur@russell.cc>
In-Reply-To: <20190206062837.26917-1-ruscur@russell.cc>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549515373.con208q1rq.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey's on February 6, 2019 4:28 pm:
> Without restoring the IAMR after idle, execution prevention on POWER9
> with Radix MMU is overwritten and the kernel can freely execute userspace=
 without
> faulting.
>=20
> This is necessary when returning from any stop state that modifies user
> state, as well as hypervisor state.
>=20
> To test how this fails without this patch, load the lkdtm driver and
> do the following:
>=20
>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
>=20
> which won't fault, then boot the kernel with powersave=3Doff, where it
> will fault.  Applying this patch will fix this.
>=20
> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
> space")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Good catch and debugging. This really should be a quirk, we don't want=20
to have to restore this thing on a thread switch.

Can we put it under a CONFIG option if we're not using IAMR?

> ---
>  arch/powerpc/include/asm/cpuidle.h |  1 +
>  arch/powerpc/kernel/asm-offsets.c  |  1 +
>  arch/powerpc/kernel/idle_book3s.S  | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/as=
m/cpuidle.h
> index 43e5f31fe64d..ad67dbe59498 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -77,6 +77,7 @@ struct stop_sprs {
>  	u64 mmcr1;
>  	u64 mmcr2;
>  	u64 mmcra;
> +	u64 iamr;
>  };
> =20
>  #define PNV_IDLE_NAME_LEN    16
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 9ffc72ded73a..10e0314c2b0d 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -774,6 +774,7 @@ int main(void)
>  	STOP_SPR(STOP_MMCR1, mmcr1);
>  	STOP_SPR(STOP_MMCR2, mmcr2);
>  	STOP_SPR(STOP_MMCRA, mmcra);
> +	STOP_SPR(STOP_IAMR, iamr);
>  #endif
> =20
>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle=
_book3s.S
> index 7f5ac2e8581b..bb4f552f6c7e 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -200,6 +200,12 @@ pnv_powersave_common:
>  	/* Continue saving state */
>  	SAVE_GPR(2, r1)
>  	SAVE_NVGPRS(r1)
> +
> +BEGIN_FTR_SECTION
> +	mfspr	r5, SPRN_IAMR
> +	std	r5, STOP_IAMR(r13)
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +
>  	mfcr	r5
>  	std	r5,_CCR(r1)
>  	std	r1,PACAR1(r13)
> @@ -924,6 +930,13 @@ BEGIN_FTR_SECTION
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
>  	REST_NVGPRS(r1)
>  	REST_GPR(2, r1)
> +
> +BEGIN_FTR_SECTION
> +	ld	r4, STOP_IAMR(r13)
> +	mtspr	SPRN_IAMR, r4
> +	isync
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)

Sigh, good old isync. Suspect you'll get away without it, mtmsrd L=3D0=20
just below is architecturally guaranteeing a CSI, so just add a comment=20
there, might save a flush.

> +
>  	ld	r4,PACAKMSR(r13)
>  	ld	r5,_LINK(r1)
>  	ld	r6,_CCR(r1)
> @@ -946,6 +959,13 @@ pnv_wakeup_noloss:
>  BEGIN_FTR_SECTION
>  	CHECK_HMI_INTERRUPT
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> +
> +BEGIN_FTR_SECTION
> +	ld	r4, STOP_IAMR(r13)
> +	mtspr	SPRN_IAMR, r4
> +	isync
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)

For the noloss part, it should mean really nothing lost including GPRs,=20
so I think IAMR *should* be okay here.

Thanks,
Nick
=
