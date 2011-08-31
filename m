Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E7A9B6F80
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2011 07:33:16 +1000 (EST)
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
In-Reply-To: <4E5DFC41.7030606@windriver.com>
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>
	<4E1FCFEF.7070702@windriver.com>
	<20110715134232.56373e03@schlenkerla.am.freescale.net>
	<82C960D7DF4A1F47B94FC1C67A29BEE384D577@ALA-MBA.corp.ad.wrs.com>
	<20110718105627.245c9fa4@schlenkerla.am.freescale.net>
	<4E2561F0.5040701@windriver.com> <1314683064.2488.76.camel@pasglop>
	<4E5DFC41.7030606@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Sep 2011 07:32:59 +1000
Message-ID: <1314826379.2488.151.camel@pasglop>
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

On Wed, 2011-08-31 at 17:17 +0800, tiejun.chen wrote:

> > It sounds hackish but it makes it easier to fix everybody at once, there
> > are "issues" with changing stacks especially on ppc64 and it would
> > definitely be affected as well if the stack frame created is larger than
> > our gap.
> 
> If we provide another exception stack like we did debug exception on ppc64, are
> there those "issues" you said?

Actually if we allocate it like the irq stacks, we should be ok, but
that's yet another 16K per CPU that needs to be covered by the first
segment, nasty....

In any case, please try to come up with a patch that covers all
variants.

Cheers,
Ben.
 
