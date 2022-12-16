Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C43C4332F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Dec 2022 17:22:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NYbWT4J92z3bgt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Dec 2022 04:22:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NYbVq6YnTz3Wtp
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2022 04:21:38 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2BGHINAG022024;
	Fri, 16 Dec 2022 11:18:23 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 2BGHILVe022023;
	Fri, 16 Dec 2022 11:18:21 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 16 Dec 2022 11:18:21 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: Pass correct CPU reference to assembler
Message-ID: <20221216171821.GA25951@gate.crashing.org>
References: <01fe73614988e2402a7526fb6b6e903bc3777bb5.1671179743.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fe73614988e2402a7526fb6b6e903bc3777bb5.1671179743.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Jan-Benedict Glaw <jbglaw@lug-owl.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Fri, Dec 16, 2022 at 09:35:50AM +0100, Christophe Leroy wrote:
> The problem comes from the fact that CONFIG_PPC_E500MC is selected for
> both the e500mc (32 bits) and the e5500 (64 bits), and therefore the
> following makefile rule is wrong:
> 
>   cpu-as-$(CONFIG_PPC_E500MC)    += $(call as-option,-Wa$(comma)-me500mc)

Yes.

> Today we have CONFIG_TARGET_CPU which provides the identification of the
> expected CPU, it is used for GCC. Use it as well for the assembler.

Why do you use -Wa, at all for this?  The compiler should already pass
proper options always!

> +cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-many)

What is this for?  Using -many is a huge step back, it hides many
problems :-(


Segher
