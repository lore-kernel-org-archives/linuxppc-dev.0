Return-Path: <SRS0=3A4D=LA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A80C47096
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:15:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D7D613EF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 12:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D7D613EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fyb736RQ5z3c5G
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 22:15:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fyb3H2zf1z309y
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jun 2021 22:12:11 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Fyb3G4c1Kz9sfG; Sun,  6 Jun 2021 22:12:10 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
 mhiramat@kernel.org, davem@davemloft.net,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <40a43d6df1fdf41ade36e9a46e60a4df774ca9f6.1620896780.git.christophe.leroy@csgroup.eu>
References: <40a43d6df1fdf41ade36e9a46e60a4df774ca9f6.1620896780.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] kprobes: Allow architectures to override optinsn
 page allocation
Message-Id: <162298132158.2353459.12128294246619463248.b4-ty@ellerman.id.au>
Date: Sun, 06 Jun 2021 22:08:41 +1000
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
Cc: clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 13 May 2021 09:07:51 +0000 (UTC), Christophe Leroy wrote:
> Some architectures like powerpc require a non standard
> allocation of optinsn page, because module pages are
> too far from the kernel for direct branches.
> 
> Define weak alloc_optinsn_page() and free_optinsn_page(), that
> fall back on alloc_insn_page() and free_insn_page() when not
> overriden by the architecture.

Applied to powerpc/next.

[1/2] kprobes: Allow architectures to override optinsn page allocation
      https://git.kernel.org/powerpc/c/7ee3e97e00a3893e354c3993c3f7d9dc127e9c5e
[2/2] powerpc/kprobes: Replace ppc_optinsn by common optinsn
      https://git.kernel.org/powerpc/c/b73c8cccd72ac28beaf262fd6ef4b91411fc8335

cheers
