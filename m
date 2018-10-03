Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9883FC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:43:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E687B2089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E687B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q60d2rKNzF3KF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:43:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5XP3HNyzF3C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:22:13 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42Q5XK0kvCz9ttBf;
 Wed,  3 Oct 2018 08:22:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 4zmC1pI3oQP3; Wed,  3 Oct 2018 08:22:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42Q5XK03p3z9ttBW;
 Wed,  3 Oct 2018 08:22:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5531F8B8B6;
 Wed,  3 Oct 2018 08:22:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id l8xyvgnMc4Mg; Wed,  3 Oct 2018 08:22:09 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B7D78B74C;
 Wed,  3 Oct 2018 08:22:09 +0200 (CEST)
Subject: Re: [PATCH] powerpc: use PTRRELOC during early init
To: Andreas Schwab <schwab@linux-m68k.org>, Michael Neuling <mikey@neuling.org>
References: <20180914011411.3184-1-mikey__14553.8904158913$1536887645$gmane$org@neuling.org>
 <871s98av6p.fsf__4781.35763337395$1538516654$gmane$org@igel.home>
 <87wor09dww.fsf_-_@igel.home>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <acfeead1-90f9-d13c-41f2-e4bdd38e3702@c-s.fr>
Date: Wed, 3 Oct 2018 08:22:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87wor09dww.fsf_-_@igel.home>
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
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Andreas,

Le 03/10/2018 à 00:33, Andreas Schwab a écrit :
> This fixes a crash on powerpc32 when using global data during early init
> without relocating its address.
> 
> Fixes: 51c3c62b58 (powerpc: Avoid code patching freed init sections)
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>   arch/powerpc/lib/code-patching.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 6ae2777c22..6192fdae36 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -29,7 +29,7 @@ static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
>   	int err;
>   
>   	/* Make sure we aren't patching a freed init section */
> -	if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
> +	if (*PTRRELOC(&init_mem_is_free) && init_section_contains(exec_addr, 4)) {

That's not the best solution. In the past we already did our best to 
separate early use of patch_instruction() , that's how 
raw_patch_instruction() was born, see 
https://patchwork.ozlabs.org/patch/840974/

Here, it idea is similar, this test should not apply to 
raw_patch_instruction()

Did you try my proposed fix https://patchwork.ozlabs.org/patch/977195/ ?

Christophe

>   		pr_debug("Skipping init section patching addr: 0x%px\n", exec_addr);
>   		return 0;
>   	}
> 
