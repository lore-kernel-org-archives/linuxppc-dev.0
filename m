Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF9AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 02:48:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4966505F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 02:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4966505F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzyQD2jWDz30Hr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 13:48:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DzyPs5qK3z2yxZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 13:47:43 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12G2iZBe019663;
 Mon, 15 Mar 2021 21:44:35 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 12G2iYKT019662;
 Mon, 15 Mar 2021 21:44:34 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 15 Mar 2021 21:44:34 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/kexec: Don't use .machine ppc64 in trampoline_64.S
Message-ID: <20210316024434.GE16691@gate.crashing.org>
References: <20210315034159.315675-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315034159.315675-1-mpe@ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Mon, Mar 15, 2021 at 02:41:59PM +1100, Michael Ellerman wrote:
> The ".machine" directive allows changing the machine for which code is
> being generated. It's equivalent to passing an -mcpu option on the
> command line.
> 
> Although it can be useful, it's generally a bad idea because it adds
> another way to influence code generation separate from the flags
> passed via the build system. ie. if we need to build different pieces
> of code with different flags we should do that via our Makefiles, not
> using ".machine".

It does not influence code generation.  It says which instructions are
valid, instead.  There are a few cases where the same mnemonic will
generate a different binary encoding depending on machine selected,
maybe you mean that?

It is *normal* to use .machine push/pop and a specific .machine around
instructions that require a machine other than what you are building
for.  The compiler does this itself, and it is the recommended way to
use "foreign" instructions in inline assembler.

That said...

> However as best as I can tell the ".machine" directive in
> trampoline_64.S is not necessary at all.
> 
> It was added in commit 0d97631392c2 ("powerpc: Add purgatory for
> kexec_file_load() implementation."), which created the file based on
> the kexec-tools purgatory. It may be/have-been necessary in the
> kexec-tools version, but we have a completely different build system,
> and we already pass the desired CPU flags, eg:
> 
>   gcc ... -m64 -Wl,-a64 -mabi=elfv2 -Wa,-maltivec -Wa,-mpower4 -Wa,-many
>   ... arch/powerpc/purgatory/trampoline_64.S
> 
> So drop the ".machine" directive and rely on the assembler flags.

> -	.machine ppc64

Please make sure to test this on a big endian config.

A ppc64le-linux assembler defaults to power8.  A ppc64-linux assembler
defaults to power3 (that is the same as .machine ppc64).  Or maybe it
makes it power4?  I get lost :-)

It certainly *should* work, but, test please :-)

(And with a *default* powerpc64-linux config, not one that defaults to
power7 or power8 or similar!  Arnd's toolchains at
<https://mirrors.edge.kernel.org/pub/tools/crosstool/>
are fine for this.)


Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
