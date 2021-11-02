Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F4AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:40:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333FA603E5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 333FA603E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7J26kTjz3c9S
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:40:34 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7Fb4Z3Xz2xBq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fb1Zn4z4xcJ;
 Tue,  2 Nov 2021 22:38:27 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <971b69739ff4746252e711a9845210465c023a9e.1635425947.git.christophe.leroy@csgroup.eu>
References: <971b69739ff4746252e711a9845210465c023a9e.1635425947.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Don't provide __kernel_map_pages() without
 ARCH_SUPPORTS_DEBUG_PAGEALLOC
Message-Id: <163584792877.1845480.15860244911222952564.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:12:08 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 28 Oct 2021 14:59:15 +0200, Christophe Leroy wrote:
> When ARCH_SUPPORTS_DEBUG_PAGEALLOC is not selected, the user can
> still select CONFIG_DEBUG_PAGEALLOC in which case __kernel_map_pages()
> is provided by mm/page_poison.c
> 
> So only define __kernel_map_pages() when both
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC and CONFIG_DEBUG_PAGEALLOC
> are defined.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Don't provide __kernel_map_pages() without ARCH_SUPPORTS_DEBUG_PAGEALLOC
      https://git.kernel.org/powerpc/c/f8c0e36b48e32b14bb83332d24e0646acd31d9e9

cheers
