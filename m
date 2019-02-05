Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E661DC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 18:12:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B55F2175B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="G5IwqZU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B55F2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vCNn276FzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 05:12:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="G5IwqZU5"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vCM3184nzDq7k
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 05:11:26 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43vCLx2Vgmz9v31Z;
 Tue,  5 Feb 2019 19:11:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=G5IwqZU5; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id DRlQCa-z-TpO; Tue,  5 Feb 2019 19:11:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43vCLx0qnVz9v31Y;
 Tue,  5 Feb 2019 19:11:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549390281; bh=nGpIwtjdLVZ+t5ASl9uCArhuBc6rS4fZX5PJekS70s4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=G5IwqZU53Uv5oHsjy8F0pxOhLexe9ZgcCQsmCLME5ECrglK0XYZv46QEuYjmXQUgZ
 Hx05bDjQer0CXm0YiM+VZ8vR0klkfpXW9m/+N2kG1uet6MeNZgJZdZqXRR8l+NcZ67
 Yjh/Vn67a7CopS1cRJHt8+/1n1Ju1ET459PIrRh8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CE1BC8B822;
 Tue,  5 Feb 2019 19:11:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id S1EOY5DY01m1; Tue,  5 Feb 2019 19:11:22 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 76E278B81A;
 Tue,  5 Feb 2019 19:11:22 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: move a KERN_WARNING message to KERN_DEBUG
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
References: <20190205180329.1452-1-lvivier@redhat.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ad592bd1-be25-2c3e-50ae-9d31913b9b2d@c-s.fr>
Date: Tue, 5 Feb 2019 19:11:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190205180329.1452-1-lvivier@redhat.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 05/02/2019 à 19:03, Laurent Vivier a écrit :
> resize_hpt_for_hotplug() reports a warning when it cannot
> increase the hash page table ("Unable to resize hash page
> table to target order") but this is not blocking and
> can make user thinks something has not worked properly.
> 
> If the operation cannot be done the real error message
> will be reported by arch_add_memory() if create_section_mapping()
> fails.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   arch/powerpc/mm/hash_utils_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 0cc7fbc3bd1c..b762bdceb510 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -778,7 +778,7 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
>   
>   		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
>   		if (rc && (rc != -ENODEV))
> -			printk(KERN_WARNING
> +			printk(KERN_DEBUG

You should use pr_debug() instead.

Christophe

>   			       "Unable to resize hash page table to target order %d: %d\n",
>   			       target_hpt_shift, rc);
>   	}
> 
