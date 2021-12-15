Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CD5C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Dec 2021 00:27:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDGKy4nJ0z3dbK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Dec 2021 11:27:50 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDGJj32j8z2ywm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Dec 2021 11:26:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JDGJh6VlKz4xbd;
 Wed, 15 Dec 2021 11:26:44 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <ab58b296832b0ec650e2203200e060adbcb2677d.1637930421.git.christophe.leroy@csgroup.eu>
References: <ab58b296832b0ec650e2203200e060adbcb2677d.1637930421.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Allocate one 256k IBAT instead of two
 consecutives 128k IBATs
Message-Id: <163952787518.919625.8591134996141675509.b4-ty@ellerman.id.au>
Date: Wed, 15 Dec 2021 11:24:35 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 Nov 2021 13:40:35 +0100, Christophe Leroy wrote:
> Today we have the following IBATs allocated:
> 
> 	---[ Instruction Block Address Translation ]---
> 	0: 0xc0000000-0xc03fffff 0x00000000         4M Kernel   x     m
> 	1: 0xc0400000-0xc05fffff 0x00400000         2M Kernel   x     m
> 	2: 0xc0600000-0xc06fffff 0x00600000         1M Kernel   x     m
> 	3: 0xc0700000-0xc077ffff 0x00700000       512K Kernel   x     m
> 	4: 0xc0780000-0xc079ffff 0x00780000       128K Kernel   x     m
> 	5: 0xc07a0000-0xc07bffff 0x007a0000       128K Kernel   x     m
> 	6:         -
> 	7:         -
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Allocate one 256k IBAT instead of two consecutives 128k IBATs
      https://git.kernel.org/powerpc/c/37eb7ca91b692e8e49e7dd50158349a6c8fb5b09

cheers
