Return-Path: <SRS0=42OU=IK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78709C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 13:12:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AEA64FA7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 13:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AEA64FA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DxmSx1ChMz3fZd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Mar 2021 00:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DxmSb0n7Nz3dHC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Mar 2021 00:12:29 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DxmSV0l1Cz9ttBZ;
 Fri, 12 Mar 2021 14:12:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dbspsLRag-9D; Fri, 12 Mar 2021 14:12:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DxmST7393z9ttBX;
 Fri, 12 Mar 2021 14:12:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CB1478B814;
 Fri, 12 Mar 2021 14:12:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id hkgekSXdy3BK; Fri, 12 Mar 2021 14:12:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BFCA8B764;
 Fri, 12 Mar 2021 14:12:26 +0100 (CET)
Subject: Re: [PATCH] powerpc: Force inlining of cpu_has_feature() to avoid
 build failure
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>
References: <b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu>
Message-ID: <c3563256-7cde-3a42-dbf0-6ce31141ad30@csgroup.eu>
Date: Fri, 12 Mar 2021 14:12:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b231dfa040ce4cc37f702f5c3a595fdeabfe0462.1615378209.git.christophe.leroy@csgroup.eu>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/03/2021 à 13:10, Christophe Leroy a écrit :
> The code relies on constant folding of cpu_has_feature() based
> on possible and always true values as defined per
> CPU_FTRS_ALWAYS and CPU_FTRS_POSSIBLE.
> 
> Build failure is encountered with for instance
> book3e_all_defconfig on kisskb in the AMDGPU driver which uses
> cpu_has_feature(CPU_FTR_VSX_COMP) to decide whether calling
> kernel_enable_vsx() or not.
> 
> The failure is due to cpu_has_feature() not being inlined with
> that configuration with gcc 4.9.
> 
> In the same way as commit acdad8fb4a15 ("powerpc: Force inlining of
> mmu_has_feature to fix build failure"), for inlining of
> cpu_has_feature().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Fixes following build

http://kisskb.ellerman.id.au/kisskb/buildresult/14489391/

> ---
>   arch/powerpc/include/asm/cpu_has_feature.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
> index 7897d16e0990..727d4b321937 100644
> --- a/arch/powerpc/include/asm/cpu_has_feature.h
> +++ b/arch/powerpc/include/asm/cpu_has_feature.h
> @@ -7,7 +7,7 @@
>   #include <linux/bug.h>
>   #include <asm/cputable.h>
>   
> -static inline bool early_cpu_has_feature(unsigned long feature)
> +static __always_inline bool early_cpu_has_feature(unsigned long feature)
>   {
>   	return !!((CPU_FTRS_ALWAYS & feature) ||
>   		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
> @@ -46,7 +46,7 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
>   	return static_branch_likely(&cpu_feature_keys[i]);
>   }
>   #else
> -static inline bool cpu_has_feature(unsigned long feature)
> +static __always_inline bool cpu_has_feature(unsigned long feature)
>   {
>   	return early_cpu_has_feature(feature);
>   }
> 
