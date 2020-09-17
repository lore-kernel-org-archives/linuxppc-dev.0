Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B8C43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:38:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A632087D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="K1UY89jC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A632087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bsc1x0dytzDqH6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 22:37:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsbCM44lSzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 22:01:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=K1UY89jC; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BsbCK5G3Rz9sS8;
 Thu, 17 Sep 2020 22:01:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1600344062;
 bh=drKiJPh6uUahqNiKyElUeAZk2wIXu3ZhA3NKB9nCYcw=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=K1UY89jCixp72jlWeIPSfpOB7vyiQ2pwGnUFVvsf0B2FOmy7/yaCzh6UCT7p5W/Yw
 70F9JkRP1E9jKlutDTKywLjjzj6Z7rg+8fYmE/G3k7D7HgEbb3MZ+NwOlLDgTRQYUZ
 1EkTImlGWMYYzoDYOlmr87dXl+80hpg4SFZC85Sh4waowIocEYUUT+DLl8FpyH4Lg3
 7gvv3s+HIp1yRZ6pXo3wGCKVhpn7poXOIMnY9q3+HVTGh4Fj4eGnUUF3YyPN+AEAHi
 HPh+GRDX7d+HzQwYacuaSKo1D3gk/4OVThEvPTzsv/53OHblkyoZq4enad7HsrK5Ys
 CKSIckbWyg/Gw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wang Wensheng <wangwensheng4@huawei.com>, davem@davemloft.net,
 benh@kernel.crashing.org, paulus@samba.org, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ide: Fix symbol undeclared warnings
In-Reply-To: <20200916092333.77158-1-wangwensheng4@huawei.com>
References: <20200916092333.77158-1-wangwensheng4@huawei.com>
Date: Thu, 17 Sep 2020 22:01:00 +1000
Message-ID: <87zh5oobnn.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wang Wensheng <wangwensheng4@huawei.com> writes:
> Build the object file with `C=2` and get the following warnings:
> make allmodconfig ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
> make C=2 drivers/ide/pmac.o ARCH=powerpc64
> CROSS_COMPILE=powerpc64-linux-gnu-
>
> drivers/ide/pmac.c:228:23: warning: symbol 'mdma_timings_33' was not
> declared. Should it be static?
> drivers/ide/pmac.c:241:23: warning: symbol 'mdma_timings_33k' was not
> declared. Should it be static?
> drivers/ide/pmac.c:254:23: warning: symbol 'mdma_timings_66' was not
> declared. Should it be static?
> drivers/ide/pmac.c:272:3: warning: symbol 'kl66_udma_timings' was not
> declared. Should it be static?
> drivers/ide/pmac.c:1418:12: warning: symbol 'pmac_ide_probe' was not
> declared. Should it be static?
>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/ide/pmac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

TIL davem maintains IDE?

But I suspect he isn't that interested in this powerpc only driver, so
I'll grab this.

cheers


> diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
> index ea0b064b5f56..6bb2fc6755c2 100644
> --- a/drivers/ide/pmac.c
> +++ b/drivers/ide/pmac.c
> @@ -225,7 +225,7 @@ struct mdma_timings_t {
>  	int	cycleTime;
>  };
>  
> -struct mdma_timings_t mdma_timings_33[] =
> +static struct mdma_timings_t mdma_timings_33[] =
>  {
>      { 240, 240, 480 },
>      { 180, 180, 360 },
> @@ -238,7 +238,7 @@ struct mdma_timings_t mdma_timings_33[] =
>      {   0,   0,   0 }
>  };
>  
> -struct mdma_timings_t mdma_timings_33k[] =
> +static struct mdma_timings_t mdma_timings_33k[] =
>  {
>      { 240, 240, 480 },
>      { 180, 180, 360 },
> @@ -251,7 +251,7 @@ struct mdma_timings_t mdma_timings_33k[] =
>      {   0,   0,   0 }
>  };
>  
> -struct mdma_timings_t mdma_timings_66[] =
> +static struct mdma_timings_t mdma_timings_66[] =
>  {
>      { 240, 240, 480 },
>      { 180, 180, 360 },
> @@ -265,7 +265,7 @@ struct mdma_timings_t mdma_timings_66[] =
>  };
>  
>  /* KeyLargo ATA-4 Ultra DMA timings (rounded) */
> -struct {
> +static struct {
>  	int	addrSetup; /* ??? */
>  	int	rdy2pause;
>  	int	wrDataSetup;
> @@ -1415,7 +1415,7 @@ static struct pci_driver pmac_ide_pci_driver = {
>  };
>  MODULE_DEVICE_TABLE(pci, pmac_ide_pci_match);
>  
> -int __init pmac_ide_probe(void)
> +static int __init pmac_ide_probe(void)
>  {
>  	int error;
>  
> -- 
> 2.25.0
