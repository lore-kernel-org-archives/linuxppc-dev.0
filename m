Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CAAC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 06:57:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29494208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 06:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29494208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433vj66B0vzDqdt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:56:58 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 433vfk3Zd1zDqcm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 17:54:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 433vfb67zfz9vGl5;
 Tue, 27 Nov 2018 07:54:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id f6cNm9b6MNnj; Tue, 27 Nov 2018 07:54:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 433vfb5TdPz9vGl0;
 Tue, 27 Nov 2018 07:54:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CA2A88B7D7;
 Tue, 27 Nov 2018 07:54:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZYMO7kbOHQVE; Tue, 27 Nov 2018 07:54:41 +0100 (CET)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DEAE8B7CF;
 Tue, 27 Nov 2018 07:54:40 +0100 (CET)
Subject: Re: [PATCH RESEND] powerpc/perf: Update perf_regs structure to
 include SIER
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 acme@kernel.org
References: <1543255448-27552-1-git-send-email-maddy@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <20d4dbad-3b93-37dd-2278-74356bec3393@c-s.fr>
Date: Tue, 27 Nov 2018 07:54:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543255448-27552-1-git-send-email-maddy@linux.vnet.ibm.com>
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/11/2018 à 19:04, Madhavan Srinivasan a écrit :
> On each sample, Sample Instruction Event Register (SIER) content
> is saved in pt_regs. SIER does not have a entry as-is in the pt_regs
> but instead, SIER content is saved in the "dar" register of pt_regs.
> 
> Patch adds another entry to the perf_regs structure to include the "SIER"
> printing which internally maps to the "dar" of pt_regs.
> 
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---

I see this patch is already in patchwork 
https://patchwork.ozlabs.org/patch/941908/ and I can't spot any 
difference between the two. Please say here (under the ---) the reason 
for resending.

Christophe


>   arch/powerpc/include/uapi/asm/perf_regs.h       | 1 +
>   arch/powerpc/perf/perf_regs.c                   | 1 +
>   tools/arch/powerpc/include/uapi/asm/perf_regs.h | 1 +
>   tools/perf/arch/powerpc/include/perf_regs.h     | 3 ++-
>   tools/perf/arch/powerpc/util/perf_regs.c        | 1 +
>   5 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
> index 9e52c86ccbd3..ff91192407d1 100644
> --- a/arch/powerpc/include/uapi/asm/perf_regs.h
> +++ b/arch/powerpc/include/uapi/asm/perf_regs.h
> @@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
>   	PERF_REG_POWERPC_TRAP,
>   	PERF_REG_POWERPC_DAR,
>   	PERF_REG_POWERPC_DSISR,
> +	PERF_REG_POWERPC_SIER,
>   	PERF_REG_POWERPC_MAX,
>   };
>   #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
> index 09ceea6175ba..c262aea22ad9 100644
> --- a/arch/powerpc/perf/perf_regs.c
> +++ b/arch/powerpc/perf/perf_regs.c
> @@ -69,6 +69,7 @@ static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
>   	PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
>   	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
>   	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_SIER, dar),
>   };
>   
>   u64 perf_reg_value(struct pt_regs *regs, int idx)
> diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
> index 9e52c86ccbd3..ff91192407d1 100644
> --- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
> @@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
>   	PERF_REG_POWERPC_TRAP,
>   	PERF_REG_POWERPC_DAR,
>   	PERF_REG_POWERPC_DSISR,
> +	PERF_REG_POWERPC_SIER,
>   	PERF_REG_POWERPC_MAX,
>   };
>   #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
> diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
> index 00e37b106913..1076393e6f43 100644
> --- a/tools/perf/arch/powerpc/include/perf_regs.h
> +++ b/tools/perf/arch/powerpc/include/perf_regs.h
> @@ -62,7 +62,8 @@ static const char *reg_names[] = {
>   	[PERF_REG_POWERPC_SOFTE] = "softe",
>   	[PERF_REG_POWERPC_TRAP] = "trap",
>   	[PERF_REG_POWERPC_DAR] = "dar",
> -	[PERF_REG_POWERPC_DSISR] = "dsisr"
> +	[PERF_REG_POWERPC_DSISR] = "dsisr",
> +	[PERF_REG_POWERPC_SIER] = "sier"
>   };
>   
>   static inline const char *perf_reg_name(int id)
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
> index ec50939b0418..07fcd977d93e 100644
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
> @@ -52,6 +52,7 @@ const struct sample_reg sample_reg_masks[] = {
>   	SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
>   	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
>   	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
> +	SMPL_REG(sier, PERF_REG_POWERPC_SIER),
>   	SMPL_REG_END
>   };
>   
> 
