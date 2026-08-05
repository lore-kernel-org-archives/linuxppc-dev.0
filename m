Return-Path: <linuxppc-dev+bounces-25397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947E0C55184
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 01:59:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFDBB2nWPz2xnp;
	Wed, 05 Aug 2026 11:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785895186;
	cv=none; b=cZoERPOF/dHANcbYIBeBk1XOL04hfMjZn5U1WKiKhtATepAyP9tqFO54vQkwlpLzLqRzwzlwedfnUaQJyYwh9YtfwNiYi+aFirFSeK0zSGMDj1qMaaPkFyx6wal/cO5geFXlhInonir8cVdfF5tW4b8raSEmtGPM9s5nJev65dKuJYufU7M8aXJPKRFyKVBMqcYcgEDjOIAiIgfRIo1+BAAWqE9rgROToiSwh+h1cZCPLQbYvKfyTzNAgv2SE2rwt9eJsd8MEoZ1uWDjysURNNzYnL8fsG95YVWcPVmbxDA/QlcCaPx8IsilnaOaxzg9jFsaCKkJPpuf/P6f92fauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785895186; c=relaxed/relaxed;
	bh=RsSvF0ThsYwF5rKvJPenXthbv4vP7R634B7PFbVoBfw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=VtlbnRA4sfKzDvg9meHPHnvTR7quKgxQoAvDl2OA73Cy0qneptuGT0rJte6xRvFgO9O3QB3vyeBDDbgbHaCjYQ1HfVcIs63WmpbvLM32dQFd+jTKNZUMTNDFZfK8Ta7pncR4cxuHy8TIAAK0qWLDt9JhiSK9uPFVGoMlpC2aLodz0kYFVr5UUMK2mI1e39UocPAvhNmecszv70JsJvKYK3m+JiZAGjoXSfwpTM+JNI/rDZKfgLwgR4KnK95TOlqLTecN04qBFhZiTWpB4adF803PS3Od5dLIKBXveDKUaWJz8RESGYlmgWGw+SuCqVxoGr2zXUsvkVXLbhNH7jZRGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pbtemWSE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pbtemWSE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFDB8556wz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 11:59:43 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2caea3f742bso7375335ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 18:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785895176; x=1786499976; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RsSvF0ThsYwF5rKvJPenXthbv4vP7R634B7PFbVoBfw=;
        b=pbtemWSEsg/DGj2R5aq18/zL54yD4JH7OU4PFyWa9+sbB2Xpq1eCYilM5j4c55HF91
         tbeARD8sMgDUylTbWYLGuprrFBfdF9r3sJmiF/IYTVXPCpZQ1N75UqyD1jwfiUbZiWNc
         Y0RnSTkj3EY5l2Rpndpu1jsPaZMgM2kAs5rSgeCU0JO66bw9D6EdG7KAba5OqlL7z9eb
         viHAVz0vMQCV7sVXbgjCFq4n3eQrYA4SQIKdgXF6S1IjOENa8slJ4gAJicCqWwXMLabw
         totfkzBUWi/086QsiM5OJPLRo2FBRYf45wNm4rboav0M4/WGIT+LQ0IN2hfzxGGyW/II
         4L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785895176; x=1786499976;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsSvF0ThsYwF5rKvJPenXthbv4vP7R634B7PFbVoBfw=;
        b=tP1Y6OJX78Frq29Eqy15RmvWTWxhLD2kI3U+kbjFbRS76tCO2hIxL8CzY/4yqX8aC7
         WtsRlK4T5g98Ba5xls1IULYZVRab8l/dqIgce2TDtwXCB3MicWgVk8W8jBr6WK9bLyEt
         yBduaa0ClU21KVhB0iHKL48yv5dzEYzdVLHoCpGnbznGdARPk6kjPrjnrfHf82Eziw/E
         OE5fXPlTmMC74ht9qw8rqjufaRf0zrGvGF29LfyiRTVKZr8bJqdvzfjcv4lp0S13JjsK
         K+YA6AecrZWudFrSHtDkSn7sNqmYsusOZhSoGQQkEk55TOfuMsfIXESAqwVw2By4UfKv
         9Snw==
X-Gm-Message-State: AOJu0YyqinwRyxaXcTTro9VgzG1AibThKzKL3dNayFBJorBHQcyavJT9
	wxe/VeW78Ww9WPExuFKRT87siuI+9VZhamtqqFQpJIQpe6s8pYNctxSu
