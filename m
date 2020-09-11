Return-Path: <SRS0=VWG1=CU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656A9C43461
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 05:46:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C27721D40
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 05:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C27721D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bnl9P0YCrzDqs8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2020 15:46:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bnl4x4qpczDqmh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2020 15:42:09 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4Bnl4s2fmPz9tynV;
 Fri, 11 Sep 2020 07:42:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id j3GgCwTB0Taa; Fri, 11 Sep 2020 07:42:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Bnl4s1hY0z9tynT;
 Fri, 11 Sep 2020 07:42:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1ECF38B832;
 Fri, 11 Sep 2020 07:42:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gHaZW7jMsmxp; Fri, 11 Sep 2020 07:42:06 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C4AE68B75E;
 Fri, 11 Sep 2020 07:42:05 +0200 (CEST)
Subject: Re: [PATCH 6/7] powerpc/perf: Fix W=1 compile warning
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20200910210250.1962595-1-clg@kaod.org>
 <20200910210250.1962595-7-clg@kaod.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8ba0c9b8-cb58-32e5-ea60-ab7106e30e21@csgroup.eu>
Date: Fri, 11 Sep 2020 07:42:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910210250.1962595-7-clg@kaod.org>
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
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/09/2020 à 23:02, Cédric Le Goater a écrit :
> CC      arch/powerpc/perf/imc-pmu.o
> ../arch/powerpc/perf/imc-pmu.c: In function ‘trace_imc_event_init’:
> ../arch/powerpc/perf/imc-pmu.c:1429:22: error: variable ‘target’ set but not used [-Werror=unused-but-set-variable]
>    struct task_struct *target;
>                        ^~~~~~

A small sentence explaining how this is fixed would be welcome, so that 
you don't need to read the code the know what the commit does to fix the 
warning. Also the subject should be more explicit.

> 
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   arch/powerpc/perf/imc-pmu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index 62d0b54086f8..9ed4fcccf8a9 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1426,8 +1426,6 @@ static void trace_imc_event_del(struct perf_event *event, int flags)
>   
>   static int trace_imc_event_init(struct perf_event *event)
>   {
> -	struct task_struct *target;
> -
>   	if (event->attr.type != event->pmu->type)
>   		return -ENOENT;
>   
> @@ -1458,7 +1456,6 @@ static int trace_imc_event_init(struct perf_event *event)
>   	mutex_unlock(&imc_global_refc.lock);
>   
>   	event->hw.idx = -1;
> -	target = event->hw.target;
>   
>   	event->pmu->task_ctx_nr = perf_hw_context;
>   	event->destroy = reset_global_refc;
> 
