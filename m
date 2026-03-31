Return-Path: <linuxppc-dev+bounces-19052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1665FF60CF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 07:13:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flK8Q2shFz2ybR;
	Tue, 31 Mar 2026 18:13:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774941190;
	cv=none; b=XquoztdbQAdBEzvigBM//TIJKDAapSWSltAoSr6ZmIPrW1YJwTv755EXbsDoZ6RKn0i1TUO2yscNv/QRdLTrS2kdASNx/i+8YApMdtzXU6TDs5KV5v4OyO4TClOfvsE1h6coS8zMO7OhJM+cErT8OaN8xR11lljWopRZtvntUBt/Mmdmu+oTR/UWuxQT06fA31VZ1wh6G7XerCo7qB8M86kMlo8B3ePyhL6yAUkhhkHeNAmWDRsCHI4l93H5bH4hUA862SkMNiyMTiEnzCs1DYBfzbsszTLr2aatFs+adMW9vKSF2bNH+wU6KpfDA2MmGOYox5BoWeflIDMSB55Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774941190; c=relaxed/relaxed;
	bh=luFavRrVLyuYw5Pp7Hq4J37Yw0Jet8kP6askoheBw5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nzDuea/lv+pW9x1CifOBKjzBkYqljpkESvnCHvGAT7mYaA45G/iEo32Y8+9bL6R5u7v6l/u6GeKcqdXK3jN6VHdyWT7wnYIFiiRhZpINzrUr9nWZ8wmeeXxp7fINHCYp1CwqatxwL+6ywsp01f4+zWKMRvkYDDJzs+Tp+xDQ4eMHlC+jOfvba+N/oN97G/kb1B5k/2p/elLOGBjZhSZqDV0XL67Njxpp0vVC0Cnsm8+ONqWiUVwxCfWReL7gpQLYLvlLT8Ng0ZNlq/486ODDrtzEzWIpB0Hl6yoDrfuiVdQ6pOcSEFLnR/HbeKo2yOjxbLnxtiMbdycIjBY0nJJBSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiLMb1uY; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiLMb1uY; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiLMb1uY;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiLMb1uY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bhe@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flK8P42CNz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 18:13:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774941186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luFavRrVLyuYw5Pp7Hq4J37Yw0Jet8kP6askoheBw5k=;
	b=HiLMb1uYqMUQ5trgMTxFarHM61DnE7M5nCEKIzCqndsM8/TPS/pX2Y/5b+q/jtulPXD9VP
	LNJZtidQYTOwXP3uvWI6HDBceZRE6PLk7n6dbT5ENDEHv9bQriY4nMCeLDRpCa+sq1lBj1
	lRa89sA2Q/gzOmPYHfmf9pD0St+4mR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774941186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luFavRrVLyuYw5Pp7Hq4J37Yw0Jet8kP6askoheBw5k=;
	b=HiLMb1uYqMUQ5trgMTxFarHM61DnE7M5nCEKIzCqndsM8/TPS/pX2Y/5b+q/jtulPXD9VP
	LNJZtidQYTOwXP3uvWI6HDBceZRE6PLk7n6dbT5ENDEHv9bQriY4nMCeLDRpCa+sq1lBj1
	lRa89sA2Q/gzOmPYHfmf9pD0St+4mR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-d6vwkgkuNLO4Lk1HCZw_4w-1; Tue,
 31 Mar 2026 03:13:02 -0400
X-MC-Unique: d6vwkgkuNLO4Lk1HCZw_4w-1
X-Mimecast-MFC-AGG-ID: d6vwkgkuNLO4Lk1HCZw_4w_1774941180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 256BC180061A;
	Tue, 31 Mar 2026 07:13:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.177])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 843321955F42;
	Tue, 31 Mar 2026 07:12:58 +0000 (UTC)
Date: Tue, 31 Mar 2026 15:12:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] crash: Align the declaration of
 crash_load_dm_crypt_keys with CONFIG_CRASH_DM_CRYPT
Message-ID: <actz9u1rBnvtuBUm@fedora>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-3-coxu@redhat.com>
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
In-Reply-To: <20260225060347.718905-3-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: XPS60MN0hJdgqmHV6NJqt9z0iTUTrQI_B4p6ODqlRiw_1774941180
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 02/25/26 at 02:03pm, Coiby Xu wrote:
> This will prevent a compiling failure when CONFIG_CRASH_DUMP is enabled
> but CONFIG_CRASH_DM_CRYPT is disabled,
> 
>        arch/powerpc/kexec/elf_64.c: In function 'elf64_load':
>     >> arch/powerpc/kexec/elf_64.c:82:23: error: implicit declaration of function 'crash_load_dm_crypt_keys' [-Werror=implicit-function-declaration]
>           82 |                 ret = crash_load_dm_crypt_keys(image);
>              |                       ^~~~~~~~~~~~~~~~~~~~~~~~
>        cc1: some warnings being treated as errors
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602120648.RgQALnnI-lkp@intel.com/
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/crash_core.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index d35726d6a415..c1dee3f971a9 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -34,13 +34,6 @@ static inline void arch_kexec_protect_crashkres(void) { }
>  static inline void arch_kexec_unprotect_crashkres(void) { }
>  #endif
>  
> -#ifdef CONFIG_CRASH_DM_CRYPT
> -int crash_load_dm_crypt_keys(struct kimage *image);
> -ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
> -#else
> -static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
> -#endif
> -
>  #ifndef arch_crash_handle_hotplug_event
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>  #endif
> @@ -96,4 +89,11 @@ static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
>  static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
>  #endif /* CONFIG_CRASH_DUMP*/
>  
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +int crash_load_dm_crypt_keys(struct kimage *image);
> +ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
> +#else
> +static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
> +#endif
> +
>  #endif /* LINUX_CRASH_CORE_H */
> -- 
> 2.53.0
> 


