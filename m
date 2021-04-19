Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3966FC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:11:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9159610A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9159610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtfp3z1Xz3g5P
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:11:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtVr0DYNz3cX1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:34 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVk0mSLz9vHW; Mon, 19 Apr 2021 14:04:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210316104206.407354-1-npiggin@gmail.com>
References: <20210316104206.407354-1-npiggin@gmail.com>
Subject: Re: [PATCH v2 00/11] Move 64e to new interrupt return code
Message-Id: <161880480463.1398509.18376716454168446661.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 14:00:04 +1000
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
Cc: Scott Wood <oss@buserror.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 16 Mar 2021 20:41:54 +1000, Nicholas Piggin wrote:
> Since RFC:
> - Rebased on Christophe's v3 ppc32 conversion
> - Fixed up small details, adds some powerpc-wide cleanups at the end.
> 
> Since v1:
> - Christophe's review comments accounted for:
> - Split common code interrupt changes for 64e from 64e conversion.
> - Removed unnecessary ifdef additions from common interrupt code.
> - Keep interrupt return context tracking debug check for 64e when
>   it switches to new context tracing.
> - __bad_page_fault is made static in page fault cleanup.
> - CPU time accounting asm and asm offsets can be removed with 64e
>   conversion.
> 
> [...]

Applied to powerpc/next.

[01/11] powerpc/syscall: switch user_exit_irqoff and trace_hardirqs_off order
        https://git.kernel.org/powerpc/c/5a5a893c4ad897b8a36f846602895515b7407a71
[02/11] powerpc/64e/interrupt: always save nvgprs on interrupt
        https://git.kernel.org/powerpc/c/4228b2c3d20e9f80b847f809c38e6cf82864fa50
[03/11] powerpc/interrupt: update common interrupt code for
        https://git.kernel.org/powerpc/c/dc6231821a148d0392292924fdae5b34679af6b2
[04/11] powerpc/64e/interrupt: use new interrupt return
        https://git.kernel.org/powerpc/c/0c2472de23aea5ce9139a3e887191925759d1259
[05/11] powerpc/64e/interrupt: NMI save irq soft-mask state in C
        https://git.kernel.org/powerpc/c/3db8aa10de9a478b3086db7894e0266def3d77af
[06/11] powerpc/64e/interrupt: reconcile irq soft-mask state in C
        https://git.kernel.org/powerpc/c/097157e16cf8bf91b9cf6fbda05d234d3599c01f
[07/11] powerpc/64e/interrupt: Use new interrupt context tracking scheme
        https://git.kernel.org/powerpc/c/ceff77efa4f8d9f02d8442171b325d3b7068fe5e
[08/11] powerpc/64e/interrupt: handle bad_page_fault in C
        https://git.kernel.org/powerpc/c/d738ee8d56de38c91610741f672ec5c1ffae76fc
[09/11] powerpc: clean up do_page_fault
        https://git.kernel.org/powerpc/c/c45ba4f44f6b9c98a5fc1511d8853ad6843c877b
[10/11] powerpc: remove partial register save logic
        https://git.kernel.org/powerpc/c/8dc7f0229b7892ccb23e19c9f30511c68cc0fdcc
[11/11] powerpc: move norestart trap flag to bit 0
        https://git.kernel.org/powerpc/c/8f6cc75a97d162011fad3c470e5a14e298383a07

cheers
