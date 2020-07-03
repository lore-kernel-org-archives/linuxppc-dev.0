Return-Path: <SRS0=ZYlp=AO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22754C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 10:53:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C647920737
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 10:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jE5FAgWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C647920737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ysJ03ThczDqVW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 20:53:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ysDF54wRzDqgF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2020 20:49:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=jE5FAgWT; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49ysDD0gdYz9sSy;
 Fri,  3 Jul 2020 20:49:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1593773388;
 bh=RfcGFiZqerkVV2+Xy8mk+CmXEwgXM5XeAEZk9tVyLEo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jE5FAgWTrhkfhhz6BYzecTvfdbDagKlkEWrYP3L0gbYhUVcSmlNc1lC6f2ixexXfj
 QMnhT3le4DAgIHjrdKH22ewB074mqgaY+h4/qPtQCqXxPj1aL8oLqf9cRSSFg+ZpER
 kOBkntxdcz0tYKdN5N9tEC3tWly5GI/no1ixwSUH2ll5U30V57HbQBu863Xoilh+tH
 faLA8P2ykdWIk2tfZCnjGNmZvES09DuT2hr7WHCNOOgcbnej88JykIeo5CrGmWKVP4
 mhpmHq+ygewJ07zs3nF7tn1T8SdxHp2Y2ozRdDw+CH0ePoLytwGYkTSssCCGuyHwKH
 P9M8prScLig4Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
In-Reply-To: <1593686722.w9psaqk7yp.astroid@bobo.none>
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-6-npiggin@gmail.com>
 <20200702080219.GB16113@willie-the-truck>
 <1593685459.r2tfxtfdp6.astroid@bobo.none>
 <20200702103506.GA16418@willie-the-truck>
 <1593686722.w9psaqk7yp.astroid@bobo.none>
Date: Fri, 03 Jul 2020 20:52:02 +1000
Message-ID: <878sg07twt.fsf@mpe.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Will Deacon's message of July 2, 2020 8:35 pm:
>> On Thu, Jul 02, 2020 at 08:25:43PM +1000, Nicholas Piggin wrote:
>>> Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
>>> > On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
>>> >> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
>>> >> new file mode 100644
>>> >> index 000000000000..f84da77b6bb7
>>> >> --- /dev/null
>>> >> +++ b/arch/powerpc/include/asm/qspinlock.h
>>> >> @@ -0,0 +1,20 @@
>>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>>> >> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>>> >> +#define _ASM_POWERPC_QSPINLOCK_H
>>> >> +
>>> >> +#include <asm-generic/qspinlock_types.h>
>>> >> +
>>> >> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>>> >> +
>>> >> +#define smp_mb__after_spinlock()   smp_mb()
>>> >> +
>>> >> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
>>> >> +{
>>> >> +	smp_mb();
>>> >> +	return atomic_read(&lock->val);
>>> >> +}
>>> > 
>>> > Why do you need the smp_mb() here?
>>> 
>>> A long and sad tale that ends here 51d7d5205d338
>>> 
>>> Should probably at least refer to that commit from here, since this one 
>>> is not going to git blame back there. I'll add something.
>> 
>> Is this still an issue, though?
>> 
>> See 38b850a73034 (where we added a similar barrier on arm64) and then
>> c6f5d02b6a0f (where we removed it).
>> 
>
> Oh nice, I didn't know that went away. Thanks for the heads up.

Argh! I spent so much time chasing that damn bug in the ipc code.

> I'm going to say I'm too scared to remove it while changing the
> spinlock algorithm, but I'll open an issue and we should look at 
> removing it.

Sounds good.

cheers
