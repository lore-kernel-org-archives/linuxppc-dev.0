Return-Path: <SRS0=4CH2=BF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A820C433EB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 13:52:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408ED206E3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VNyKa+oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408ED206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BF4Bh31DpzDrDN
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 23:52:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BF44Q5RWBzF0fc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2020 23:47:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VNyKa+oA; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BF44P6nZFz9sPf;
 Sun, 26 Jul 2020 23:47:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595771238;
 bh=q3BkqJblFZLbFVD43sGIBhbWqSe5Y3XVkMWMw/GH8xE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VNyKa+oAomJJjyVxGTna1G9YsgIszk6k6EaVtNIq1sTb30u7Yg+RPLyIHDJO2CiQT
 jMt4K4SIA/K56C5RFftW1e0rZV0XPM/ctHyxpO/wEa3PsCapFW6K/snqXARQrkNIm4
 DdZsU87rrkoIBFw15LVWkrrM5BXBGiLtzKu/zG0cU9rLUevPf44Kop/4sFWlyDT7JP
 GkQPmrewkXeA0CgE9ztdLi1FrkPRHEM1A63Sy4ajJHnyaTTdmLWAE7pnoh9TWe3Da0
 KmBTrZbJmxZxMKQdqe+3jzLbhuCgXbf8deroZSscEvqzxWFwW9+pfCrmNuSHtIgXUu
 hDkPhkUFSFxng==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] powerpc: inline doorbell sending functions
In-Reply-To: <20200726035155.1424103-2-npiggin@gmail.com>
References: <20200726035155.1424103-1-npiggin@gmail.com>
 <20200726035155.1424103-2-npiggin@gmail.com>
Date: Sun, 26 Jul 2020 23:47:16 +1000
Message-ID: <875zaagzh7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Anton Blanchard <anton@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
> index 4ce6808deed3..1f04f3de96ba 100644
> --- a/arch/powerpc/include/asm/dbell.h
> +++ b/arch/powerpc/include/asm/dbell.h
> @@ -100,4 +102,63 @@ static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
>  	_ppc_msgsnd(msg);
>  }
>  
> +#ifdef CONFIG_SMP
> +
> +/*
> + * Doorbells must only be used if CPU_FTR_DBELL is available.
> + * msgsnd is used in HV, and msgsndp is used in !HV.
> + *
> + * These should be used by platform code that is aware of restrictions.
> + * Other arch code should use ->cause_ipi.
> + *
> + * doorbell_global_ipi() sends a dbell to any target CPU.
> + * Must be used only by architectures that address msgsnd target
> + * by PIR/get_hard_smp_processor_id.
> + */
> +static inline void doorbell_global_ipi(int cpu)
> +{
> +	u32 tag = get_hard_smp_processor_id(cpu);
> +
> +	kvmppc_set_host_ipi(cpu);
> +	/* Order previous accesses vs. msgsnd, which is treated as a store */
> +	ppc_msgsnd_sync();
> +	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, tag);
> +}
> +
> +/*
> + * doorbell_core_ipi() sends a dbell to a target CPU in the same core.
> + * Must be used only by architectures that address msgsnd target
> + * by TIR/cpu_thread_in_core.
> + */
> +static inline void doorbell_core_ipi(int cpu)
> +{
> +	u32 tag = cpu_thread_in_core(cpu);

corenet64_smp_defconfig gives me:

  In file included from /linux/arch/powerpc/kernel/asm-offsets.c:38:
  /linux/arch/powerpc/include/asm/dbell.h: In function 'doorbell_core_ipi':
  /linux/arch/powerpc/include/asm/dbell.h:135:12: error: implicit declaration of function 'cpu_thread_in_core' [-Werror=implicit-function-declaration]
    135 |  u32 tag = cpu_thread_in_core(cpu);
        |            ^~~~~~~~~~~~~~~~~~


Fixed by including cputhreads.h, but then that results in errors due to
your addition of kvmppc_set_host_ipi().

Removing that gets us back to the fault_dear error.

I think I see a way around it, will do some build tests.

cheers
