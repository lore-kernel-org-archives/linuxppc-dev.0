Return-Path: <SRS0=2Civ=J7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16CC433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 10:14:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A762461164
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 10:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A762461164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZG126ks4z2yyt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 May 2021 20:14:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ntW8xcKQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b;
 helo=mail-pl1-x62b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ntW8xcKQ; dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZG0Y28J5z2xy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 May 2021 20:14:18 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id h7so4590954plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 May 2021 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=G4WSnegt7sWFXhiZUo/H8mFA8YOfhqB3H/FcAZj7hT8=;
 b=ntW8xcKQmgkUHISGAF4IzI224Ye5tabfMbPJRLiGbqY7Rr3tclDi+8u7+XIWZyZtp8
 W+24vVGh+Kb8PFB+eQPqOIeCNFJpo0a340nCJBRd3HIg5i0kBMtxTV6QbGjpSw5VUzPr
 Es0CARIQQfdBNbktqpmur+D+QCZX0ULZyXeGUbQHEgula8cLINk5YZ7mFyfkirrg/Xr7
 yDKIvXXPAtuNV4KAYn+xfXt2c4rFpKGP7HswvwXxlMCQtAfrysEUsciTLeiOxAc/wAEc
 U5TiqfL3po4tzJvQhJDbGhCfniUbK7Mchh6W4VAF1acttTlXf3QjdwcGFm0jCXD8cv2+
 PPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=G4WSnegt7sWFXhiZUo/H8mFA8YOfhqB3H/FcAZj7hT8=;
 b=ueIDO3xMwFs3A4+H28bzbZaRhL8c5Hci54JSzQtzK099B7qP7Z+IqYzYw9kssQTz+N
 qGXqJLHrvqtJLzGtRI9TmplIPw7POj/c5an/zdB4m64huGdwcFrgznvjSKyHWkWCzUrQ
 LGTIxc4Kpe2rPzMgQmom4BXkk6irrnwuFTpMgiWThXODhH1uPdEu/86bu2wP+kClVW/+
 lIrm85KRkwVtQRr/VRshVevRUgpfHhBLqndaDE3+dbF9PTcVH6ifq74caO1E67AfA8uI
 LOEM15HVC7ZgdesYLX+qpRbfQnkdCS8MeEkWDRt8cLEJ/vQg5MYeSTItNJpdu50W5hNo
 2cWQ==
X-Gm-Message-State: AOAM531mhAeRuS4pQODC5l0K8DBNBGNh1K0BXNCXp21qxvJzPwl8hOUC
 26QlraVnQvCjSaOepMcoK3s=
X-Google-Smtp-Source: ABdhPJxdWLerj3PVzICFvrxooqDo1msdzSUrDqhSN6Tldy17O34vbf0IFxgXhrojl9ihycNwkeo44w==
X-Received: by 2002:a17:902:c211:b029:ed:7a6b:d4bf with SMTP id
 17-20020a170902c211b02900ed7a6bd4bfmr25144155pll.63.1620123255583; 
 Tue, 04 May 2021 03:14:15 -0700 (PDT)
Received: from localhost ([61.68.127.20])
 by smtp.gmail.com with ESMTPSA id b1sm3120712pgf.84.2021.05.04.03.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 03:14:15 -0700 (PDT)
Date: Tue, 04 May 2021 20:14:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/asm-offset: Remove unused items related to
 paca
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <f38728dbe96df5fef84c868640def5f6d7c114bc.1620060357.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f38728dbe96df5fef84c868640def5f6d7c114bc.1620060357.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1620121538.q0b7uiea5y.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christophe Leroy's message of May 4, 2021 2:46 am:
> PACA_SIZE, PACACONTEXTID, PACALOWSLICESPSIZE, PACAHIGHSLICEPSIZE,
> PACA_SLB_ADDR_LIMIT, MMUPSIZEDEFSIZE, PACASLBCACHE, PACASLBCACHEPTR,
> PACASTABRR, PACAVMALLOCSLLP, MMUPSIZESLLP, PACACONTEXTSLLP,
> PACALPPACAPTR, LPPACA_DTLIDX and PACA_DTL_RIDX are not used anymore
> by ASM code.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Also I think SIGSEGV, NMI_MASK, THREAD_DBCR0, KUAP?, TI_FLAGS,
TI_PREEMPT, [ID]CACHEL1*, STACK_REGS_KUAP, EXC_LVL_SIZE, KVM_NEED_FLUSH,=20
KVM_FWNMI, VCPU_DEC, VCPU_SPMC, HSTATE_XICS_PHYS, HSTATE_SAVED_XIRR,
PPC_DBELL_MSGTYPE I think. While we're cleaning it up.

