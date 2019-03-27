Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB53C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 13:46:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43412204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K1+aV994";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K1+aV994"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43412204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tq654wylzDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 00:46:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="K1+aV994"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="K1+aV994"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TnHs0jp2zDqBb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 23:24:40 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id D120960DB3; Wed, 27 Mar 2019 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553689477;
 bh=gijzqyAr0cZlcuTs4efC92bjQQamKU8Y/MHZrrZeZKk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=K1+aV994rMoV5qzPa7J06bCpOvCW/ps6/TKVMpNFIr8wGudb9MzzugYe1tkbW9apR
 dKOgT2Y6kCSjr1wcM7crvRyi9w9W8UnC/lmVKfUFxwHFoVcJkQ63ycr6KkyOoBNove
 LaL9mwX6ttzUTNroMe60w6ZuPNn/U1oSwv7MLy6Y=
Received: from [10.204.79.83]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F289609F3;
 Wed, 27 Mar 2019 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553689477;
 bh=gijzqyAr0cZlcuTs4efC92bjQQamKU8Y/MHZrrZeZKk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=K1+aV994rMoV5qzPa7J06bCpOvCW/ps6/TKVMpNFIr8wGudb9MzzugYe1tkbW9apR
 dKOgT2Y6kCSjr1wcM7crvRyi9w9W8UnC/lmVKfUFxwHFoVcJkQ63ycr6KkyOoBNove
 LaL9mwX6ttzUTNroMe60w6ZuPNn/U1oSwv7MLy6Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F289609F3
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 2/2] Remove functions holly_power_off and holly_halt
 since unused
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190312203140.31785-1-malat@debian.org>
 <20190326204720.18882-1-malat@debian.org>
 <20190326204720.18882-2-malat@debian.org>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <afabee7f-ab93-84ef-9efe-341f6ca26af4@codeaurora.org>
Date: Wed, 27 Mar 2019 17:54:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326204720.18882-2-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Approved-At: Thu, 28 Mar 2019 00:44:34 +1100
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 3/27/2019 2:17 AM, Mathieu Malaterre wrote:
> Silence the following warnings triggered using W=1:
>
>    arch/powerpc/platforms/embedded6xx/holly.c:236:6: error: no previous prototype for 'holly_power_off' [-Werror=missing-prototypes]
>    arch/powerpc/platforms/embedded6xx/holly.c:243:6: error: no previous prototype for 'holly_halt' [-Werror=missing-prototypes]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


> ---
>   arch/powerpc/platforms/embedded6xx/holly.c | 12 ------------
>   1 file changed, 12 deletions(-)
>
> diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
> index 9d2eefef7b7b..829bf3697dc9 100644
> --- a/arch/powerpc/platforms/embedded6xx/holly.c
> +++ b/arch/powerpc/platforms/embedded6xx/holly.c
> @@ -234,18 +234,6 @@ static void __noreturn holly_restart(char *cmd)
>   	for (;;) ;
>   }
>   
> -void holly_power_off(void)
> -{
> -	local_irq_disable();
> -	/* No way to shut power off with software */
> -	for (;;) ;
> -}
> -
> -void holly_halt(void)
> -{
> -	holly_power_off();
> -}
> -
>   /*
>    * Called very early, device-tree isn't unflattened
>    */
