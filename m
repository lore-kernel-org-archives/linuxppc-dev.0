Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B6EC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 06:42:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF4E60F39
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 06:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDF4E60F39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqJHf1nWxz3cWk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 16:42:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqJH83rqyz2yMx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 16:42:24 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GqJH06ckGz9sVX;
 Wed, 18 Aug 2021 08:42:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BlboCUcmPLhC; Wed, 18 Aug 2021 08:42:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GqJH05SCXz9sVD;
 Wed, 18 Aug 2021 08:42:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9988E8B7D3;
 Wed, 18 Aug 2021 08:42:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id KISUn5YdRZul; Wed, 18 Aug 2021 08:42:20 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B20628B766;
 Wed, 18 Aug 2021 08:42:19 +0200 (CEST)
Subject: Re: [PATCH v2 61/63] powerpc: Split memset() to avoid multi-field
 overflow
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-62-keescook@chromium.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7630b0bc-4389-6283-d8b9-c532df916d60@csgroup.eu>
Date: Wed, 18 Aug 2021 08:42:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818060533.3569517-62-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 clang-built-linux@googlegroups.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wang Wensheng <wangwensheng4@huawei.com>, linux-staging@lists.linux.dev,
 linux-wireless@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Qinglang Miao <miaoqinglang@huawei.com>, linux-block@vger.kernel.org,
 Hulk Robot <hulkci@huawei.com>, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
 linux-hardening@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/08/2021 à 08:05, Kees Cook a écrit :
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Instead of writing across a field boundary with memset(), move the call
> to just the array, and an explicit zeroing of the prior field.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Qinglang Miao <miaoqinglang@huawei.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Hulk Robot <hulkci@huawei.com>
> Cc: Wang Wensheng <wangwensheng4@huawei.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://lore.kernel.org/lkml/87czqsnmw9.fsf@mpe.ellerman.id.au
> ---
>   drivers/macintosh/smu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> index 94fb63a7b357..59ce431da7ef 100644
> --- a/drivers/macintosh/smu.c
> +++ b/drivers/macintosh/smu.c
> @@ -848,7 +848,8 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
>   	cmd->read = cmd->info.devaddr & 0x01;
>   	switch(cmd->info.type) {
>   	case SMU_I2C_TRANSFER_SIMPLE:
> -		memset(&cmd->info.sublen, 0, 4);
> +		cmd->info.sublen = 0;
> +		memset(&cmd->info.subaddr, 0, 3);

subaddr[] is a table, should the & be avoided ?
And while at it, why not use sizeof(subaddr) instead of 3 ?


>   		break;
>   	case SMU_I2C_TRANSFER_COMBINED:
>   		cmd->info.devaddr &= 0xfe;
> 
