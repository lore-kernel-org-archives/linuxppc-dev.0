Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E11EB64DC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jul 2023 13:52:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R6Ddv4vQWz3cWh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jul 2023 23:52:35 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R6DdM22s8z30g8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2023 23:52:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6DdK2fcwz4wqZ;
	Thu, 20 Jul 2023 23:52:05 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Gray <bgray@linux.ibm.com>
In-Reply-To: <20230710044143.146840-1-bgray@linux.ibm.com>
References: <20230710044143.146840-1-bgray@linux.ibm.com>
Subject: Re: [PATCH] powerpc/kasan: Disable KCOV in KASAN code
Message-Id: <168986105080.1117384.11586815448171823746.b4-ty@ellerman.id.au>
Date: Thu, 20 Jul 2023 23:50:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Mon, 10 Jul 2023 14:41:43 +1000, Benjamin Gray wrote:
> As per the generic KASAN code in mm/kasan, disable KCOV with
> KCOV_INSTRUMENT := n in the makefile.
> 
> This fixes a ppc64 boot hang when KCOV and KASAN are enabled.
> kasan_early_init() gets called before a PACA is initialised, but the
> KCOV hook expects a valid PACA.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kasan: Disable KCOV in KASAN code
      https://git.kernel.org/powerpc/c/ccb381e1af1ace292153c88eb1fffa5683d16a20

cheers
