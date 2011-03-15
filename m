Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B31E6B700D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 00:05:48 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2FCoZOU015070
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 06:50:35 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p2FD5ikf094470
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 07:05:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p2FD5hK0001781
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2011 07:05:44 -0600
Date: Tue, 15 Mar 2011 09:05:46 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
Message-ID: <20110315130546.GF3662@zod.rchland.ibm.com>
References: <1297292893-30241-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1297292893-30241-2-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297292893-30241-2-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2011 at 05:08:08PM -0600, Dave Kleikamp wrote:
>so that it can use information from the device tree.
>
>Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>Cc: linuxppc-dev@lists.ozlabs.org
>---

Ben, you want this patch dropped, right?

josh

> arch/powerpc/kernel/setup_32.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
>index 1d2fbc9..d1ca976 100644
>--- a/arch/powerpc/kernel/setup_32.c
>+++ b/arch/powerpc/kernel/setup_32.c
>@@ -120,12 +120,12 @@ notrace void __init machine_init(unsigned long dt_ptr)
> {
> 	lockdep_init();
>
>-	/* Enable early debugging if any specified (see udbg.h) */
>-	udbg_early_init();
>-
> 	/* Do some early initialization based on the flat device tree */
> 	early_init_devtree(__va(dt_ptr));
>
>+	/* Enable early debugging if any specified (see udbg.h) */
>+	udbg_early_init();
>+
> 	probe_machine();
>
> 	setup_kdump_trampoline();
>-- 
>1.7.3.4
>
