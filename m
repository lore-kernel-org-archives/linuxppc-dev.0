Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85AAC6783B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 00:26:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03422084E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 00:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03422084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DyK70mmDzDqyb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 11:26:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DyGk6Rn0zDqfP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 11:23:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43DyGk3tn1z9s3l;
 Wed, 12 Dec 2018 11:23:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] powerpc: implement CONFIG_DEBUG_VIRTUAL
In-Reply-To: <a42260e77d609a10667872c2e7bf14ceabcce050.1544562518.git.christophe.leroy@c-s.fr>
References: <a42260e77d609a10667872c2e7bf14ceabcce050.1544562518.git.christophe.leroy@c-s.fr>
Date: Wed, 12 Dec 2018 11:23:58 +1100
Message-ID: <87va3zwq1t.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch implements CONFIG_DEBUG_VIRTUAL to warn about
> incorrect use of virt_to_phys() and page_to_phys()
>
> Below is the result of test_debug_virtual:
>
> [    1.438746] WARNING: CPU: 0 PID: 1 at ./arch/powerpc/include/asm/io.h:808 test_debug_virtual_init+0x3c/0xd4
> [    1.448156] CPU: 0 PID: 1 Comm: swapper Not tainted 4.20.0-rc5-00560-g6bfb52e23a00-dirty #532
> [    1.457259] NIP:  c066c550 LR: c0650ccc CTR: c066c514
> [    1.462257] REGS: c900bdb0 TRAP: 0700   Not tainted  (4.20.0-rc5-00560-g6bfb52e23a00-dirty)
> [    1.471184] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 48000422  XER: 20000000
> [    1.477811]
> [    1.477811] GPR00: c0650ccc c900be60 c60d0000 00000000 006000c0 c9000000 00009032 c7fa0020
> [    1.477811] GPR08: 00002400 00000001 09000000 00000000 c07b5d04 00000000 c00037d8 00000000
> [    1.477811] GPR16: 00000000 00000000 00000000 00000000 c0760000 c0740000 00000092 c0685bb0
> [    1.477811] GPR24: c065042c c068a734 c0685b8c 00000006 00000000 c0760000 c075c3c0 ffffffff
> [    1.512711] NIP [c066c550] test_debug_virtual_init+0x3c/0xd4
> [    1.518315] LR [c0650ccc] do_one_initcall+0x8c/0x1cc
> [    1.523163] Call Trace:
> [    1.525595] [c900be60] [c0567340] 0xc0567340 (unreliable)
> [    1.530954] [c900be90] [c0650ccc] do_one_initcall+0x8c/0x1cc
> [    1.536551] [c900bef0] [c0651000] kernel_init_freeable+0x1f4/0x2cc
> [    1.542658] [c900bf30] [c00037ec] kernel_init+0x14/0x110
> [    1.547913] [c900bf40] [c000e1d0] ret_from_kernel_thread+0x14/0x1c
> [    1.553971] Instruction dump:
> [    1.556909] 3ca50100 bfa10024 54a5000e 3fa0c076 7c0802a6 3d454000 813dc204 554893be
> [    1.564566] 7d294010 7d294910 90010034 39290001 <0f090000> 7c3e0b78 955e0008 3fe0c062
> [    1.572425] ---[ end trace 6f6984225b280ad6 ]---
> [    1.577467] PA: 0x09000000 for VA: 0xc9000000
> [    1.581799] PA: 0x061e8f50 for VA: 0xc61e8f50
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v3: Added missing linux/mm.h
>      I realised that a driver may use DMA on stack after checking with virt_addr_valid(), so the new
>      verification might induce false positives. I remove it for now, will add it again later in a more
>      controled way.

What is this comment referring to?

I can't see any difference to v2 except the linux/mm.h include.

cheers