>=20
> Remove them.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/asm-offsets.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 28af4efb4587..419ab4a89114 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -197,7 +197,6 @@ int main(void)
>  	OFFSET(ICACHEL1LOGBLOCKSIZE, ppc64_caches, l1i.log_block_size);
>  	OFFSET(ICACHEL1BLOCKSPERPAGE, ppc64_caches, l1i.blocks_per_page);
>  	/* paca */
> -	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
>  	OFFSET(PACAPACAINDEX, paca_struct, paca_index);
>  	OFFSET(PACAPROCSTART, paca_struct, cpu_start);
>  	OFFSET(PACAKSAVE, paca_struct, kstack);
> @@ -212,15 +211,6 @@ int main(void)
>  	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
>  	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
>  	OFFSET(PACA_FTRACE_ENABLED, paca_struct, ftrace_enabled);
> -#ifdef CONFIG_PPC_BOOK3S
> -	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
> -#ifdef CONFIG_PPC_MM_SLICES
> -	OFFSET(PACALOWSLICESPSIZE, paca_struct, mm_ctx_low_slices_psize);
> -	OFFSET(PACAHIGHSLICEPSIZE, paca_struct, mm_ctx_high_slices_psize);
> -	OFFSET(PACA_SLB_ADDR_LIMIT, paca_struct, mm_ctx_slb_addr_limit);
> -	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
> -#endif /* CONFIG_PPC_MM_SLICES */
> -#endif
> =20
>  #ifdef CONFIG_PPC_BOOK3E
>  	OFFSET(PACAPGD, paca_struct, pgd);
> @@ -241,21 +231,9 @@ int main(void)
>  #endif /* CONFIG_PPC_BOOK3E */
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> -	OFFSET(PACASLBCACHE, paca_struct, slb_cache);
> -	OFFSET(PACASLBCACHEPTR, paca_struct, slb_cache_ptr);
> -	OFFSET(PACASTABRR, paca_struct, stab_rr);
> -	OFFSET(PACAVMALLOCSLLP, paca_struct, vmalloc_sllp);
> -#ifdef CONFIG_PPC_MM_SLICES
> -	OFFSET(MMUPSIZESLLP, mmu_psize_def, sllp);
> -#else
> -	OFFSET(PACACONTEXTSLLP, paca_struct, mm_ctx_sllp);
> -#endif /* CONFIG_PPC_MM_SLICES */
>  	OFFSET(PACA_EXGEN, paca_struct, exgen);
>  	OFFSET(PACA_EXMC, paca_struct, exmc);
>  	OFFSET(PACA_EXNMI, paca_struct, exnmi);
> -#ifdef CONFIG_PPC_PSERIES
> -	OFFSET(PACALPPACAPTR, paca_struct, lppaca_ptr);
> -#endif
>  	OFFSET(PACA_SLBSHADOWPTR, paca_struct, slb_shadow_ptr);
>  	OFFSET(SLBSHADOW_STACKVSID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].v=
sid);
>  	OFFSET(SLBSHADOW_STACKESID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].e=
sid);
> @@ -264,9 +242,7 @@ int main(void)
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	OFFSET(PACA_PMCINUSE, paca_struct, pmcregs_in_use);
>  #endif
> -	OFFSET(LPPACA_DTLIDX, lppaca, dtl_idx);
>  	OFFSET(LPPACA_YIELDCOUNT, lppaca, yield_count);
> -	OFFSET(PACA_DTL_RIDX, paca_struct, dtl_ridx);
>  #endif /* CONFIG_PPC_BOOK3S_64 */
>  	OFFSET(PACAEMERGSP, paca_struct, emergency_sp);
>  #ifdef CONFIG_PPC_BOOK3S_64
> --=20
> 2.25.0
>=20
>=20
