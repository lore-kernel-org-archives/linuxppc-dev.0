Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B6EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:35:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD4F20652
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD4F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445SQx28MbzDqDb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:35:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RNN4fygzDq7k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:48:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RNM72H2z9sDX; Fri, 22 Feb 2019 20:48:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cabe8138b23c92e851b92c6a20ffb13598ff34d4
X-Patchwork-Hint: ignore
In-Reply-To: <9afb42b9d78abe00fe049e1736a180b1facdfd86.1550490186.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: dump as a single line areas mapping a single physical
 page.
Message-Id: <445RNM72H2z9sDX@ozlabs.org>
Date: Fri, 22 Feb 2019 20:48:03 +1100 (AEDT)
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

On Mon, 2019-02-18 at 12:25:20 UTC, Christophe Leroy wrote:
> When using KASAN, there are parts of the shadow area where all
> pages are mapped to the kasan_early_shadow_page. It is pointless
> to dump one line for each of those pages (in the example below there
> are 7168 entries pointing to the same physical page).
> 
> ~# cat /sys/kernel/debug/kernel_page_tables
>  ...
> ---[ kasan shadow mem start ]---
> 0xf7c00000-0xf8bfffff 0x06fac000       16M        rw       present           dirty  accessed
> 0xf8c00000-0xf8c03fff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c04000-0xf8c07fff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c08000-0xf8c0bfff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c0c000-0xf8c0ffff 0x00cd0000       16K        r        present           dirty  accessed
> 0xf8c10000-0xf8c13fff 0x00cd0000       16K        r        present           dirty  accessed
>  ... 7168 identical lines
> 0xffbfc000-0xffbfffff 0x00cd0000       16K        r        present           dirty  accessed
> ---[ kasan shadow mem end ]---
>  ...
> 
> This patch modifies linux table dump to dump as a single line areas
> where all addresses points to the same physical page. That physical
> address is put inside [] to show that all virt pages points to the
> same phys page.
> 
> ~# cat /sys/kernel/debug/kernel_page_tables
>  ...
> ---[ kasan shadow mem start ]---
> 0xf7c00000-0xf8bfffff  0x06fac000        16M        rw       present           dirty  accessed
> 0xf8c00000-0xffbfffff [0x00cd0000]       16K        r        present           dirty  accessed
> ---[ kasan shadow mem end ]---
>  ...
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cabe8138b23c92e851b92c6a20ffb135

cheers
