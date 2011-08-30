Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76A84B6F70
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 15:44:38 +1000 (EST)
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
In-Reply-To: <4E2561F0.5040701@windriver.com>
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>
	<4E1FCFEF.7070702@windriver.com>
	<20110715134232.56373e03@schlenkerla.am.freescale.net>
	<82C960D7DF4A1F47B94FC1C67A29BEE384D577@ALA-MBA.corp.ad.wrs.com>
	<20110718105627.245c9fa4@schlenkerla.am.freescale.net>
	<4E2561F0.5040701@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 15:44:24 +1000
Message-ID: <1314683064.2488.76.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > As I understand it, the problem comes from the fact that stwu combines the
> > creation of a stack frame with storing into that stack frame.  If they were
> 
> Yes.
> 
> > separate instructions you'd have a new exception frame at a lower address
> > by the time you actually store to the non-exception frame.
> 
> So when kprobe we should use a unique stack frame to skip that stack frame the
> kprobed stwu want to create.

I still don't like that patch. Potentially the problem exist for all
variants of powerpc, not just booke, and I'm not sure I like adding yet
another exception stack.

Another (non-great) approach would be to special case stwu to the stack,
and instead of doing the store while emulating the instruction, keep the
store address around and do it later, after the stack has been unwound,
in the exit path (a TIF flag to hit the slow path and then do it in the
slow path).

It sounds hackish but it makes it easier to fix everybody at once, there
are "issues" with changing stacks especially on ppc64 and it would
definitely be affected as well if the stack frame created is larger than
our gap.

Cheers,
Ben.
