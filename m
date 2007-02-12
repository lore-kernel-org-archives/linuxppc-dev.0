Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 278A7DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 03:02:44 +1100 (EST)
Subject: [PATCH 13/12] mpic: set IPIs to be per-CPU
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1170969252.2620.335.camel@localhost.localdomain>
References: <20070207124536.963531000@sipsolutions.net>
	<1170940611.4385.56.camel@johannes.berg>
	<1170969252.2620.335.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 12 Feb 2007 16:20:18 +0100
Message-Id: <1171293618.10344.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes the MPIC IPIs to be per-CPU to avoid getting a
warning ("Cannot set affinity for irq 251") when taking a CPU
offline via sysfs or during suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
Yup, that's a lot better, thanks.

 arch/powerpc/sysdev/mpic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6-git.orig/arch/powerpc/sysdev/mpic.c	2007-02-12 15:12:36.079524117 +0100
+++ linux-2.6-git/arch/powerpc/sysdev/mpic.c	2007-02-12 15:23:18.812465943 +0100
@@ -1388,7 +1388,7 @@ void mpic_request_ipis(void)
 			printk(KERN_ERR "Failed to map IPI %d\n", i);
 			break;
 		}
-		request_irq(vipi, mpic_ipi_action, IRQF_DISABLED,
+		request_irq(vipi, mpic_ipi_action, IRQF_DISABLED|IRQF_PERCPU,
 			    ipi_names[i], mpic);
 	}
 }
