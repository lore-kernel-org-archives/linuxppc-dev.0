Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124D9C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:58:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C07206A3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Wkprvgxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C07206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44prkR04gszDqRs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:58:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Wkprvgxf"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44prhR2XfGzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:56:39 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44prhL6Wblz9v04m;
 Wed, 24 Apr 2019 08:56:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Wkprvgxf; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id WJ5KvgdGKvY0; Wed, 24 Apr 2019 08:56:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44prhL5HMxz9v04R;
 Wed, 24 Apr 2019 08:56:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556088994; bh=xEjrsiR5JDmaRbOgpD5CAwlEaNceAVtpgWngVaUDVJc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=WkprvgxftPTm4U6QJGi+kfIdfxa2z6MjdKZ0PIMpCJlNK1dUO9UUWF3L7x3JiNsgo
 EgKEa/WMRNk+24yT+9axwbOpxEkuTMVUtsjTZScI3Ir5MlUZZe2f3Z3huIiiTLjtiF
 70RqlaYdYcv2bnbw0jDDZsY8fsaYTWLTPVZudsaE=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A22268B7FB;
 Wed, 24 Apr 2019 08:56:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id olAwAcgvLajv; Wed, 24 Apr 2019 08:56:35 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 792D88B7C5;
 Wed, 24 Apr 2019 08:56:35 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc/mm/ptdump: Wrap seq_printf() to handle NULL
 pointers
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
References: <20190424063958.24559-1-ruscur@russell.cc>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ab20f079-cf9f-f1c6-f3fa-54a842311fd3@c-s.fr>
Date: Wed, 24 Apr 2019 08:56:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424063958.24559-1-ruscur@russell.cc>
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
Cc: Julia.Lawall@lip6.fr, rashmica.g@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 24/04/2019 à 08:39, Russell Currey a écrit :
> Lovingly borrowed from the arch/arm64 ptdump code.
> 
> This doesn't seem to be an issue in practice, but is necessary for my
> upcoming commit.
> 
> Converts a putc() into a puts().
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>   arch/powerpc/mm/ptdump/ptdump.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index 37138428ab55..c50cb7faa334 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -104,6 +104,18 @@ static struct addr_marker address_markers[] = {
>   	{ -1,	NULL },
>   };
>   
> +#define pt_dump_seq_printf(m, fmt, args...)	\
> +({						\
> +	if (m)					\
> +		seq_printf(m, fmt, ##args);	\
> +})
> +
> +#define pt_dump_seq_puts(m, fmt)	\
> +({					\
> +	if (m)				\
> +		seq_printf(m, fmt);	\

Why not use seq_puts() here ?

Christophe

> +})
> +
>   static void dump_flag_info(struct pg_state *st, const struct flag_info
>   		*flag, u64 pte, int num)
>   {
> @@ -121,19 +133,19 @@ static void dump_flag_info(struct pg_state *st, const struct flag_info
>   			val = pte & flag->val;
>   			if (flag->shift)
>   				val = val >> flag->shift;
> -			seq_printf(st->seq, "  %s:%llx", flag->set, val);
> +			pt_dump_seq_printf(st->seq, "  %s:%llx", flag->set, val);
>   		} else {
>   			if ((pte & flag->mask) == flag->val)
>   				s = flag->set;
>   			else
>   				s = flag->clear;
>   			if (s)
> -				seq_printf(st->seq, "  %s", s);
> +				pt_dump_seq_printf(st->seq, "  %s", s);
>   		}
>   		st->current_flags &= ~flag->mask;
>   	}
>   	if (st->current_flags != 0)
> -		seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
> +		pt_dump_seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
>   }
>   
>   static void dump_addr(struct pg_state *st, unsigned long addr)
> @@ -148,12 +160,12 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
>   #define REG		"0x%08lx"
>   #endif
>   
> -	seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
> +	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
>   	if (st->start_pa == st->last_pa && st->start_address + PAGE_SIZE != addr) {
> -		seq_printf(st->seq, "[" REG "]", st->start_pa);
> +		pt_dump_seq_printf(st->seq, "[" REG "]", st->start_pa);
>   		delta = PAGE_SIZE >> 10;
>   	} else {
> -		seq_printf(st->seq, " " REG " ", st->start_pa);
> +		pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
>   		delta = (addr - st->start_address) >> 10;
>   	}
>   	/* Work out what appropriate unit to use */
> @@ -161,7 +173,7 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
>   		delta >>= 10;
>   		unit++;
>   	}
> -	seq_printf(st->seq, "%9lu%c", delta, *unit);
> +	pt_dump_seq_printf(st->seq, "%9lu%c", delta, *unit);
>   
>   }
>   
> @@ -178,7 +190,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
>   		st->start_address = addr;
>   		st->start_pa = pa;
>   		st->last_pa = pa;
> -		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
>   	/*
>   	 * Dump the section of virtual memory when:
>   	 *   - the PTE flags from one entry to the next differs.
> @@ -202,7 +214,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
>   					  st->current_flags,
>   					  pg_level[st->level].num);
>   
> -			seq_putc(st->seq, '\n');
> +			pt_dump_seq_puts(st->seq, "\n");
>   		}
>   
>   		/*
> @@ -211,7 +223,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
>   		 */
>   		while (addr >= st->marker[1].start_address) {
>   			st->marker++;
> -			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
> +			pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
>   		}
>   		st->start_address = addr;
>   		st->start_pa = pa;
> 
