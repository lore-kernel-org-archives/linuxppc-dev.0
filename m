Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA7AC43334
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Jul 2022 01:43:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LrjWG4VSgz3chS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Jul 2022 11:43:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LrjVn1qndz3bZs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2022 11:43:28 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26P1f2gP023146;
	Sun, 24 Jul 2022 20:41:02 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 26P1f1YV023145;
	Sun, 24 Jul 2022 20:41:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Sun, 24 Jul 2022 20:41:01 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc/purgatory: Omit use of bin2c
Message-ID: <20220725014100.GQ25951@gate.crashing.org>
References: <20220625224037.836581-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625224037.836581-1-masahiroy@kernel.org>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jun 26, 2022 at 07:40:37AM +0900, Masahiro Yamada wrote:
> The .incbin assembler directive is much faster than bin2c + $(CC).

And perhaps more importantly it is simpler and less clumsy.

> --- /dev/null
> +++ b/arch/powerpc/purgatory/kexec-purgatory.S
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +	.section .rodata, "a"
> +
> +	.align	8
> +kexec_purgatory:
> +	.globl	kexec_purgatory
> +	.incbin	"arch/powerpc/purgatory/purgatory.ro"
> +.Lkexec_purgatroy_end:

Typo here (s/ro/or/)

> +
> +	.align	8
> +kexec_purgatory_size:
> +	.globl	kexec_purgatory_size
> +	.quad	.Lkexec_purgatroy_end - kexec_purgatory

And here again ofc.

Looks good to me otherwise, nice cleanup :-)

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
