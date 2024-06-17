Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E082C27C79
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2024 16:24:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W2wFH30L1z3g9J
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2024 02:24:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W2wDq2BJPz2xqq
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2024 02:23:55 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 45HGLpBU028823;
	Mon, 17 Jun 2024 11:21:51 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 45HGLpUo028822;
	Mon, 17 Jun 2024 11:21:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 17 Jun 2024 11:21:51 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5.10] powerpc/uaccess: Fix build errors seen with GCC 13/14
Message-ID: <20240617162151.GN19790@gate.crashing.org>
References: <20240614112714.3482739-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614112714.3482739-1-mpe@ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 14, 2024 at 09:27:14PM +1000, Michael Ellerman wrote:
> commit 2d43cc701b96f910f50915ac4c2a0cae5deb734c upstream.
> The 'std' instruction requires a 4-byte aligned displacement because
> it is a DS-form instruction, and as the assembler says, 18 is not a
> multiple of 4.

You learn something new every day :-)

> A similar error is seen with GCC 13 and CONFIG_UBSAN_SIGNED_WRAP=y.
> 
> The fix is to change the constraint on the memory operand to put_user(),
> from "m" which is a general memory reference to "YZ".
> 
> The "Z" constraint is documented in the GCC manual PowerPC machine
> constraints, and specifies a "memory operand accessed with indexed or
> indirect addressing". "Y" is not documented in the manual but specifies
> a "memory operand for a DS-form instruction". Using both allows the
> compiler to generate a DS-form "std" or X-form "stdx" as appropriate.

https://gcc.gnu.org/PR115289
It will be documented soon, thanks for the report!

> Although the build error is only seen with GCC 13/14, that appears
> to just be luck. The constraint has been incorrect since it was first
> added.

Yes, "m" allows any memory operand, an unaligned one is just fine.

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
