Return-Path: <shemminger@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A141DDF87
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:31:59 +1000 (EST)
Date: Wed, 17 Oct 2007 08:31:07 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH/RFC] net: Add __napi_sycnhronize() to sync with napi poll
Message-ID: <20071017083107.6a1b1bd3@freepuppy.rosehill>
In-Reply-To: <1192591481.11899.134.camel@pasglop>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop> <47157EA4.1000500@garzik.org>
	<1192591481.11899.134.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	"David S. Miller" <davem@davemloft.net>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please don't use double underscore, for this function name. There is no
reason to not make it a normal API call.

The sky2 fix I am working on will use napi_synchronize as well.

--- a/include/linux/netdevice.h	2007-10-16 16:48:20.000000000 -0700
+++ b/include/linux/netdevice.h	2007-10-17 08:29:55.000000000 -0700
@@ -407,6 +407,24 @@ static inline void napi_enable(struct na
 	clear_bit(NAPI_STATE_SCHED, &n->state);
 }
 
+#ifdef CONFIG_SMP
+/**
+ *	napi_synchronize - wait until NAPI is not running
+ *	@n: napi context
+ *
+ * Wait until NAPI is done being scheduled on this context.
+ * Any outstanding processing completes but
+ * does not disable future activations.
+ */
+static inline void napi_synchronize(const struct napi_struct *n)
+{
+	while (test_bit(NAPI_STATE_SCHED, &n->state))
+		msleep(1);
+}
+#else
+# define napi_synchronize(n)	barrier()
+#endif
+
 /*
  *	The DEVICE structure.
  *	Actually, this whole structure is a big mistake.  It mixes I/O
