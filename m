Return-Path: <linuxppc-dev+bounces-17148-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2F9EFB7F0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 06:57:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLQQL6q93z3dLj;
	Wed, 25 Feb 2026 17:57:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772002666;
	cv=none; b=BUDZAU64z9Fee4BDXtfpqF7A5q97Hj6Kh5xTmUHW0bDgkmT61VKUz2X3mXDhZth0F0Ylg7fOyw1e2ml6nNBaRZRxW8FU/5GR5sap07L5vy1MTkyfhdRrs95Jzozt7sQSNFLsmacKxxnOrAuqnkq1L9zh1LWzwpqKc2HPbHZlaJNpMxqmB1r+UMZfrmIhIk6lDE3wNCmme0XioBzfG4RNR8aIiGJZ9z5Lt+mc2JYg+PrveNh1Y+7l7g+tqGjGd1uVVLdnaX+trat/QbOhnsojHe6rIe3thIB6DV1RW+vv8L7gFewhYVs8SMRQvjpbI9kDFadcN5y+S5FtClI/2X761w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772002666; c=relaxed/relaxed;
	bh=21jRe62XPEVYrcTsRtRO8xd5U2tbZs4EvU1wSTUITyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xj+9g10QHSQlTVh08TY8Xw9IGQ7odkrcLBSwXRKFvBjK3RlrOsf6AcS5Yc391QWukC4/PCkDck/e4oEwU/lZIFzaoN/i5WkqnigVXVrOH/nE5hLN0vLD3eedZGXpsG1gPWEXU/m03KKZra8BCSGzzNBVEiOqV43rV8232xryOnZSSjO6cKQBIkFFSACSZP1YJzw4Jfm2TLzJv8G9L+P0bo/5VzAT/vygepQZ2msP9XzMLhF9hacU3mE3mUkCE2Ha2F0rINv8krS+pzMRyfUbXQfbCX06DPLDG7Ev0REe3zxZzoIJdwGcE396R4P1w27aiw5HiS+cSlMUnaVjRn1w3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JmiIWvEK; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JmiIWvEK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLQQK5ddSz3dLc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 17:57:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C512C6012B;
	Wed, 25 Feb 2026 06:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5DAC19422;
	Wed, 25 Feb 2026 06:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772002662;
	bh=xM+pXNjx5WhrwV2vpwiDD9Imq0ziFnk304V3V+OEhA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JmiIWvEKpIk7l3GZIT4aKA0Rf2HNZC3Zpc/iTN9ugFqCH5S0X8y2As+Gk3XmSNRLc
	 ccIIqpZlYvfPkL4dPxfJQHzCxW07cwGpCD0dW9DQ3L17zZIPXRPlfy4Yq4sgJtvU1S
	 53Qtep+OJShmsM4S4uUhBGtq8vLAIGZ2j9gHmhRDknwjA0IOncOUBebu6HThAVLMw2
	 8nI5rCYjOMwhipIw2g3qrah+kkO4T+/sCNY4NgwLDeYy6Ddw6ZnVeqvcS9ugQl9Oo5
	 5isKXZ3FUa46jib7wJHbxlLmr1QFKMS6KqhvjxTG9v/W7gFGSZlB3AqfoWwU6+ZZQE
	 vhIXNkiQsM7ww==
Message-ID: <4e84b9ea-9e7b-420a-bca9-6febd87a80cb@kernel.org>
Date: Wed, 25 Feb 2026 07:57:39 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/ps3: fix ps3.h kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20260222060101.2086504-1-rdunlap@infradead.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260222060101.2086504-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Randy,

Le 22/02/2026 à 07:01, Randy Dunlap a écrit :
> Eliminate all kernel-doc warnings in ps3.h:
> - add one missing struct member description
> - add one missing function short description
> - correct one enum name typo
> - change several incomplete kernel-doc comments to plain "/*" comments
> 
> Examples:
> 
> Warning: arch/powerpc/include/asm/ps3.h:96 struct member 'dev' not
>   described in 'ps3_dma_region'
> Warning: arch/powerpc/include/asm/ps3.h:408 missing initial short
>   description on line: * ps3_system_bus_set_drvdata -
> Warning: arch/powerpc/include/asm/ps3.h:473 Enum value
>   'PS3_LPM_TB_TYPE_INTERNAL' not described in enum 'ps3_lpm_tb_type'
> Warning: arch/powerpc/include/asm/ps3.h:473 Excess enum value
>   '@PS3_LPM_RIGHTS_USE_TB' description in 'ps3_lpm_tb_type'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

