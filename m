Return-Path: <SRS0=mIln=BR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B5C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 02:50:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A6C221E2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 02:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dhSh9I1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A6C221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BN8x90HQQzDqvr
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2020 12:50:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BN8tD3wQYzDqbX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2020 12:48:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=dhSh9I1r; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BN8tB6BBWz9sSG;
 Fri,  7 Aug 2020 12:48:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596768484;
 bh=QRFFwrvNL4FQDFGUBy0JNMwo3nFLA/HqutlnKQMVW/o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=dhSh9I1ri2FonyuPHS/F8UsbU8YslpXWUgV+59aSU8izqPVZFcVvvnqQn2xdP2TOY
 /RNDUiRCh7JFN5Ycv2Vx9h9uIEFeiNelm5CPpExh8U3MorVo6DwOAHE5df+cpiAa0M
 D6QK6DJxooFTd+QQiyNGHp35grROU/viuDczCAGWbt4VaLN50ua6psx3Fb835VATuX
 jRnDln6aEFGMumoNnnPqIOjZI8HnuVBT0Hnp+ia1iWj8j5jXQvTnecpxJmQAmbMmJ8
 UAoVjxITQZEF6QXJvoXvado7Os8gzW5Lfk0cnHoOubk/C835T30YoX5ikWeBGiMYNF
 LjFr4F0o7llPQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal: Move and simplify get_clean_sp()
In-Reply-To: <20200806092547.GA2544@infradead.org>
References: <04169f40c09682ce5747518268ca84285bc17fbc.1596703345.git.christophe.leroy@csgroup.eu>
 <20200806092547.GA2544@infradead.org>
Date: Fri, 07 Aug 2020 12:48:01 +1000
Message-ID: <87k0ybxjby.fsf@mpe.ellerman.id.au>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@infradead.org> writes:
> On Thu, Aug 06, 2020 at 08:50:20AM +0000, Christophe Leroy wrote:
>> get_clean_sp() is only used in kernel/signal.c . Move it there.
>> 
>> And GCC is smart enough to reduce the function when on PPC32, no
>> need of a special PPC32 simple version.
>
> What about just open coding it in the only caller, which would seem even
> cleaner?

+1

cheers
