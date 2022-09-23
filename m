Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B696C6FA82
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 11:14:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYqLS4fmZz3f7H
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Sep 2022 21:14:56 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYqKg68S2z3c73
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Sep 2022 21:14:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYqKf0XnRz4xD1;
	Fri, 23 Sep 2022 21:14:14 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20220901110334.1618913-1-npiggin@gmail.com>
References: <20220901110334.1618913-1-npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc/64s: add pte_needs_flush and huge_pmd_needs_flush
Message-Id: <166393161342.498456.7392251296613915278.b4-ty@ellerman.id.au>
Date: Fri, 23 Sep 2022 21:13:33 +1000
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

On Thu, 1 Sep 2022 21:03:34 +1000, Nicholas Piggin wrote:
> Allow PTE changes to avoid flushing the TLB when access permissions are
> being relaxed, the dirty bit is being set, and the accessed bit is being
> changed.
> 
> Relaxing access permissions and setting dirty and accessed bits do not
> require a flush because the MMU will re-load the PTE and notice the
> updates (it may also cause a spurious fault).
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64s: add pte_needs_flush and huge_pmd_needs_flush
      https://git.kernel.org/powerpc/c/b11931e9adc1a439eab75c97ca4b9f15754cdcb1

cheers
