Return-Path: <linuxppc-dev+bounces-26688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EF2C79FA0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 15:16:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdrHy50yJz2yvX;
	Tue, 08 Sep 2026 01:16:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788765534;
	cv=none; b=fDUz0t/NTvqPYLjPzoIs8GH5T/3CszoODB8uyjoDTIioiDq1cfO2oVESrTzRiQ1s4K8RGl4lfnmQzfOM8sZ2yI4WN/hFsQqObdI+kRCXHlECfaqN0ZDZ+nsXaKFSWSUXJ1brF/7vMEsqL5b1GrD3b5qiCUjDISUIyrmwAfroMf+9+/4Em7yX3YQ2Cnda5SevLKjulsmdiHFh7P4cXZBpCq6qwQD9xD+WmSt8Xy3dt0ax4vR/01yXZ0lJVG3BPfWJiKcfdZP0BvU6ECvHeEx7XK0XdDYvdxP9s8udmbMwgtEsNqEEkjiWBHqOUpa42mfRYgPOToh995QjMYp42W0bVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788765534; c=relaxed/relaxed;
	bh=9wnX7kbNfFv6WjYVBZaTARt9LTYfPVrd/RifhxC10JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNysETUxRcvQGznf1WiKi/kvA0h1W6tthPfzXrhCQKFnT+4wpBvng4ioLHGtUkWczrC6NF3wS4hcpuJeWSc6TNO/EWfmenhgY5T5Ei3ASHDsHPJtp6L36/dm7P005tQ/l2DJJZ7M1Tjl3Unx4noEMPwOCo//sbf/W9IIPJ0B9BxYZrJPFNkS4YL5yJcpFseeBo+8nOxFxs6jfKnpnQaUn8YAfNZrSE4kJzukF/fouulDLrZkAm/awtHJNtHA3MH6dS+tXo4+W5X+KHjK8DZpaboJDKCyHlJ5Ab6xnYTkIK8w9Z2R9B5wr9H1fbdJ6a2qagVzAzXKSQABxYGYl3YGpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UFvpEdTA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UFvpEdTA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hddj94Cjjz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 17:18:52 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2d01663d816so21734875ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788765530; x=1789370330; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9wnX7kbNfFv6WjYVBZaTARt9LTYfPVrd/RifhxC10JY=;
        b=UFvpEdTAcvgKvjI9OqoUU1TOwd6oagDBHIGazNDdlbMnEbV+pjiSGirdMY1DG3xyj6
         zxmYu13LjwXTo55AEuGcPhatu0m9fR7lv6JjYB1yaNQE7btLlijqOMKvDyLiK30jt12r
         aeG050OUM2LCSz44A+j6ixTBtzDemSNtINf2Z365U1viUFBNq/KhpfZI0vL017dy9bhh
         TUobWnBgn/ePiN3iT4kbKieLE/LfvRCRPVHiUzu/27F5sDKgqXU9+RR0fEkuIi4yNb6j
         mY16HWN5KhoEiiBC1jTIM4cNmnQAGjl/axoDeddhJubLcN8LzjlpLUW+5XRCE5DzyZsF
         hySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765530; x=1789370330;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9wnX7kbNfFv6WjYVBZaTARt9LTYfPVrd/RifhxC10JY=;
        b=ba3rcAW0BDR+x4fncmWBKqPe0gCH4Z4wMNYNYnvIEtTTKeXtHgFnp6hE1be+eI7weo
         rGlOydT8M3AOYqfZ0wGbb7Qb9vDYzzc/IWXtUWgwbY4XT2c18D0ljUh9fpA5Zhy7KqvL
         sA1EocAKjk1ubrU15J/btTqSzk0I0w4hINjzySDzrRtHhttxc2sgTX39FfPg+6ji4tBj
         eQZz4hlXWHnu63fpgLZxQIn+PGpZJQAOd66ydRAqZgIk7jAr4ltc/bZ/qMT8ZGLtGtFG
         Q4E18WCqFievhUXZ0SfD/f+qFx1q0Fng5Hs13YXlFdJpoqm7m7rsmpRdemcEoW4LGO/q
         OpzA==
