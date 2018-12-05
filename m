Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A60BC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:28:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13E42084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13E42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438kj85WwvzDqcd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 14:28:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438kfy5hNpzDqX0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 14:26:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438kfy1WXlz9s7W;
 Wed,  5 Dec 2018 14:26:49 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] powerpc/ipic: Fix a bounds check in ipic_set_priority()
In-Reply-To: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
References: <20181203144834.ocxntjflfz2idxrb@kili.mountain>
Date: Wed, 05 Dec 2018 14:26:47 +1100
Message-ID: <87sgzchcw8.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dan,

Thanks for the patch.

Dan Carpenter <dan.carpenter@oracle.com> writes:
> The ipic_info[] array only has 95 elements so I have made the bounds
> check smaller to prevent a read overflow.  It was Smatch that found
> this issue:
>
>     arch/powerpc/sysdev/ipic.c:784 ipic_set_priority()
>     error: buffer overflow 'ipic_info' 95 <= 127
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I wasn't able to find any callers of this code.  Maybe we removed the
> last one in commit b9f0f1bb2bca ("[POWERPC] Adapt ipic driver to new
> host_ops interface, add set_irq_type to set IRQ sense").  So perhaps we
> should just remove it.  I'm not really comfortable doing that myself,
> because I don't know the code well enough and can't build test
> it properly.

Hah wow, last usage removed in 2006!

I don't see any mention of it since then, so I'll remove it. If it
breaks something we can put it back.

Can smatch help us find things like this that are defined non-static but
never used?

cheers
