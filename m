Return-Path: <SRS0=fZjV=DT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B8AC433E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 11:32:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EE72080D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 11:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EE72080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C8xNV6fLKzDqmT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 22:32:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C8xK50qb9zDqkj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2020 22:29:11 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DE649ABCC;
 Mon, 12 Oct 2020 11:29:06 +0000 (UTC)
Date: Mon, 12 Oct 2020 13:29:05 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] powerpc/perf: fix Threshold Event CounterMultiplier
 width for P10
Message-ID: <20201012112905.GQ29778@kitsune.suse.cz>
References: <20201012103128.53243-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012103128.53243-1-maddy@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On Mon, Oct 12, 2020 at 04:01:28PM +0530, Madhavan Srinivasan wrote:
> Power9 and isa v3.1 has 7bit mantissa field for Threshold Event Counter
                  ^^^ Shouldn't his be 3.0?

> Multiplier (TECM). TECM is part of Monitor Mode Control Register A (MMCRA).
> This field along with Threshold Event Counter Exponent (TECE) is used to
> get threshould counter value. In Power10, the width of TECM field is
> increase to 8bits. Patch fixes the current code to modify the MMCRA[TECM]
> extraction macro to handling this changes.
> 
> Fixes: 170a315f41c64 ('powerpc/perf: Support to export MMCRA[TEC*] field to userspace')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  arch/powerpc/perf/isa207-common.c | 3 +++
>  arch/powerpc/perf/isa207-common.h | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
> index 964437adec18..5fe129f02290 100644
> --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -247,6 +247,9 @@ void isa207_get_mem_weight(u64 *weight)
>  	u64 sier = mfspr(SPRN_SIER);
>  	u64 val = (sier & ISA207_SIER_TYPE_MASK) >> ISA207_SIER_TYPE_SHIFT;
>  
> +	if (cpu_has_feature(CPU_FTR_ARCH_31))
> +		mantissa = P10_MMCRA_THR_CTR_MANT(mmcra);
> +
>  	if (val == 0 || val == 7)
>  		*weight = 0;
>  	else
> diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
> index 044de65e96b9..71380e854f48 100644
> --- a/arch/powerpc/perf/isa207-common.h
> +++ b/arch/powerpc/perf/isa207-common.h
> @@ -219,6 +219,10 @@
>  #define MMCRA_THR_CTR_EXP(v)		(((v) >> MMCRA_THR_CTR_EXP_SHIFT) &\
>  						MMCRA_THR_CTR_EXP_MASK)
>  
> +#define P10_MMCRA_THR_CTR_MANT_MASK	0xFFul
> +#define P10_MMCRA_THR_CTR_MANT(v)	(((v) >> MMCRA_THR_CTR_MANT_SHIFT) &\
> +						P10_MMCRA_THR_CTR_MANT_MASK)
> +
>  /* MMCRA Threshold Compare bit constant for power9 */
>  #define p9_MMCRA_THR_CMP_SHIFT	45
>  
> -- 
> 2.26.2
> 
