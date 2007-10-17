Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8525DDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 12:52:40 +1000 (EST)
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi poll
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@linux-foundation.org>
In-Reply-To: <20071016115318.0fc36af3@freepuppy.rosehill>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 12:52:02 +1000
Message-Id: <1192589522.11899.130.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	"David S. Miller" <davem@davemloft.net>,
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

Switched to do a cpu_relax() spin instead and only on SMP. Not that
we have an smp_mb() in there which synchronize_irq() lacks. I believe
this is a bug in synchronize_irq() which I'll handle separately.

Note: unfortunately, Jeff already picked up the EMAC patch without
waiting for this to be sorted out (oops...). So if you agree with
this patch, it would be nice to have it go in quickly or maybe via
Jeff's tree to avoid breakage ? Not terribly important tho.

Index: linux-work/include/linux/netdevice.h
===================================================================
--- linux-work.orig/include/linux/netdevice.h	2007-10-17 12:39:40.000000000 +1000
+++ linux-work/include/linux/netdevice.h	2007-10-17 12:40:59.000000000 +1000
@@ -394,6 +394,23 @@ static inline void napi_disable(struct n
 }
 
 /**
+ *	__napi_synchronize - synchronize with a concurrent poll
+ *	@n: napi context
+ *
+ * Synchronizes with a concurrent poll. Not to be used in normal
+ * drivers, mostly useful if you end up with multiple interfaces
+ * on one NAPI instance.
+ */
+static inline void __napi_synchronize(struct napi_struct *n)
+{
+#ifdef CONFIG_SMP
+	smp_mb();
+	while (test_bit(NAPI_STATE_SCHED, &n->state))
+		cpu_relax();
+#endif /* CONFIG_SMP */
+}
+
+/**
  *	napi_enable - enable NAPI scheduling
  *	@n: napi context
  *
