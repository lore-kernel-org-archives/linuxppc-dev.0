Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9E7C2BA18
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2024 13:31:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3SMX2Gz1z3cby
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2024 23:31:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W3SM31fQKz3cTZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2024 23:31:10 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 45IDRsNt014239;
	Tue, 18 Jun 2024 08:27:54 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 45IDRqpp014238;
	Tue, 18 Jun 2024 08:27:52 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 18 Jun 2024 08:27:52 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
Message-ID: <20240618132752.GT19790@gate.crashing.org>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn> <20240617161336.GM19790@gate.crashing.org> <87cyoe1mbd.fsf@mail.lhotse>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyoe1mbd.fsf@mail.lhotse>
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
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu, npiggin@gmail.com, naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, Jinglin Wen <jinglin.wen@shingroup.cn>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 18, 2024 at 10:12:54PM +1000, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Mon, Jun 17, 2024 at 10:35:09AM +0800, Jinglin Wen wrote:
> >> +	cmplwi	cr0,r4,0	/* runtime base addr is zero */
> >
> > Just write
> >    cmpwi r4,0
> >
> > cr0 is the default, also implicit in many other instructions, please
> > don't clutter the source code.  All the extra stuff makes you miss the
> > things that do matter!
> >
> > The "l" is unnecessary, you only care about equality here after all.
> 
> In my mind it's an unsigned comparison, so I'd use cmpld, even though as
> you say all we actually care about is equality.

We want to know if it is zero or not, so in my mind "unsigned comparison"
does not apply at all, that is only for range checks.  Heh.

But it doesn't matter at all: if you think cmpld looks more natural / is
what you expect to see, then you should use cmpld, that is my point :-)


Segher
