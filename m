Return-Path: <SRS0=kptR=AD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 01:32:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD63F25343
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 01:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=popple.id.au header.i=@popple.id.au header.b="DBOtQAC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD63F25343
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49qsNW4fLwzDqdG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2020 11:32:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49qsLg15PlzDqZm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 11:31:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=popple.id.au header.i=@popple.id.au header.a=rsa-sha256
 header.s=202006 header.b=DBOtQAC3; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49qsLf0RFCz9sRf;
 Mon, 22 Jun 2020 11:31:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=popple.id.au;
 s=202006; t=1592789466;
 bh=peoBn7LHBz+qauy8wQ0z8+moJATYqgP0FkdG7MYzidY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DBOtQAC3NFE3BGz6Iq+g1XM6mhSSdhRXAzGQ8Yg0ThfMeIROX+TOqVTnvJbTn5g6R
 QKoKgZJwe5F4SEMrpowXDxSTQzYoxT67pNX7DQNjeWD91H6GIquW2XFXg8bgd5Sd0v
 lYugGO0sByCDB7EBs4HiJGvOlpnwruF/mxnepCjHVA17nf7pt0dEwKGi1hxMo+5L+R
 6Zz4xHAkYGteGjNQEGG/zbVVjwJ7MPGWQPYxvNaYhcRY+rx685s29fY9FIWhVE2ag7
 pw7ODUE5554N/kps0FHCI+7FKextffwy6z5SNBKdd9MjPZBXxWzYrcvblOg1nzGkTY
 612yP3xbfosNQ==
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] selftests/powerpc: Add prefixed loads/stores to
 alignment_handler test
Date: Mon, 22 Jun 2020 11:31:03 +1000
Message-ID: <2070842.8SDOZEvoPg@townsend>
In-Reply-To: <20200520021103.19798-2-jniethe5@gmail.com>
References: <20200520021103.19798-1-jniethe5@gmail.com>
 <20200520021103.19798-2-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wednesday, 20 May 2020 12:11:03 PM AEST Jordan Niethe wrote:
> +/* POWER10 feature */
> +#ifndef PPC_FEATURE2_ARCH_3_10
> +#define PPC_FEATURE2_ARCH_3_10 0x00040000
> +#endif

One minor nit pick, this needs to be updated to PPC_FEATURE2_ARCH_3_1 to 
reflect the changes made in response to feedback on the patch series that 
introduced this feature.

- Alistair

>  #if defined(__powerpc64__)
>  #define UCONTEXT_NIA(UC)	(UC)->uc_mcontext.gp_regs[PT_NIP]
>  #define UCONTEXT_MSR(UC)	(UC)->uc_mcontext.gp_regs[PT_MSR]
> 




