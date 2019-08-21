Return-Path: <SRS0=9oUV=WR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38962C3A59E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 12:21:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA66206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 12:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA66206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46D6Gh6C3FzDr4g
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Aug 2019 22:21:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46D6CG26qJzDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2019 22:18:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46D6CD705Gz9sBp;
 Wed, 21 Aug 2019 22:18:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 21/44] powerpc/64s/exception: remove 0xb00 handler
In-Reply-To: <20190802105709.27696-22-npiggin@gmail.com>
References: <20190802105709.27696-1-npiggin@gmail.com>
 <20190802105709.27696-22-npiggin@gmail.com>
Date: Wed, 21 Aug 2019 22:18:44 +1000
Message-ID: <87a7c267a3.fsf@concordia.ellerman.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> This vector is not used by any supported processor, and has been
> implemented as an unknown exception going back to 2.6. There is
> nothing special about 0xb00, so remove it like other unused
> vectors.

Actually it goes back to the original ppc64 submission.

See (takes a while to load):
  https://github.com/mpe/linux-fullhistory/commit/c3aa9878533e724f639852c3d951e6a169e04081#diff-c7b0adae374819e9003279ff5f69226fR340


That commit had handlers for all the vectors from 0x100 through 0xf00,
with stubs for 0xa00, 0xb00 and 0xe00. But it's not at all clear why it
needed the stubs, possibly it was just being verbose.

0xa00 eventually became doorbell_super and 0xe00 became h_data_storage.
Leaving just 0xb00 as the lone relic.

</irrelevant-history>

Patch looks good.

cheers


> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 723c37f3da17..9c407392774c 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1563,10 +1563,8 @@ EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
>  #endif
>  
>  
> -EXC_REAL(trap_0b, 0xb00, 0x100)
> -EXC_VIRT(trap_0b, 0x4b00, 0x100, 0xb00)
> -TRAMP_KVM(PACA_EXGEN, 0xb00)
> -EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
> +EXC_REAL_NONE(0xb00, 0x100)
> +EXC_VIRT_NONE(0x4b00, 0x100)
>  
>  /*
>   * system call / hypercall (0xc00, 0x4c00)
> -- 
> 2.22.0
