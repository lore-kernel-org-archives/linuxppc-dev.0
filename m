Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0D5C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:47:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D5B60F56
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14D5B60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7ST5KHzz3dph
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:47:53 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7Fx5gzrz304j
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fx4b6Gz4xdV;
 Tue,  2 Nov 2021 22:38:45 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211013213438.675095-1-joel@jms.id.au>
References: <20211013213438.675095-1-joel@jms.id.au>
Subject: Re: [PATCH v2] powerpc/s64: Clarify that radix lacks DEBUG_PAGEALLOC
Message-Id: <163584789184.1845480.3901073706381572578.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:31 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 14 Oct 2021 08:04:38 +1030, Joel Stanley wrote:
> The page_alloc.c code will call into __kernel_map_pages when
> DEBUG_PAGEALLOC is configured and enabled.
> 
> As the implementation assumes hash, this should crash spectacularly if
> not for a bit of luck in __kernel_map_pages. In this function
> linear_map_hash_count is always zero, the for loop exits without doing
> any damage.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/s64: Clarify that radix lacks DEBUG_PAGEALLOC
      https://git.kernel.org/powerpc/c/4f703e7faa67a116016c4678fc88b507c12670c9

cheers
