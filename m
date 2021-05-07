Return-Path: <SRS0=iVLG=KC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F183DC433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 05:34:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E79E613DD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 05:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E79E613DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fbzfm3ndKz308P
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 15:34:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FbzfN5H99z2xZR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 May 2021 15:34:33 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4FbzfG3vNtz9sYf;
 Fri,  7 May 2021 07:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uy_ASPvgxu1v; Fri,  7 May 2021 07:34:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4FbzfG2ts9z9sYd;
 Fri,  7 May 2021 07:34:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 40CC08B810;
 Fri,  7 May 2021 07:34:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id gHabLSyNOs9D; Fri,  7 May 2021 07:34:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D3838B764;
 Fri,  7 May 2021 07:34:29 +0200 (CEST)
Subject: Re: [PATCH v12 3/8] powerpc/kprobes: Mark newly allocated probes as
 ROX
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20210506023449.3568630-1-jniethe5@gmail.com>
 <20210506023449.3568630-4-jniethe5@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <18553e58-a91a-f19f-de80-2b2e42c87fd2@csgroup.eu>
Date: Fri, 7 May 2021 07:34:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210506023449.3568630-4-jniethe5@gmail.com>
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
Cc: ajd@linux.ibm.com, npiggin@gmail.com, cmr@codefail.de,
 aneesh.kumar@linux.ibm.com, naveen.n.rao@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 06/05/2021 à 04:34, Jordan Niethe a écrit :
> From: Russell Currey <ruscur@russell.cc>
> 
> Add the arch specific insn page allocator for powerpc. This allocates
> ROX pages if STRICT_KERNEL_RWX is enabled. These pages are only written
> to with patch_instruction() which is able to write RO pages.
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> [jpn: Reword commit message, switch to __vmalloc_node_range()]
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v9: - vmalloc_exec() no longer exists
>      - Set the page to RW before freeing it
> v10: - use __vmalloc_node_range()
> v11: - Neaten up
> v12: - Switch from __vmalloc_node_range() to module_alloc()
> ---
>   arch/powerpc/kernel/kprobes.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 01ab2163659e..73a294802f72 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -19,11 +19,13 @@
>   #include <linux/extable.h>
>   #include <linux/kdebug.h>
>   #include <linux/slab.h>
> +#include <linux/moduleloader.h>
>   #include <asm/code-patching.h>
>   #include <asm/cacheflush.h>
>   #include <asm/sstep.h>
>   #include <asm/sections.h>
>   #include <asm/inst.h>
> +#include <asm/set_memory.h>
>   #include <linux/uaccess.h>
>   
>   DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
> @@ -103,6 +105,21 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>   	return addr;
>   }
>   
> +void *alloc_insn_page(void)
> +{
> +	void *page;
> +
> +	page = module_alloc(PAGE_SIZE);
> +	if (!page)
> +		return NULL;
> +
> +	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX)) {

I'm not sure this test is OK, because strict kernel/module rwx can be disabled at boottime.
There is a global variable 'rodata_enabled' to reflect that.

We have a helper in powerpc asm/mmu.h called strict_kernel_rwx_enabled() to check it.


> +		set_memory_ro((unsigned long)page, 1);
> +		set_memory_x((unsigned long)page, 1);
> +	}
> +	return page;
> +}
> +
>   int arch_prepare_kprobe(struct kprobe *p)
>   {
>   	int ret = 0;
> 
