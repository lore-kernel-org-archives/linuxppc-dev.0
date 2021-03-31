Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF8C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:21:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D99619C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D99619C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97n96FrLz3hCM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:21:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97Xr5TqCz3cFn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97Xr3S33z9t0G; Wed, 31 Mar 2021 12:10:31 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>
In-Reply-To: <20210302200829.2680663-1-nathan@kernel.org>
References: <20210302200829.2680663-1-nathan@kernel.org>
Subject: Re: [PATCH] powerpc/prom: Mark identical_pvr_fixup as __init
Message-Id: <161715296566.226945.1083928509084280457.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2 Mar 2021 13:08:29 -0700, Nathan Chancellor wrote:
> If identical_pvr_fixup() is not inlined, there are two modpost warnings:
> 
> WARNING: modpost: vmlinux.o(.text+0x54e8): Section mismatch in reference
> from the function identical_pvr_fixup() to the function
> .init.text:of_get_flat_dt_prop()
> The function identical_pvr_fixup() references
> the function __init of_get_flat_dt_prop().
> This is often because identical_pvr_fixup lacks a __init
> annotation or the annotation of of_get_flat_dt_prop is wrong.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/prom: Mark identical_pvr_fixup as __init
      https://git.kernel.org/powerpc/c/1ef1dd9c7ed27b080445e1576e8a05957e0e4dfc

cheers