You sent a V2 with the same subject some time ago, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20251129183636.1893634-1-rdunlap@infradead.org/

Is this patch something else, does it superseeds V2, or is it a wrong 
resend of V1 ?

Christophe

> ---
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> 
>   arch/powerpc/include/asm/ps3.h |   26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
> 
> --- linux-next-20260220.orig/arch/powerpc/include/asm/ps3.h
> +++ linux-next-20260220/arch/powerpc/include/asm/ps3.h
> @@ -65,6 +65,7 @@ struct ps3_dma_region_ops;
>   
>   /**
>    * struct ps3_dma_region - A per device dma state variables structure
> + * @dev: The device that this struct describes.
>    * @did: The HV device id.
>    * @page_size: The ioc pagesize.
>    * @region_type: The HV region type.
> @@ -108,18 +109,19 @@ struct ps3_dma_region_ops {
>   		     dma_addr_t bus_addr,
>   		     unsigned long len);
>   };
> -/**
> +
> +struct ps3_system_bus_device;
> +
> +/*
>    * struct ps3_dma_region_init - Helper to initialize structure variables
>    *
>    * Helper to properly initialize variables prior to calling
>    * ps3_system_bus_device_register.
>    */
> -
> -struct ps3_system_bus_device;
> -
>   int ps3_dma_region_init(struct ps3_system_bus_device *dev,
>   	struct ps3_dma_region *r, enum ps3_dma_page_size page_size,
>   	enum ps3_dma_region_type region_type, void *addr, unsigned long len);
> +
>   int ps3_dma_region_create(struct ps3_dma_region *r);
>   int ps3_dma_region_free(struct ps3_dma_region *r);
>   int ps3_dma_map(struct ps3_dma_region *r, unsigned long virt_addr,
> @@ -136,7 +138,7 @@ enum ps3_mmio_page_size {
>   };
>   
>   struct ps3_mmio_region_ops;
> -/**
> +/*
>    * struct ps3_mmio_region - a per device mmio state variables structure
>    *
>    * Current systems can be supported with a single region per device.
> @@ -155,13 +157,13 @@ struct ps3_mmio_region_ops {
>   	int (*create)(struct ps3_mmio_region *);
>   	int (*free)(struct ps3_mmio_region *);
>   };
> -/**
> - * struct ps3_mmio_region_init - Helper to initialize structure variables
> +
> +/*
> + * ps3_mmio_region_init - Helper to initialize structure variables
>    *
>    * Helper to properly initialize variables prior to calling
>    * ps3_system_bus_device_register.
>    */
> -
>   int ps3_mmio_region_init(struct ps3_system_bus_device *dev,
>   	struct ps3_mmio_region *r, unsigned long bus_addr, unsigned long len,
>   	enum ps3_mmio_page_size page_size);
> @@ -342,7 +344,7 @@ enum ps3_system_bus_device_type {
>   	PS3_DEVICE_TYPE_LPM,
>   };
>   
> -/**
> +/*
>    * struct ps3_system_bus_device - a device on the system bus
>    */
>   
> @@ -371,7 +373,7 @@ struct ps3_system_bus_device {
>   int ps3_open_hv_device(struct ps3_system_bus_device *dev);
>   int ps3_close_hv_device(struct ps3_system_bus_device *dev);
>   
> -/**
> +/*
>    * struct ps3_system_bus_driver - a driver for a device on the system bus
>    */
>   
> @@ -405,7 +407,7 @@ static inline struct ps3_system_bus_driv
>   }
>   
>   /**
> - * ps3_system_bus_set_drvdata -
> + * ps3_system_bus_set_drvdata - save driver private pointer in @dev
>    * @dev: device structure
>    * @data: Data to set
>    */
> @@ -464,7 +466,7 @@ enum ps3_lpm_rights {
>    * enum ps3_lpm_tb_type - Type of trace buffer lv1 should use.
>    *
>    * @PS3_LPM_TB_TYPE_NONE: Do not use a trace buffer.
> - * @PS3_LPM_RIGHTS_USE_TB: Use the lv1 internal trace buffer.  Must have
> + * @PS3_LPM_TB_TYPE_INTERNAL: Use the lv1 internal trace buffer.  Must have
>    *  rights @PS3_LPM_RIGHTS_USE_TB.
>    */
>   
> 


