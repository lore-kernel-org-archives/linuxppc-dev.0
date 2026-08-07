Return-Path: <linuxppc-dev+bounces-25535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306FC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 02:38:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGSxn5J0Jz30FB;
	Fri, 07 Aug 2026 12:38:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786070301;
	cv=none; b=N8QNu6jCWylo3nFcuxN9hwjXQ5cMZ2xjgU+9m3B0IEQ4gF9bhX7fHjW7fhOcImAAonx9nHgQgA3F4RVLGDGjfErJNYXGWr0lbUEH3u57acrNBB049YOZmFkWSPc05IJWv3j/fUn7VuYQK3229m1t47xuKAhZW3JDKJQuTY8Lrk1IveIxugRBN87RKxK+z9DrUyN4ig6H0btfxI69mj3X8wIMnsA3pBCmi3iV2V95o7/FS9LUfeqrKuPw3a/yJAdw0xTb6NrROWyxBTaRb4DzLJhclHZAMJMKGh1OhiyONvhfAjsisM7vTcGMQpB4UXGLBmIGR7F4+5viHQVVlQWCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786070301; c=relaxed/relaxed;
	bh=oJdLdIw3eLo0oaT0dX3TZQQLMEjdBPNutZDZxls1Ksc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Tu7Y+Rlo/2uV3awMWWYo/b0pa97QUBpko9f1/eGdM935YNhXVevZFFjJqIVZrok2VgxFd1VruSn7T7kFKvUbRmCi1Fwd2SBjwutO21VD8BcKCNtnIZbMoySxzCG+2xu0sVULS21Vs5wp6MfAmUMnZpDxtGoO3lGvTfaZKdKJp2yM4D6PsTnrjRL+NfAKZhdFztEVERpvsdiJpPOJGWpQt7OpKBm/qlQN7TZOWHHHKneCLkA2D074vdh7aRlRmT3RoC1xjp62aYH8f0xkd/wFWUz4DbrsAVj3GoSxeQqEOibctD8U1Ri4NancUAy/jIXlKVIZ1pS7xTRuMHG+ZLO76g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Stozg/e7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Stozg/e7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGSxl4k5lz306N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 12:38:18 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-84eb992a881so2636626b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 19:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786070296; x=1786675096; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oJdLdIw3eLo0oaT0dX3TZQQLMEjdBPNutZDZxls1Ksc=;
        b=Stozg/e7cDVRmkNZcJa++9+DTiuwgsqBt+cToQWUJK4tfnZO1ySvnE0FBM5jseYNAk
         Measbe5gsmX/GHoUyEmSr7AYSpr0FdhocHOs1Pgajr44DV9+yuN/UIrc7FbRGMfI8H0S
         UZVEztahz5DODIX6W/SORjEu9jibtkRkCIXfArn594opDyAzc3RTfkJahYJGIQ0EZCPw
         DjNnC3qLsBWeG6eWT1uxMjCatoTOFFoKt7Bmd4Jnlj7sBp8RCNmIRi85W3GJAG7dIUUD
         P71x9r0m7LOv762dZTKK7ca9kUx0MOC4u8SbZJCBLu/KSGeQB2lIK492e2jXDf+gI6eA
         4G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070296; x=1786675096;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJdLdIw3eLo0oaT0dX3TZQQLMEjdBPNutZDZxls1Ksc=;
        b=FSw3j+IAaluhcWDv+6H7FMM3HcbrF4muFF4Zd809ZBsjFU9jBjCAcoVWYFV6AM5f0K
         uENAXsoJf4JoNvB6OYTrEmQp4nw0TMzhcQawilbcDCxGuIHyCWsSHqpTRr9GktdEc7Ym
         4FyhpIcPVFjhozogxiYmRkJemdRFcF+++s7fpWXNaGrbKDV5LZgro6uJWQZUIiyab97U
         mhkvrS/w9Lwk+KmsgSManNbnFfY3knku8KCRzDupScvQAgkdqIC6dRw7d9dA60orO3z0
         6b2nqbpNOg93ExLHWGZPsjShROif+w2YrXGey1/mbgbavMNoGN9KxjZSNY/Ee5DjBVev
         hBYg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq3L/lBRizSIwwIJQ0+jjRTzc19Q4b8Sxjy+oBzNo3KyBKHkYGjNBG3S5l67vMlkX/PctCfmdBEZDLnoM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yysh374sQ+iSfPVo3RMyTagWUyAl5wsW5R2ibtShRh2bUxeOdAT
	Gl18qQDerysit6VkpbFc7p+6DAZUN+qq0+2jlKdzR9kz1WbHFmTx5OuF
