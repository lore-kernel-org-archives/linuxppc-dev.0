Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40243C4345F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2024 10:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJggr5HLwz3vbj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2024 20:46:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VJggP24jwz2ygY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2024 20:45:52 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 43GAcL6I005112;
	Tue, 16 Apr 2024 05:38:21 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 43GAcJln005111;
	Tue, 16 Apr 2024 05:38:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 16 Apr 2024 05:38:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
Message-ID: <20240416103819.GQ19790@gate.crashing.org>
References: <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
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
Cc: Nathan Chancellor <nathan@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, clang-built-linux <llvm@lists.linux.dev>, Nick Desaulniers <ndesaulniers@google.com>, open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jeff Xu <jeffxu@chromium.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2024 at 03:02:52PM +0530, Naresh Kamboju wrote:
> In file included from arch/powerpc/include/asm/io.h:672:
> arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer
> arithmetic on a null pointer has undefined behavior
> [-Werror,-Wnull-pointer-arithmetic]

It is not UB, but just undefined: the program is meaningless.

It is not a null pointer but even a null pointer constant here.  It
matters in places, including here.

It would help if the warnings were more correct :-(


Segher
