Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830B3C432BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 13:32:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CB260E78
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 13:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23CB260E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gx0yK68xvz3gF7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 23:32:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ellerman.id.au; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gx0l85ncTz3cGb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 23:23:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0l34th3z9tk2;
 Fri, 27 Aug 2021 23:22:55 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Frederic Weisbecker <frederic@kernel.org>, Paul Mackerras <paulus@samba.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Wan Jiabing <wanjiabing@vivo.com>, Ganesh Goudar <ganeshgr@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Randy Dunlap <rdunlap@infradead.org>, Cédric Le Goater <clg@kaod.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michal Suchanek <msuchanek@suse.de>
In-Reply-To: <20210323062916.295346-1-wanjiabing@vivo.com>
References: <20210323062916.295346-1-wanjiabing@vivo.com>
Subject: Re: [PATCH] [v2] arch: powerpc: Remove duplicate includes
Message-Id: <163007013805.52768.8530805049704388181.b4-ty@ellerman.id.au>
Date: Fri, 27 Aug 2021 23:15:38 +1000
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
Cc: kael_w@yeah.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 23 Mar 2021 14:29:05 +0800, Wan Jiabing wrote:
> mmu-hash.h: asm/bug.h has been included at line 12, so remove
> the duplicate one at line 21.
> interrupt.c: asm/interrupt.h has been included at line 12, so
> remove the duplicate one at line 10.
> time.c: linux/sched/clock.h has been included at line 33,so
> remove the duplicate one at line 56 and move sched/cputime.h
> under sched including segament.
> 
> [...]

Applied to powerpc/next.

[1/1] arch: powerpc: Remove duplicate includes
      https://git.kernel.org/powerpc/c/e225c4d6bc389701f2f63fc246420a1da3465ab5

cheers
