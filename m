Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A132C25B78
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2024 19:34:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VgKyy46TMz3fxq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2024 05:34:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VgKyR48Q0z3cXS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2024 05:33:32 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 44GJS9sG015776;
	Thu, 16 May 2024 14:28:10 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 44GJS6lh015769;
	Thu, 16 May 2024 14:28:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 16 May 2024 14:28:06 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andy Polyakov <appro@cryptogams.org>
Subject: Re: [PATCH 2/3] crypto: X25519 core functions for ppc64le
Message-ID: <20240516192806.GM19790@gate.crashing.org>
References: <20240514173835.4814-1-dtsen@linux.ibm.com> <20240514173835.4814-3-dtsen@linux.ibm.com> <847f2e4f-ace1-415d-b129-ed2751429eec@cryptogams.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847f2e4f-ace1-415d-b129-ed2751429eec@cryptogams.org>
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
Cc: herbert@gondor.apana.org.au, dtsen@us.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org, Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org, ltcgcw@linux.vnet.ibm.com, leitao@debian.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 15, 2024 at 10:29:56AM +0200, Andy Polyakov wrote:
> >+static void cswap(fe51 p, fe51 q, unsigned int bit)
> 
> The "c" in cswap stands for "constant-time," and the problem is that 
> contemporary compilers have exhibited the ability to produce 
> non-constant-time machine code as result of compilation of the above 
> kind of technique.

This can happen with *any* comnpiler, on *any* platform.  In general,
you have to write machine code if you want to be sure what machine code
will eventually be executed.

>  The outcome is platform-specific and ironically some 
> of PPC code generators were observed to generate "most" 
> non-constant-time code. "Most" in sense that execution time variations 
> would be most easy to catch. One way to work around the problem, at 
> least for the time being, is to add 'asm volatile("" : "+r"(c))' after 
> you calculate 'c'. But there is no guarantee that the next compiler 
> version won't see through it, hence the permanent solution is to do it 
> in assembly. I can put together something...

Such tricks can help ameliorate the problem, sure.  But it is not a
solution ever.


Segher
