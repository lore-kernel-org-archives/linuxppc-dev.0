Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E34C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 05:18:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA6460F35
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 05:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBA6460F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GkLnL2m6Wz30Gv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 15:17:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GkLmp34Mwz30BX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Aug 2021 15:17:25 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GkLmc1yzQz9sT9;
 Tue, 10 Aug 2021 07:17:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MgdmHR7O5we5; Tue, 10 Aug 2021 07:17:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GkLmc10wxz9sT8;
 Tue, 10 Aug 2021 07:17:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 03C938B7A1;
 Tue, 10 Aug 2021 07:17:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id SrZno9X1pjYE; Tue, 10 Aug 2021 07:17:19 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9523F8B76A;
 Tue, 10 Aug 2021 07:17:19 +0200 (CEST)
Subject: Re: [PATCH] powerpc/book3s64/radix: make
 tlb_single_page_flush_ceiling a debugfs entry
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
References: <20210810045307.11892-1-aneesh.kumar@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <22c7c194-d75d-bf90-c8e5-83c995c7130c@csgroup.eu>
Date: Tue, 10 Aug 2021 07:17:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810045307.11892-1-aneesh.kumar@linux.ibm.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 10/08/2021 à 06:53, Aneesh Kumar K.V a écrit :
> Similar to x86/s390 add a debugfs file to tune tlb_single_page_flush_ceiling.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   arch/powerpc/mm/book3s64/radix_tlb.c | 48 ++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index aefc100d79a7..5cca0fe130e7 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -17,6 +17,7 @@
>   #include <asm/trace.h>
>   #include <asm/cputhreads.h>
>   #include <asm/plpar_wrappers.h>
> +#include <asm/debugfs.h>
>   
>   #include "internal.h"
>   
> @@ -1524,3 +1525,50 @@ void do_h_rpt_invalidate_prt(unsigned long pid, unsigned long lpid,
>   EXPORT_SYMBOL_GPL(do_h_rpt_invalidate_prt);
>   
>   #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> +
> +static ssize_t tlbflush_read_file(struct file *file, char __user *user_buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	char buf[32];
> +	unsigned int len;
> +
> +	len = sprintf(buf, "%ld\n", tlb_single_page_flush_ceiling);
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
> +}
> +
> +static ssize_t tlbflush_write_file(struct file *file,
> +		 const char __user *user_buf, size_t count, loff_t *ppos)
> +{
> +	char buf[32];
> +	ssize_t len;
> +	int ceiling;
> +
> +	len = min(count, sizeof(buf) - 1);
> +	if (copy_from_user(buf, user_buf, len))
> +		return -EFAULT;
> +
> +	buf[len] = '\0';
> +	if (kstrtoint(buf, 0, &ceiling))
> +		return -EINVAL;
> +
> +	if (ceiling < 0)
> +		return -EINVAL;
> +
> +	tlb_single_page_flush_ceiling = ceiling;
> +	return count;
> +}
> +
> +static const struct file_operations fops_tlbflush = {
> +	.read = tlbflush_read_file,
> +	.write = tlbflush_write_file,
> +	.llseek = default_llseek,
> +};
> +
> +static int __init create_tlb_single_page_flush_ceiling(void)
> +{
> +	debugfs_create_file("tlb_single_page_flush_ceiling", S_IRUSR | S_IWUSR,
> +			    powerpc_debugfs_root, NULL, &fops_tlbflush);

Could you just use debugfs_create_u32() instead of re-implementing simple read and write ?

Or at least use DEFINE_DEBUGFS_ATTRIBUTE() if you need something a bit more elaborated ?

> +	return 0;
> +}
> +late_initcall(create_tlb_single_page_flush_ceiling);
> +
> 
