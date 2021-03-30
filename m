Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73B3C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 05:06:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C19361924
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 05:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C19361924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8cqB43YYz3cDv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 16:06:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8cpp4RSJz2yy0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 16:05:54 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4F8cpl4yYsz9txNc;
 Tue, 30 Mar 2021 07:05:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id FuF7edQKtkHX; Tue, 30 Mar 2021 07:05:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4F8cpl3zZ3z9txNb;
 Tue, 30 Mar 2021 07:05:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BEAB58B7E7;
 Tue, 30 Mar 2021 07:05:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id kPXz2HGuX8KL; Tue, 30 Mar 2021 07:05:51 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 041388B75B;
 Tue, 30 Mar 2021 07:05:50 +0200 (CEST)
Subject: Re: [PATCH v10 04/10] powerpc/kprobes: Mark newly allocated probes as
 ROX
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20210330045132.722243-1-jniethe5@gmail.com>
 <20210330045132.722243-5-jniethe5@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d61a1b2f-4a22-fb43-e8fe-a7612431c4ad@csgroup.eu>
Date: Tue, 30 Mar 2021 07:05:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330045132.722243-5-jniethe5@gmail.com>
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
 naveen.n.rao@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 30/03/2021 à 06:51, Jordan Niethe a écrit :
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
> ---
>   arch/powerpc/kernel/kprobes.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> index 01ab2163659e..3ae27af9b094 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -25,6 +25,7 @@
>   #include <asm/sections.h>
>   #include <asm/inst.h>
>   #include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
>   
>   DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>   DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> @@ -103,6 +104,19 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>   	return addr;
>   }
>   
> +void *alloc_insn_page(void)
> +{
> +	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
> +		return __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR, MODULES_END,
> +				GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> +				NUMA_NO_NODE, __builtin_return_address(0));
> +	} else {
> +		return __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR, MODULES_END,
> +				GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
> +				NUMA_NO_NODE, __builtin_return_address(0));
> +	}
> +}
> +

What about

void *alloc_insn_page(void)
{
	pgprot_t prot = IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;

	return __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR, MODULES_END,
			GFP_KERNEL, prot, VM_FLUSH_RESET_PERMS,
			NUMA_NO_NODE, __builtin_return_address(0));
}

>   int arch_prepare_kprobe(struct kprobe *p)
>   {
>   	int ret = 0;
> 
