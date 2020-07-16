Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4709CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 22:40:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED7C208CA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 22:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED7C208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B78NQ0wLHzDrBy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2020 08:40:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=76.164.61.194; helo=kernel.crashing.org;
 envelope-from=benh@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B78Lb1NxgzDr9N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2020 08:39:02 +1000 (AEST)
Received: from localhost (gate.crashing.org [63.228.1.57])
 (authenticated bits=0)
 by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06GMcUf3029747
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2020 17:38:33 -0500
Message-ID: <b1aa976cf9788ed7d2bf949b2b5e5e5b2e3f9776.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/64: Fix an out of date comment about MMIO ordering
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, Will Deacon <willdeacon@google.com>
Date: Fri, 17 Jul 2020 08:38:29 +1000
In-Reply-To: <20200716193820.1141936-1-palmer@dabbelt.com>
References: <20200716193820.1141936-1-palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
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
Cc: kernel-team@android.com, bigeasy@linutronix.de,
 Palmer Dabbelt <palmerdabbelt@google.com>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, paulus@samba.org, jniethe5@gmail.com, tglx@linutronix.de,
 msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2020-07-16 at 12:38 -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> This primitive has been renamed, but because it was spelled incorrectly in the
> first place it must have escaped the fixup patch.  As far as I can tell this
> logic is still correct: smp_mb__after_spinlock() uses the default smp_mb()
> implementation, which is "sync" rather than "hwsync" but those are the same
> (though I'm not that familiar with PowerPC).

Typo ? That must be me ... :)

Looks fine. Yes, sync and hwsync are the same (by opposition to lwsync
which is lighter weight and doesn't order cache inhibited).

Cheers,
Ben.

> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/powerpc/kernel/entry_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index b3c9f15089b6..7b38b4daca93 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -357,7 +357,7 @@ _GLOBAL(_switch)
>  	 * kernel/sched/core.c).
>  	 *
>  	 * Uncacheable stores in the case of involuntary preemption must
> -	 * be taken care of. The smp_mb__before_spin_lock() in __schedule()
> +	 * be taken care of. The smp_mb__after_spinlock() in __schedule()
>  	 * is implemented as hwsync on powerpc, which orders MMIO too. So
>  	 * long as there is an hwsync in the context switch path, it will
>  	 * be executed on the source CPU after the task has performed

