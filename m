Return-Path: <SRS0=NKNt=YW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FACA9EAE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 17:09:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202C52067D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Oct 2019 17:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202C52067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 472dNz5gHTzF3CN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 04:09:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=virtuozzo.com (client-ip=185.231.240.75; helo=relay.sw.ru;
 envelope-from=aryabinin@virtuozzo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=virtuozzo.com
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 472dLW6f2kzF3BM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 04:07:30 +1100 (AEDT)
Received: from [172.16.25.5] by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <aryabinin@virtuozzo.com>)
 id 1iPUxo-0006eL-Lz; Tue, 29 Oct 2019 20:07:24 +0300
Subject: Re: [PATCH v10 3/5] fork: support VMAP_STACK with KASAN_VMALLOC
To: Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, x86@kernel.org, glider@google.com, luto@kernel.org,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, dvyukov@google.com,
 christophe.leroy@c-s.fr
References: <20191029042059.28541-1-dja@axtens.net>
 <20191029042059.28541-4-dja@axtens.net>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6dd97cbd-b3ac-3f53-36d6-489c45ddaf92@virtuozzo.com>
Date: Tue, 29 Oct 2019 20:07:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029042059.28541-4-dja@axtens.net>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 gor@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 10/29/19 7:20 AM, Daniel Axtens wrote:
> Supporting VMAP_STACK with KASAN_VMALLOC is straightforward:
> 
>  - clear the shadow region of vmapped stacks when swapping them in
>  - tweak Kconfig to allow VMAP_STACK to be turned on with KASAN
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 954e875e72b1..a6e5249ad74b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -94,6 +94,7 @@
>  #include <linux/livepatch.h>
>  #include <linux/thread_info.h>
>  #include <linux/stackleak.h>
> +#include <linux/kasan.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -224,6 +225,9 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>  		if (!s)
>  			continue;
>  
> +		/* Clear the KASAN shadow of the stack. */
> +		kasan_unpoison_shadow(s->addr, THREAD_SIZE);
> +


Just sharing the thought. We could possibly add poisoning in free_thread_stack()
to catch possible usage of freed cached stack. But it might be a bad idea because cached
stacks supposed to be reused very quickly. So it might just add overhead without much gain.



>  		/* Clear stale pointers from reused stack. */
>  		memset(s->addr, 0, THREAD_SIZE);
>  
> 
