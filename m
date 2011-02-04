Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 666F7B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  5 Feb 2011 00:57:09 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p14DWv8r008075
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 08:33:10 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BC43C4DE8040
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Feb 2011 08:56:24 -0500 (EST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p14Dv3q4478250
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 08:57:03 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p14Dv2VR004372
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Feb 2011 06:57:03 -0700
Date: Fri, 4 Feb 2011 08:56:27 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 4/6] powerpc/44x: don't use tlbivax on AMP systems
Message-ID: <20110204135627.GF17643@zod.rchland.ibm.com>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296586126-32765-5-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 01, 2011 at 12:48:44PM -0600, Dave Kleikamp wrote:
>diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
>index 2a030d8..b33c5e6 100644
>--- a/arch/powerpc/mm/tlb_nohash.c
>+++ b/arch/powerpc/mm/tlb_nohash.c
>@@ -35,6 +35,7 @@
> #include <linux/preempt.h>
> #include <linux/spinlock.h>
> #include <linux/memblock.h>
>+#include <linux/of_fdt.h>
>
> #include <asm/tlbflush.h>
> #include <asm/tlb.h>
>@@ -153,6 +154,17 @@ EXPORT_SYMBOL(local_flush_tlb_page);
>  */
> #ifdef CONFIG_SMP
>
>+static int amp;
>+
>+#ifdef CONFIG_44x
>+void __init early_init_mmu_44x(void)
>+{
>+	unsigned long root = of_get_flat_dt_root();
>+	if (of_flat_dt_is_compatible(root, "ibm,47x-AMP"))
>+		amp = 1;
>+}
>+#endif /* CONFIG_44x */

Something aside from the property thing sits weirdly with me on this as
well.

We have this guarded by CONFIG_44x but also CONFIG_SMP, and we're doing
476 specific checks (for now).  There is at least one 44x board that has
dual-CPUs (AMCC Arches, iirc) that can theoretically be run in AMP mode.
However, it won't be using an SMP kernel because it's a single core per CPU.
Admittedly I don't think it supports the tlbivax instruction either so
the patch as it stands doesn't impact that theoretical scenario much.

I do wonder if we really need to guard the call to this behind
CONFIG_SMP though.  Maybe a slight performance increase I suppose, but
if we wind up using the AMP check elsewhere then it might be needed
anyway.  Something to think about.

Oh, and I agree 'cooperative-partition' or something would be a better
check.

josh
