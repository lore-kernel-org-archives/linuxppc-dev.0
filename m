Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC88C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:28:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A830520892
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A830520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BCwC5TzqzDqtk
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 00:28:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BCRW42MCzDrh6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 00:07:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43BCRV2w5Zz9s7T; Sat,  8 Dec 2018 00:07:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0261a508c9fcb33e60f09cac42032f85c31e2039
X-Patchwork-Hint: ignore
In-Reply-To: <535d3d1838d3599d4f7535a92e3b7872102f9ff4.1542387964.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: dump segment registers on book3s/32
Message-Id: <43BCRV2w5Zz9s7T@ozlabs.org>
Date: Sat,  8 Dec 2018 00:07:02 +1100 (AEDT)
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

On Fri, 2018-11-16 at 17:06:43 UTC, Christophe Leroy wrote:
> This patch creates a debugfs file to see content of
> segment registers
> 
> ~# cat /sys/kernel/debug/segment_registers
> ---[ User Segments ]---
> 0x00000000-0x0fffffff Kern key 1 User key 1 VSID 0xade2b0
> 0x10000000-0x1fffffff Kern key 1 User key 1 VSID 0xade3c1
> 0x20000000-0x2fffffff Kern key 1 User key 1 VSID 0xade4d2
> 0x30000000-0x3fffffff Kern key 1 User key 1 VSID 0xade5e3
> 0x40000000-0x4fffffff Kern key 1 User key 1 VSID 0xade6f4
> 0x50000000-0x5fffffff Kern key 1 User key 1 VSID 0xade805
> 0x60000000-0x6fffffff Kern key 1 User key 1 VSID 0xade916
> 0x70000000-0x7fffffff Kern key 1 User key 1 VSID 0xadea27
> 0x80000000-0x8fffffff Kern key 1 User key 1 VSID 0xadeb38
> 0x90000000-0x9fffffff Kern key 1 User key 1 VSID 0xadec49
> 0xa0000000-0xafffffff Kern key 1 User key 1 VSID 0xaded5a
> 0xb0000000-0xbfffffff Kern key 1 User key 1 VSID 0xadee6b
> 
> ---[ Kernel Segments ]---
> 0xc0000000-0xcfffffff Kern key 0 User key 1 VSID 0x000ccc
> 0xd0000000-0xdfffffff Kern key 0 User key 1 VSID 0x000ddd
> 0xe0000000-0xefffffff Kern key 0 User key 1 VSID 0x000eee
> 0xf0000000-0xffffffff Kern key 0 User key 1 VSID 0x000fff
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0261a508c9fcb33e60f09cac42032f

cheers
