Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56B96B6FF6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 18:01:13 +1100 (EST)
Subject: Re: [PATCH v3 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20110315130546.GF3662@zod.rchland.ibm.com>
References: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1297292893-30241-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110315130546.GF3662@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 18:01:05 +1100
Message-ID: <1300345265.22236.1205.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-03-15 at 09:05 -0400, Josh Boyer wrote:
> On Wed, Feb 09, 2011 at 05:08:08PM -0600, Dave Kleikamp wrote:
> >so that it can use information from the device tree.
> >
> >Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> >Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> >Cc: linuxppc-dev@lists.ozlabs.org
> >---
> 
> Ben, you want this patch dropped, right?

Yes !

Cheers,
Ben.

> josh
> 
> > arch/powerpc/kernel/setup_32.c |    6 +++---
> > 1 files changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> >index 1d2fbc9..d1ca976 100644
> >--- a/arch/powerpc/kernel/setup_32.c
> >+++ b/arch/powerpc/kernel/setup_32.c
> >@@ -120,12 +120,12 @@ notrace void __init machine_init(unsigned long dt_ptr)
> > {
> > 	lockdep_init();
> >
> >-	/* Enable early debugging if any specified (see udbg.h) */
> >-	udbg_early_init();
> >-
> > 	/* Do some early initialization based on the flat device tree */
> > 	early_init_devtree(__va(dt_ptr));
> >
> >+	/* Enable early debugging if any specified (see udbg.h) */
> >+	udbg_early_init();
> >+
> > 	probe_machine();
> >
> > 	setup_kdump_trampoline();
> >-- 
> >1.7.3.4
> >
