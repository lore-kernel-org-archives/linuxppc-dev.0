Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27D2C48297
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Feb 2024 18:00:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TYXLS3Vrvz3h05
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Feb 2024 05:00:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TYXL03k6hz3cB0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2024 05:00:08 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 41CHx6Yw014674;
	Mon, 12 Feb 2024 11:59:06 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 41CHx6WK014673;
	Mon, 12 Feb 2024 11:59:06 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 12 Feb 2024 11:59:06 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH] powerpc: Add gpr1 and fpu save/restore functions
Message-ID: <20240212175906.GY19790@gate.crashing.org>
References: <995988479.14839534.1707756078600.JavaMail.zimbra@raptorengineeringinc.com> <20240212170207.GW19790@gate.crashing.org> <1251499652.14843228.1707757778984.JavaMail.zimbra@raptorengineeringinc.com> <20240212173043.GX19790@gate.crashing.org> <572013249.14851324.1707759979044.JavaMail.zimbra@raptorengineeringinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572013249.14851324.1707759979044.JavaMail.zimbra@raptorengineeringinc.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 12, 2024 at 11:46:19AM -0600, Timothy Pearson wrote:
> Interesting, that make sense.
> 
> How should we proceed from the current situation?  Bringing in libgcc seems
> like a fairly invasive change,

I have done it for *all* architectures some ten years ago.  Never found
any problem.

> should we merge this to fix the current bug
> (cannot build ppc64 kernel in size-optimized mode) and start discussion on
> bringing in libgcc as the long-term fix across multiple architectures?
> 
> My goal here is to not have to carry a downstream patch in perpetuity for
> our embedded Linux firmware, which needs to be compiled in size-optimized
> mode due to hardware Flash limitations.

There are better options than -Os, fwiw.  Some --param's give smaller
*and* faster kernels.  What exactly is best is heavily arch-dependent
though (as well as dependent on the application code, the kernel code in
this case) :-(


Segher
