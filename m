Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4606CDE036
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 11:12:00 +1100 (EST)
Subject: Re: [PATCH 2/7] [POWERPC] Xilinx: clear data caches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <1197590848.15741.199.camel@pasglop>
References: <1197589413-5965-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20071213234240.F3CC3AD805D@mail122-sin.bigfish.com>
	<1197590848.15741.199.camel@pasglop>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 11:09:41 +1100
Message-Id: <1197590981.15741.201.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, simekm2@fel.cvut.cz
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-12-14 at 11:07 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2007-12-13 at 15:43 -0800, Stephen Neuendorffer wrote:
> > This code is needed to boot without a boot loader.
> > 
> > Grant:  I'm not sure where the right place to put this is.  I'm assuming we'll actually need some boot code that is not generic?  Also, note that there is a V4FX errata workaround in arch/ppc/boot/head.S, which probably also needs to get pulled to powerpc.
> > 
> > Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> > ---
> >  arch/powerpc/boot/raw-platform.c |   22 ++++++++++++++++++++++
> >  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> This raw-platform.c file doesn't seem like a good place for code that is
> totally platform specific ...

Maybe best is to do that in asm ? The problem when you are in C code is
that you may already have hit stale cache entries. "raw" platforms
probably need to perform various CPU-specific initializations anyway,
prior to entering C code, in a custom crt0.S, so that's probably the
best place to do the cache clearing.

Ben.