X-Gm-Gg: AR+sD11TsjvP17Q2rekFlxaXDvKnH6vmQNJtNiLAGDmCo0menlDo/ScTAhM5sw/Kmih
	1LiDSLr0KiC0caZDH7DKmuy8TeKC1ExgrNai0eKQOXKXLQPq5iQLaAi8l5uFVdMAlA+b1CYpP3i
	tSpz9DdPoMITG+VyCA+r3BXsiTLkbemDdfLJbxmQXYtMJYFh+c91wN1Ujn+O17ko5h9SFzBgyk4
	LgCC8cArhKwjtG4qQJNoGXjBiR1VaMVRbs6JoleMCajeLzMfjGJekqLXJUuPbPRkckkd7yGSny2
	ZJNv14VeCMp4sFmL5VFGtQU+LpGJFE5bVDvmIRBSaguZoHAymTiJFgosPoKUfNbUpWo/umRrYlE
	KrEKQiCS3ZH0pK4Ed8UMCoYjZ8TQyeyJnZOfyA9F8crWcL36EACeLZkU1Q00N+/dEyhDIhlwShO
	2qdRb/rDAR0i/4a0XRVbX00JCvOBz2nN9ZzCifblD8Q0j1YcIK5FBMNomZSK4=
X-Received: by 2002:a05:6a21:3a48:b0:3b4:61f:1fec with SMTP id adf61e73a8af0-3cb85df12ddmr3853064637.2.1785895175722;
        Tue, 04 Aug 2026 18:59:35 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158678ec37sm9511938eec.23.2026.08.04.18.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:59:34 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Michail Tatas <michail.tatas@gmail.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, chleroy@kernel.org, atrajeev@linux.ibm.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/htmdump: Fix leak in htmdump_init_debugfs
In-Reply-To: <anJDq-JckR6j-6EJ@michalis-linux>
Date: Wed, 05 Aug 2026 07:24:01 +0530
Message-ID: <1pcdmix2.ritesh.list@gmail.com>
References: <anJDq-JckR6j-6EJ@michalis-linux>
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

Michail Tatas <michail.tatas@gmail.com> writes:

> If any allocation fails during init all previous allocations are
> leaked and the debugfs directory is left.
> Fix by freeing the allocations that have already happened and also
> remove the directory that has been created.
>
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>  arch/powerpc/platforms/pseries/htmdump.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/htmdump.c b/arch/powerpc/platforms/pseries/htmdump.c
> index 489a80e87082..f33941b80ada 100644
> --- a/arch/powerpc/platforms/pseries/htmdump.c
> +++ b/arch/powerpc/platforms/pseries/htmdump.c
> @@ -527,28 +527,28 @@ static int htmdump_init_debugfs(void)
>  	htm_status_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!htm_status_buf) {
>  		pr_err("Failed to allocate htmstatus buf\n");
> -		return -ENOMEM;
> +		goto htm_status_buf_err;
>  	}
>  
>  	/* Debugfs interface file to present System Processor Configuration */
>  	htm_info_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!htm_info_buf) {
>  		pr_err("Failed to allocate htm info buf\n");
> -		return -ENOMEM;
> +		goto htm_info_buf_err;
>  	}
>  
>  	/* Debugfs interface file to present HTM capabilities */
>  	htm_caps_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!htm_caps_buf) {
>  		pr_err("Failed to allocate htm caps buf\n");
> -		return -ENOMEM;
> +		goto htm_caps_buf_err;
>  	}
>  
>  	/* Memory to present HTM system memory configuration */
>  	htm_mem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!htm_mem_buf) {
>  		pr_err("Failed to allocate htm mem buf\n");
> -		return -ENOMEM;
> +		goto htm_mem_buf_err;
>  	}
>  
>  	debugfs_create_file("htmstatus", 0400, htmdump_debugfs_dir, htm_status_buf, &htmstatus_fops);
> @@ -557,6 +557,17 @@ static int htmdump_init_debugfs(void)
>  	debugfs_create_file("htmsystem_mem", 0400, htmdump_debugfs_dir, htm_mem_buf, &htmsystem_mem_fops);
>  
>  	return 0;
> +
> +htm_mem_buf_err:
> +	kfree(htm_caps_buf);
> +htm_caps_buf_err:
> +	kfree(htm_info_buf);
> +htm_info_buf_err:
> +	kfree(htm_status_buf);
> +htm_status_buf_err:
> +	debugfs_remove_recursive(htmdump_debugfs_dir);
> +	kfree(htm_buf);
> +	return -ENOMEM;
>  }

So far the only error this function returns is -ENOMEM, so this looks
ok. Later if someone adds a different error return value, then it should
introduce a new ret variable and we should return ret from here.

But as for this patch - this looks good to me. So please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


