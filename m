Return-Path: <linuxppc-dev+bounces-23984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2697EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 03:05:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxGsj3gJPz2yQH;
	Fri, 10 Jul 2026 13:05:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783652713;
	cv=none; b=I5b6B8cZV+RKxExDT5ME2fhdl214uaNgMt01g092ti7hBpYXsk8RoEHbVY4iYCgbxLuKrlJKdGAa9rl/WMhN72pb3A0HUAiT08fVSQflJkwCkkLxSfGG7dKig7jZE6uLaVWaiFFy5zY38Gp46mJ7VB1No+MlzwAz98CJDi4o21j4bHv9uEGoqfHC9Gkx4XebPYH9OPHOeTLxmzbVw3wwbcYl33MlbP6OQ1qblc6SbMx3ehruS0QJU1DckvROUX9xaxeao+sMzMcKxK8AkZEZPprDWiU1cyOWSahJ/JjuGoSEr8EDL/vllaOFVnvSea79wWff38YUmkvNNuTfh0F2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783652713; c=relaxed/relaxed;
	bh=Ls6mtryWrPtP9kkrpMW1MJuaLa4TZQxyCDcydaBlnHw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=dQr88Tg21Y58jCTuu8inN1uxlXWQDjHn9ryt8iWL8DY9MsZIMYqTsNSP52V6aIi5VEbzjug/Sbkv3giTMic+LVSB0+qHfhnouLnnegxHh35GWZS1sB4PXlOuA2lBEJ6E46a7LZ+e5EtEn1f5xUDjJraetZ/dOkphZh5iB2smGCgCqFLRx6GNkBVlf5x1ounJHNBYB70XjWdq3ThoWekGmU1tnOlZI/t7Nob7H8k+IwTXungyQ44uXs2v5FCYj2A5XdlEgM0zabD1Cb1WWC/CuODHNa5W6qa6RzLgKFw/gbR+k0ZEInbGK6AaBXD9OGAG+Xi9qIJu/shVkKeuavD0Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PSr3co5E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PSr3co5E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxGsg3qtZz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 13:05:10 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so21301625ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783652709; x=1784257509; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ls6mtryWrPtP9kkrpMW1MJuaLa4TZQxyCDcydaBlnHw=;
        b=PSr3co5EKWwBHGAHZ4shtBTFhCPaacpTXGFxkyvmBBzPKRR/yGaEW54f6bH4j9KLAx
         rSxXzld3i91ihjWygc08tst9uQdIp11TXJHcxdn6v5H5+nb0ch/mG6f7vALmuAtPZKtX
         mv7pKzxw6jwASv20/OSN+AErNYT8nbXty2D+joT0Z/SCSEDNIHKOGDIzONQwS1Z/AfIL
         fn+sexgaMVgBB8vD8N2mQnCouLO082EVELdXh2a3K4wfnV6+byikxeWCMg/87NtDsRDg
         ZG3OzNIsR1rEKfjLYLdWjsGWSX6TZyUt33rknL5ajCwQYmWuZIsqiX5nSRr5f8XS8YMm
         lg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783652709; x=1784257509;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ls6mtryWrPtP9kkrpMW1MJuaLa4TZQxyCDcydaBlnHw=;
        b=jNFu29uBqw16P6a7fsMvXfHjSbuxYVy4e2zI6SFlOtcb6QFDBNfu7jOpwUow0pEXyd
         PhTYtxZosdShHwnqhOI2Gb/SXHWVQJ9rvhQTbfydAKrovjhM4sHQewaI/2VoMnRBurO8
         IaFTh8ph4sF5Thk3m/+wSFiP6Nd+st9H49fSBuwsqSJW5GXdkyriF0aAbTWNdjypsDow
         IuiDbpVa15R5jQQLLzQmJ5sVH86I7rA8uBc8fVrJ06S8unuXz60lcoUOIiu2RfG6UYll
         eeRx5C0Z0Ej4dSdVmFBxc97yeo+RRgqnkf/E97GOaqH/erfdg3A85+ruor6PkeNkUMUM
         JSnA==
