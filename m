Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58030DDECC
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 08:04:31 +1000 (EST)
Subject: [PATCH] net: Add napi_sycnhronize() to sync with napi poll
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@linux-foundation.org>
In-Reply-To: <20071017083107.6a1b1bd3@freepuppy.rosehill>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop> <47157EA4.1000500@garzik.org>
	<1192591481.11899.134.camel@pasglop>
	<20071017083107.6a1b1bd3@freepuppy.rosehill>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 08:04:14 +1000
Message-Id: <1192658654.6783.43.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	"David S. Miller" <davem@davemloft.net>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

net: Add __napi_synchronize() to sync with napi poll

The EMAC driver which needs to handle multiple devices with one
NAPI instance implements its own per-channel disable bit. However,
when setting such a bit, it needs to synchronize with the poller
(that is make sure that any pending poller instance has completed,
or is started late enough to see that disable bit).

This implements a low level __napi_synchronize() function to acheive
that. The underscores are to emphasis the low level aspect of it and
to discourage driver writers who don't know what they are doing to
use it (to please DaveM :-)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Back to msleep() since it fits my need well and that's what
you used as well. Note that the smp_mb() will turn into barrier()
on non-SMP.

I'll send a separate patch to fix EMAC to use the non __ version.

Index: linux-work/include/linux/netdevice.h
===================================================================
--- linux-work.orig/include/linux/netdevice.h	2007-10-17 13:31:32.000000000 +1000
+++ linux-work/include/linux/netdevice.h	2007-10-18 08:01:05.000000000 +1000
@@ -394,6 +394,23 @@ static inline void napi_disable(struct n
 }
 
 /**
+ *	napi_synchronize - synchronize with a concurrent poll
+ *	@n: napi context
+ *
+ * Synchronizes with a concurrent poll. Not to be used in normal
+ * drivers, mostly useful if you end up with multiple interfaces
+ * on one NAPI instance. This must be called from task context.
+ */
+static inline void napi_synchronize(struct napi_struct *n)
+{
+	smp_mb();
+#ifdef CONFIG_SMP
+	while (test_bit(NAPI_STATE_SCHED, &n->state))
+		msleep(1);
+#endif /* CONFIG_SMP */
+}
+
+/**
  *	napi_enable - enable NAPI scheduling
  *	@n: napi context
  *