X-Gm-Gg: AR+sD11crrTUZsC5uN85AtNmf369ZvhBP/vCZi2/pPlsnHkGed3QeHM/b0GPPilLrXQ
	mTZLcaBfanKV1gV/LMEJm/z/Xaex3DLMsN3KDr9RZST9xzBOeKt8YW7xqg4w6ebHHOKqRjomwh/
	I5ODYvT31OtmJDLAQyxl8XQtmN552Li9wqjaGCI4L3rA/bO0KenHNFw8wuwApvOfMeOJnYyXOFZ
	AKb8QBwA6r6DVfXHDWG7vQZ0rMGN3qMZgfwE+2/PHJBPKrvguV1PFhFB70/481/bqMN1AoCq/X3
	9cBaQ33xHzi3pSmJjG5zgWsucUmpGatF49Nz8TY9kGrsvZlQbfTGUFnNdwc/IlAwTrZYWVNFI92
	UlzhZOjV8Ev/XBNPBo1bJJxWzUep00WzJbUDNjo9Yat5+e5I2hACUKEAZlNRL5Xy0pQ+kaWtexE
	vKd6xse1E2dgxff9dq2h0J+FlAOU7FPouG0Wj9UcRz3QZcy/XnqcZL+SgwYzI=
X-Received: by 2002:a05:6a21:6089:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cbadd74818mr8045427637.36.1786070295864;
        Thu, 06 Aug 2026 19:38:15 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb87d3bsm1585726eec.14.2026.08.06.19.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:38:14 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: ltc-dev@lists.linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, donettom@linux.ibm.com, Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
In-Reply-To: <20260806205027.86428-1-gbatra@linux.ibm.com>
Date: Fri, 07 Aug 2026 08:05:50 +0530
Message-ID: <ldailks9.ritesh.list@gmail.com>
References: <20260806205027.86428-1-gbatra@linux.ibm.com>
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

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
> This OF property dictates what is the max size of RAM an LPAR can have,
> including DR added memory.
>
> In PowerPC, 16GB pages can be allocated at machine level and then
> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
> pages are being excluded from pre-mapped TCEs. A driver can have DMA
> buffers allocated from 16GB pages. This results in platform to raise an
> EEH when DMA is attempted on buffers in 16GB memory range.
>
> commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
> adds TCEs for pmemory")
>
> Prior to the above patch, memblock_end_of_DRAM() was being used to
> determine the MAX memory of an LPAR. This included 16GB pages as well.
> The issue with using memblock_end_of_DRAM() is that when pmemory is
> converted to RAM via daxctl command, the DDW engine will incorrectly try
> to add TCEs for pmemory as well.
>
> Below is the address distribution of RAM, 16GB pages and pmemory for an
> LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
> assigned pmemory of 8GB.
>
> RANGE                                 SIZE  STATE REMOVABLE     BLOCK
> 0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
> 0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151
>
> cat /sys/bus/nd/devices/region0/resource
> 0x40100000000
> cat /sys/bus/nd/devices/region0/size
> 8589934592
>
> The approach to fix this problem is to revert back the code changes
> introduced by the above patch and to stash away the MAX memory of an
> LPAR, including 16GB pages, at the LPAR boot time. This value is then
> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
> iommu_mem_notifier()
>
> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>

Thanks for addressing the review comments.
BTW - we should really cleanup enable_ddw() function. It has so many
corner cases and has started to become confusing. But as for this patch
it looks good to me. So, please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


