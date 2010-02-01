Return-Path: <minyard@acm.org>
Received: from vms173003pub.verizon.net (vms173003pub.verizon.net
	[206.46.173.3]) by ozlabs.org (Postfix) with ESMTP id F0974B7D4F
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 07:37:38 +1100 (EST)
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
	by vms173003.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0KX600L2ZH5C5N2B@vms173003.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 01 Feb 2010 13:36:49 -0600 (CST)
Date: Mon, 01 Feb 2010 13:36:47 -0600
From: Corey Minyard <minyard@acm.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Add coherent_dma_mask setting to platform devices
Message-id: <20100201193647.GA10863@minyard.local>
References: <20100130000407.GA16156@minyard.local>
	<1265000313.8287.25.camel@pasglop>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <1265000313.8287.25.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Corey Minyard <cminyard@mvista.com>

DMA ops requires that coherent_dma_mask be set properly for a device,
but this was not being done for platform devices on powerpc.  The
MPSC drivers, in particular, need this for both serial and ethernet
or they won't be able to allocate memory.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
How about this patch?  It seems to work ok and I suppose this makes
sense.  I'll send the uart setting in another patch.

Index: linux-2.6/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6/arch/powerpc/kernel/setup-common.c
@@ -681,6 +681,7 @@ static int ppc_dflt_bus_notify(struct no
 		return 0;
 
 	set_dma_ops(dev, &dma_direct_ops);
+	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
 	return NOTIFY_DONE;
 }
