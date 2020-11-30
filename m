Return-Path: <SRS0=CZBu=FE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654AC64E8A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 01:54:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2A820757
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 01:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="oGYp8psM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2A820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CkpF84S7qzDqGL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 12:54:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CkpBB0RrHzDrST
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 12:51:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=oGYp8psM; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CkpB92ch4z9sVD;
 Mon, 30 Nov 2020 12:51:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606701105;
 bh=xlIwgzjEPzyGOCP0bGlo84nJNsiFMwgliSsNWMJmGPY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=oGYp8psM5s7iCfh0zl1U86fugKwvbASdl8DteUCKa2vvvMf2Cj005dkMUX5VcDclt
 qnDlMQRu+2n1LKZD37QeFsmkVkHQeTaqSRF/K5vW3Fpm1GLzm+pIdfbBFXakuRT6+7
 7IrTzA03pca6fSkBoqdTzgicOKZ2O9ALaB19NAU9dTlN1NvqLgxloYM/fSAKJ3rXli
 ur4KdHEQQvMMIRbPIg64Or3epMyKM2Pgb4fGOs5JOaeiwt7GEduSJHujY8uKpL96c+
 9W/a6l9V6IG5Njgn7JQBHhq8rnCSG03PMgdi52yVgGSRhNP/D7ZDCutp8vAUJvaky6
 HNKYpkrKdHMSQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Qinglang Miao <miaoqinglang@huawei.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] powerpc/pseries/hotplug-cpu: fix memleak in
 dlpar_cpu_add_by_count
In-Reply-To: <20201128102001.95323-1-miaoqinglang@huawei.com>
References: <20201128102001.95323-1-miaoqinglang@huawei.com>
Date: Mon, 30 Nov 2020 12:51:44 +1100
Message-ID: <871rgby5lb.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Qinglang Miao <miaoqinglang@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Qinglang Miao <miaoqinglang@huawei.com> writes:
> kfree(cpu_drcs) should be called when it fails to perform
> of_find_node_by_path("/cpus") in dlpar_cpu_add_by_count,
> otherwise there would be a memleak.
>
> In fact, the patch a0ff72f9f5a7 ought to remove kfree in
> find_dlpar_cpus_to_add rather than dlpar_cpu_add_by_count.
> I guess there might be a mistake when apply that one.
>
> Fixes: a0ff72f9f5a7 ("powerpc/pseries/hotplug-cpu: Remove double free in error path")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-cpu.c | 1 +
>  1 file changed, 1 insertion(+)

This is already fixed in my next by:

  a40fdaf1420d ("Revert "powerpc/pseries/hotplug-cpu: Remove double free in error path"")

cheers

> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index f2837e33b..4bb1c9f2b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -743,6 +743,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>  	parent = of_find_node_by_path("/cpus");
>  	if (!parent) {
>  		pr_warn("Could not find CPU root node in device tree\n");
> +		kfree(cpu_drcs);
>  		return -1;
>  	}
>  
> -- 
> 2.23.0
