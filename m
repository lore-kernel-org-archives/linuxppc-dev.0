Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F9FECAAD5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Sep 2022 11:32:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJwkq0hxZz3f2L
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Sep 2022 21:32:51 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJwk86tTyz3byL
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2022 21:32:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJwk85ytmz4wgr;
	Fri,  2 Sep 2022 21:32:16 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220815114840.1468656-1-mpe@ellerman.id.au>
References: <20220815114840.1468656-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/code-patching: Speed up page mapping/unmapping
Message-Id: <166211832579.555339.11284897477664030047.b4-ty@ellerman.id.au>
Date: Fri, 02 Sep 2022 21:32:05 +1000
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Aug 2022 21:48:40 +1000, Michael Ellerman wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Since commit 591b4b268435 ("powerpc/code-patching: Pre-map patch area")
> the patch area is premapped so intermediate page tables are already
> allocated.
> 
> Use __set_pte_at() directly instead of the heavy map_kernel_page(),
> at for unmapping just do a pte_clear() followed by a flush.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/code-patching: Speed up page mapping/unmapping
      https://git.kernel.org/powerpc/c/8b4bb0ad00cb347f62e76a636ce08eb179c843fc

cheers
