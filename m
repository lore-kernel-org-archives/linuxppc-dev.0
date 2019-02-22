Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9FBC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:58:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C6220700
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 09:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C6220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445RcM3XdMzDqPw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 20:58:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RMq6JlnzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RMq2kjVz9sBF; Fri, 22 Feb 2019 20:47:34 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 32ceaa6e128556ec67151a16d7c2c04580170db8
X-Patchwork-Hint: ignore
In-Reply-To: <998f5532a4ec358acdbeb4238182f416304b3293.1544687473.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/8xx: hide itlbie and dtlbie symbols
Message-Id: <445RMq2kjVz9sBF@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:34 +1100 (AEDT)
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

On Thu, 2018-12-13 at 08:08:11 UTC, Christophe Leroy wrote:
> When disassembling InstructionTLBError we get the following messy code:
> 
> c000138c:       7d 84 63 78     mr      r4,r12
> c0001390:       75 25 58 00     andis.  r5,r9,22528
> c0001394:       75 2a 40 00     andis.  r10,r9,16384
> c0001398:       41 a2 00 08     beq     c00013a0 <itlbie>
> c000139c:       7c 00 22 64     tlbie   r4,r0
> 
> c00013a0 <itlbie>:
> c00013a0:       39 40 04 01     li      r10,1025
> c00013a4:       91 4b 00 b0     stw     r10,176(r11)
> c00013a8:       39 40 10 32     li      r10,4146
> c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>
> 
> For a cleaner code dump, this patch replaces itlbie and dtlbie
> symbols by local symbols.
> 
> c000138c:       7d 84 63 78     mr      r4,r12
> c0001390:       75 25 58 00     andis.  r5,r9,22528
> c0001394:       75 2a 40 00     andis.  r10,r9,16384
> c0001398:       41 a2 00 08     beq     c00013a0 <InstructionTLBError+0xa0>
> c000139c:       7c 00 22 64     tlbie   r4,r0
> c00013a0:       39 40 04 01     li      r10,1025
> c00013a4:       91 4b 00 b0     stw     r10,176(r11)
> c00013a8:       39 40 10 32     li      r10,4146
> c00013ac:       48 00 cc 59     bl      c000e004 <transfer_to_handler>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/32ceaa6e128556ec67151a16d7c2c045

cheers