X-Forwarded-Encrypted: i=1; AHgh+RqFGejpN0wfe9OoU9Utc3yKFPgsLkqBEeNbN8t/KvLdyEl6/8TVVxpujZhDDt0ztu0sr8vtR364pAWUP6s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCCZBOATmL4XJhFpCaIf9x5YH44BYPoZ1PfNoXPQFoFurc7aRA
	lTwCDGnpWXfpE4q2nCYscULqnKHnxprrCfLSUlNk4mCaiBChcWlm2/fA
X-Gm-Gg: AfdE7cmGoYwSt0IxtEQpptKYWwdHy6XGo7x7I1LdO8TXnwc2owZTUCFvlaOVdoQ38jm
	ZCvxYsoGqV+XcovwVaZHP0wisJFt+2UMhBGyPP4lTNqZ5JLiA7gr7tfimLgM4EacuNmFNNCpl4i
	ML4tlgECFRRqxl/TxYHgnw7bhK13SdQh6Ty3hih20aUFpRrWyjunOoknyIny5Rm+IfldLn4JxLM
	1gEHSqSwhQDO3icoivffh80eBW3180KNp2Rg51wE83GwXwyuULkp6wH8vOr79yOPd8mTX3f8nsw
	kdr3O/0s9+cXPVfYmjqWK5NsobxyOmGSH5HmFX7V6kU4ozCdiSqf72Yw8O3B0BnJjSGPvqVx/Fq
	YnesQVcasTAGUJUUJIgNtFKyhHtFaPwczuWczhzr3YThGLULl3uJV6gQDI9OOqqVA6QESYFsj2Q
	e0quh82oxcldk=
X-Received: by 2002:a17:902:d511:b0:2ca:d4f:adab with SMTP id d9443c01a7336-2ce8292cb2cmr17305665ad.19.1783652708677;
        Thu, 09 Jul 2026 20:05:08 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm59620733c88.14.2026.07.09.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:05:07 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] powerpc/mmu: do MMU type discovery before crashkernel reservation
In-Reply-To: <20260708143357.673251-2-sourabhjain@linux.ibm.com>
Date: Fri, 10 Jul 2026 08:14:51 +0530
Message-ID: <1pdbwokc.ritesh.list@gmail.com>
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com> <20260708143357.673251-2-sourabhjain@linux.ibm.com>
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


Minor nits

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Crashkernel reservation on high memory depends on the MMU type, so
> finalize the MMU type before calling arch_reserve_crashkernel().
>
> With the changes introduced here, early_radix_enabled() becomes usable
> and will be used in arch_reserve_crashkernel() in the upcoming patch.
>
> early_radix_enabled() depends on cur_cpu_spec->mmu_features to find
> out if the radix MMU is enabled. The radix MMU bit in mmu_features is
> discovered from the FDT and kernel configs. To make sure the MMU type is
> finalized before arch_reserve_crashkernel() is called, the function that
> scans the FDT and sets mmu_features, along with some bits from
> mmu_early_type_finalize(), has been moved above
> arch_reserve_crashkernel().
>

Can you also add a short description of why can't we move
arch_reserve_crashkernel() to a later point instead of breaking
mmu_early_init_devtree() and moving the xx_type_finalize() part above?

If I am not wrong, it is since move_device_tree() checks whether the FDT
overlaps the crash kernel reservation. So arch_reserve_crashkernel()
must be called before move_device_tree().


> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
>  arch/powerpc/include/asm/mmu.h           |  1 +
>  arch/powerpc/kernel/prom.c               | 28 +++++++++++++-----------
>  arch/powerpc/mm/init_64.c                | 27 ++++++++++++++---------
>  4 files changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 48631365b48c..7a3b2ff02041 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -208,6 +208,7 @@ extern int mmu_vmemmap_psize;
>  
>  /* MMU initialization */
>  void mmu_early_init_devtree(void);
> +void mmu_early_type_finalize(void);

can you rename this as mmu_early_init_type().

Otherwise the change looks good to me. With the above 2 addressed, feel
free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


