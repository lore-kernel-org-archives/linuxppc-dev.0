Return-Path: <SRS0=mj2b=UE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315CFC46460
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Jun 2019 11:20:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BF62075C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Jun 2019 11:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BF62075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45JmYz3Q1PzDqZb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Jun 2019 21:20:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45JmXJ0W1MzDqW0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2019 21:19:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45JmXD0rHVz9sN6;
 Wed,  5 Jun 2019 21:19:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC V2] mm: Generalize notify_page_fault()
In-Reply-To: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
References: <1559630046-12940-1-git-send-email-anshuman.khandual@arm.com>
Date: Wed, 05 Jun 2019 21:19:22 +1000
Message-ID: <87sgsomg91.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-s390@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Anshuman Khandual <anshuman.khandual@arm.com> writes:
> Similar notify_page_fault() definitions are being used by architectures
> duplicating much of the same code. This attempts to unify them into a
> single implementation, generalize it and then move it to a common place.
> kprobes_built_in() can detect CONFIG_KPROBES, hence notify_page_fault()
> need not be wrapped again within CONFIG_KPROBES. Trap number argument can
> now contain upto an 'unsigned int' accommodating all possible platforms.
...
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 58f69fa..1bc3b18 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -30,28 +30,6 @@
>  
>  #ifdef CONFIG_MMU
>  
> -#ifdef CONFIG_KPROBES
> -static inline int notify_page_fault(struct pt_regs *regs, unsigned int fsr)
> -{
> -	int ret = 0;
> -
> -	if (!user_mode(regs)) {
> -		/* kprobe_running() needs smp_processor_id() */
> -		preempt_disable();
> -		if (kprobe_running() && kprobe_fault_handler(regs, fsr))
> -			ret = 1;
> -		preempt_enable();
> -	}
> -
> -	return ret;
> -}
> -#else

You've changed several of the architectures from something like above,
where it disables preemption around the call into the below:

> +int __kprobes notify_page_fault(struct pt_regs *regs, unsigned int trap)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to be allowed
> +	 * to call kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (kprobes_built_in() && !preemptible() && !user_mode(regs)) {
> +		if (kprobe_running() && kprobe_fault_handler(regs, trap))
> +			ret = 1;
> +	}
> +	return ret;
> +}

Which skips everything if we're preemptible. Is that an equivalent
change? If so can you please explain why in more detail.

Also why not have it return bool?

cheers
