Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FBAC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:21:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065CA20674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMU/Fv+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065CA20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44krD63MmBzDqL5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 04:21:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="GMU/Fv+k"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kr9x2309zDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 04:19:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3qFLY8cDeOYehuBn5cRrDUkDX75dEgaFFdO5IYDJgUY=; b=GMU/Fv+kSMV4z0zGIpaoI09/rI
 lSrTPyF6uNB6dwNzOiOJWlp9lUlqh+v2MrGu7UmVFFy9SDX8SdIsFhHTS9BgJiXpEVqkM7rBWDzq5
 nKrhcD3XQanYDFntb/uoK7HsRxsql1bQd7Ak1Ijujg+3WZ9f+5salVpZTwubjEnvtnDL2pCTs5jjy
 cdsaEfSJ+HiYRdwBGq4gZvBVflTHtrtAVFKoGnkbpjungATbKOpkpc2wuE18fXxu9y9HLTgfb7tpu
 9qoCm+mr2oC2PPqDczB15GGsvGgRFtcUtke7N7me+QfkjrMMlJrLAj863AatHUqxhaWjGVn+EnJtP
 D1mtLy3g==;
Received: from [199.233.58.37] (helo=[10.83.93.157])
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hGp9g-0007mL-E5; Wed, 17 Apr 2019 18:19:32 +0000
Subject: Re: [PATCH -next] ALSA: ps3: Remove set but not used variables
 'start_vaddr' and 'pcm_index'
To: Yue Haibing <yuehaibing@huawei.com>, perex@perex.cz, tiwai@suse.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20190417145722.20448-1-yuehaibing@huawei.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <1078ccec-2cc9-f16d-caca-32ac9c3cce4d@infradead.org>
Date: Wed, 17 Apr 2019 11:19:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417145722.20448-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/17/19 7:57 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warnings:
> 
> sound/ppc/snd_ps3.c: In function 'snd_ps3_program_dma':
> sound/ppc/snd_ps3.c:236:8: warning: variable 'start_vaddr' set but not used [-Wunused-but-set-variable]
> sound/ppc/snd_ps3.c: In function 'snd_ps3_pcm_open':
> sound/ppc/snd_ps3.c:529:6: warning: variable 'pcm_index' set but not used [-Wunused-but-set-variable]
> 
> They are never used and can be removed.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/ppc/snd_ps3.c | 4 ----
>  1 file changed, 4 deletions(-)

Seems OK.  Thanks for submitting.

Acked-by: Geoff Levand <geoff@infradead.org>
