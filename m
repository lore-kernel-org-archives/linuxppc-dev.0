Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A41DC43334
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jun 2022 16:02:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LCv7N6XhRz3cB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jun 2022 02:02:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LCv6v017zz3bXn
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2022 02:02:30 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 251G0NK6016107;
	Wed, 1 Jun 2022 11:00:23 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 251G0NVF016106;
	Wed, 1 Jun 2022 11:00:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 1 Jun 2022 11:00:23 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Rohan McLure <rmclure@linux.ibm.com>
Subject: Re: [PATCH 1/6] powerpc: Add ZERO_GPRS macros for register clears
Message-ID: <20220601160023.GV25951@gate.crashing.org>
References: <20220601054850.250287-1-rmclure@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601054850.250287-1-rmclure@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Wed, Jun 01, 2022 at 03:48:45PM +1000, Rohan McLure wrote:
> +.macro BINOP_REGS op, rhs, start, end
> +	.Lreg=\start
> +	.rept (\end - \start + 1)
> +	\op .Lreg, \rhs
> +	.Lreg=.Lreg+1
> +	.endr
> +.endm

This is for unary operations, not binary operations (there is only one
item on the RHS).  You can in principle put a string "a,b" in the rhs
parameter, but in practice you need a or b to depend on the loop counter
as well, so even such trickiness won't do.  Make the naming less
confusing, maybe?  Or don't have an unused extra level of abstraction in
the first place :-)


Segher
