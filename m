Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41694C32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1122087A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1122087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42W4D20WFJzF3Hl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 19:40:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42W46k1QLwzF37s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 19:35:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42W46j650vz9sjF; Thu, 11 Oct 2018 19:35:41 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f5e284803a7206d43e26f9ffcae5de9626d95e37
In-Reply-To: <20181001062151.23831-1-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/nohash: fix undefined behaviour when testing page size
 support
Message-Id: <42W46j650vz9sjF@ozlabs.org>
Date: Thu, 11 Oct 2018 19:35:41 +1100 (AEDT)
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-01 at 06:21:51 UTC, Daniel Axtens wrote:
> When enumerating page size definitions to check hardware support,
> we construct a constant which is (1U << (def->shift - 10)).
> 
> However, the array of page size definitions is only initalised for
> various MMU_PAGE_* constants, so it contains a number of 0-initialised
> elements with def->shift == 0. This means we end up shifting by a
> very large number, which gives the following UBSan splat:
> 
> ================================================================================
> UBSAN: Undefined behaviour in /home/dja/dev/linux/linux/arch/powerpc/mm/tlb_nohash.c:506:21
> shift exponent 4294967286 is too large for 32-bit type 'unsigned int'
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-00045-ga604f927b012-dirty #6
> Call Trace:
> [c00000000101bc20] [c000000000a13d54] .dump_stack+0xa8/0xec (unreliable)
> [c00000000101bcb0] [c0000000004f20a8] .ubsan_epilogue+0x18/0x64
> [c00000000101bd30] [c0000000004f2b10] .__ubsan_handle_shift_out_of_bounds+0x110/0x1a4
> [c00000000101be20] [c000000000d21760] .early_init_mmu+0x1b4/0x5a0
> [c00000000101bf10] [c000000000d1ba28] .early_setup+0x100/0x130
> [c00000000101bf90] [c000000000000528] start_here_multiplatform+0x68/0x80
> ================================================================================
> 
> Fix this by first checking if the element exists (shift != 0) before
> constructing the constant.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f5e284803a7206d43e26f9ffcae5de

cheers