X-Gm-Message-State: AFuF++lx0u6viNWQruJPcEXaHa8BiE8xBrjI+5T5nTjLir9kgvKQnt4Q
	XiDCahe1Trd5iXpR9Hg5u+sNsAn5ZD/C0Ewfj2Nd8cGXZxHtaDatU29P
X-Gm-Gg: AYBFou0eX0/iXw2xEGg68rd/VW5jCrTcjX27uI+Mc87j+lu2hSj5hKFx8zr2lik5njy
	aYcPaIvUnSqpAOp0HUlmlWF85qxCO12OrnHbDbESPfIzGTnp6ykuTzpxaqCt9kiElb542Y8+3u+
	7ng1I2lBOBMP3ksQdLVpgEgK3UjtXW0LhV3Phlczy3Lxbf71wUvrP9NJ8s6p8Xgdo32mzY5+PbX
	7kJiOU56kTVqa0ZtyK2Uw9A6gc/sSRfNwGownRuW2W1B7Hk+p5vHgLVpX1naZEqKjoCp50WNo04
	v4ccYmtiPzrckc2HKVXz0JpucLbbvaI3nFghOh3DEMaXITIMRQdSjm9MThnnFukse5JB37imvCm
	vaj5BQZAhxa3BZaiRN8xUZ36QbkzbTIfxeoXh7TtXpKXIqSxJbe/xq/Aqejsc6NBAhRZBNll9A8
	fIoItyLrBdrkATvHHTyoAk0RIrhu4yswgAHYiOQQh5HcL9lF6K92j+BuODzvnPcvVDMkPyK7ocU
	g4si5WzaBv14Kr4ghcdy3cpyDRuL0veljMO
X-Received: by 2002:a17:902:e804:b0:2d6:ff5f:eeda with SMTP id d9443c01a7336-2db1256cfa1mr302484215ad.6.1788765530410;
        Mon, 07 Sep 2026 00:18:50 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.49.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae85eesm39192535ad.82.2026.09.07.00.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:18:49 -0700 (PDT)
Date: Mon, 7 Sep 2026 12:48:43 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com, 
	sshegde@linux.ibm.com, ruanjinjie@huawei.com, ritesh.list@gmail.com, 
	riteshh@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/interrupt: Use early_radix_enabled() in NMI
 real-mode guard
Message-ID: <ap5kv_92TzM-tcBp@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260907070058.26338-1-venkat88@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907070058.26338-1-venkat88@linux.ibm.com>

On Mon, Sep 07, 2026 at 12:30:58PM +0530, Venkat Rao Bagalkote wrote:
> radix_enabled() uses a jump label which is only valid after
> mmu_feature_keys_init() is called. Before that point, on a pSeries
> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
> cur_cpu_spec->mmu_features but the jump label has not yet been patched,
> so radix_enabled() incorrectly returns true.
> 
> Replace radix_enabled() with early_radix_enabled() which does a plain
> bitmask check against cur_cpu_spec->mmu_features and is correct at all
> times, including before jump label initialization.
> 
> Add the missing #include <asm/mmu.h> since early_radix_enabled() is
> declared there.
> 
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/interrupt.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index 1b45a49e9bed..36a654e780f7 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -71,6 +71,7 @@
>  
>  #include <asm/kprobes.h>
>  #include <asm/runlatch.h>
> +#include <asm/mmu.h>
I would prefer this to be in alphabetical order.
>  
>  #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
>  /*
> @@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>  		state = irqentry_nmi_enter(regs);			\
>  	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>  		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
> -		   !radix_enabled()) {					\
> +		   !early_radix_enabled()) {				\
>  		/* no nmi_entry for a pseries hash guest		\
>  		 * taking a real mode exception */			\
>  	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
> @@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>  		irqentry_nmi_exit(regs, state);				\
>  	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>  		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
> -		   !radix_enabled()) {					\
> +		   !early_radix_enabled()) {				\
>  		/* no nmi_exit for a pseries hash guest			\
>  		 * taking a real mode exception */			\
>  	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
> -- 
> 2.45.2
> 

Rest all looks good.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Regards,
Mukesh

