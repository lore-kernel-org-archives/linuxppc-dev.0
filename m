Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287FFC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:33:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA42219FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 10:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA42219FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MMJx5hlxzDqbt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 21:33:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSm5Zv0zDqWq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSm3jd2z9sPK; Sat, 22 Dec 2018 20:54:48 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 25078dc1f74be16b858e914f52cc8f4d03c2271a
X-Patchwork-Hint: ignore
In-Reply-To: <20181216165349.24281-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: use mm zones more sensibly
Message-Id: <43MLSm3jd2z9sPK@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:48 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2018-12-16 at 16:53:49 UTC, Christoph Hellwig wrote:
> Powerpc has somewhat odd usage where ZONE_DMA is used for all memory on
> common 64-bit configfs, and ZONE_DMA32 is used for 31-bit schemes.
> 
> Move to a scheme closer to what other architectures use (and I dare to
> say the intent of the system):
> 
>  - ZONE_DMA: optionally for memory < 31-bit (64-bit embedded only)
>  - ZONE_NORMAL: everything addressable by the kernel
>  - ZONE_HIGHMEM: memory > 32-bit for 32-bit kernels
> 
> Also provide information on how ZONE_DMA is used by defining
> ARCH_ZONE_DMA_BITS.
> 
> Contains various fixes from Benjamin Herrenschmidt.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/25078dc1f74be16b858e914f52cc8f

cheers
