Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3492C00144
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 13:13:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LvSdQ3G0Kz3fPp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 23:13:46 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LvSZ01wHQz305c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2022 23:10:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSYy5XDWz4xG0;
	Fri, 29 Jul 2022 23:10:46 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <2ee707512b8b212b079b877f4ceb525a1606a3fb.1656655567.git.christophe.leroy@csgroup.eu>
References: <2ee707512b8b212b079b877f4ceb525a1606a3fb.1656655567.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix boot failure with KASAN + SMP + JUMP_LABEL_FEATURE_CHECK_DEBUG
Message-Id: <165909975339.253830.11928843532091953158.b4-ty@ellerman.id.au>
Date: Fri, 29 Jul 2022 23:02:33 +1000
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
Cc: Erhard Furtner <erhard_f@mailbox.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 1 Jul 2022 08:06:15 +0200, Christophe Leroy wrote:
> Since commit 4291d085b0b0 ("powerpc/32s: Make pte_update() non
> atomic on 603 core"), pte_update() has been using
> mmu_has_feature(MMU_FTR_HPTE_TABLE) to avoid a useless atomic
> operation on 603 cores.
> 
> When kasan_early_init() sets up the early zero shadow, it uses
> __set_pte_at(). On book3s/32, __set_pte_at() calls pte_update()
> when CONFIG_SMP is selected in order to ensure the preservation of
> _PAGE_HASHPTE in case of concurrent update of the PTE. But that's
> too early for mmu_has_feature(), so when
> CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG is selected, mmu_has_feature()
> calls printk(). That's too early to call printk() because KASAN
> early zero shadow page is not set up yet. It leads to a deadlock.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Fix boot failure with KASAN + SMP + JUMP_LABEL_FEATURE_CHECK_DEBUG
      https://git.kernel.org/powerpc/c/6042a1652d643d1d34fa89bb314cb102960c0800

cheers
