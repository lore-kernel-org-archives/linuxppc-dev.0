Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF7DC5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 12:14:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279E9206E5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 12:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279E9206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ch0F55g28zDqHL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 23:14:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cgzsd6dX3zDqdT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 22:57:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Cgzsd48jmz9sTR; Wed, 25 Nov 2020 22:57:41 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
In-Reply-To: <20201028080433.26799-1-ardb@kernel.org>
References: <20201028080433.26799-1-ardb@kernel.org>
Subject: Re: [PATCH] powerpc: avoid broken GCC __attribute__((optimize))
Message-Id: <160630540052.2174375.9307119240987760572.b4-ty@ellerman.id.au>
Date: Wed, 25 Nov 2020 22:57:41 +1100 (AEDT)
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
Cc: Kees Cook <keescook@chromium.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>,
 Paul Mackerras <paulus@samba.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 28 Oct 2020 09:04:33 +0100, Ard Biesheuvel wrote:
> Commit 7053f80d9696 ("powerpc/64: Prevent stack protection in early boot")
> introduced a couple of uses of __attribute__((optimize)) with function
> scope, to disable the stack protector in some early boot code.
> 
> Unfortunately, and this is documented in the GCC man pages [0], overriding
> function attributes for optimization is broken, and is only supported for
> debug scenarios, not for production: the problem appears to be that
> setting GCC -f flags using this method will cause it to forget about some
> or all other optimization settings that have been applied.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Avoid broken GCC __attribute__((optimize))
      https://git.kernel.org/powerpc/c/a7223f5bfcaeade4a86d35263493bcda6c940891

cheers
