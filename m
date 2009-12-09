Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 15097B6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Dec 2009 21:44:30 +1100 (EST)
Date: Wed, 9 Dec 2009 13:44:27 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] gianfar: Fix build with CONFIG_NET_POLL_CONTROLLER=y
Message-ID: <20091209104427.GA25526@oksana.dev.rtsoft.ru>
References: <1260341804.16132.22.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1260341804.16132.22.camel@pasglop>
Cc: Sandeep Gopalpet <Sandeep.Kumar@freescale.com>, netdev@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 46ceb60ca80fa07703bc6eb8f4651f900dff5a82 ("gianfar: Add
Multiple group Support") introduced the following build error
with CONFIG_NET_POLL_CONTROLLER=y:

  CC      ggianfar.o
ggianfar.c: In function 'gfar_netpoll':
ggianfar.c:2653: error: invalid storage class for function 'gfar_interrupt'
ggianfar.c:2652: warning: ISO C90 forbids mixed declarations and code
ggianfar.c:2681: error: invalid storage class for function 'adjust_link'
ggianfar.c:2764: error: invalid storage class for function 'gfar_set_multi'
ggianfar.c:2855: error: invalid storage class for function 'gfar_clear_exact_match'
ggianfar.c:2877: error: invalid storage class for function 'gfar_set_hash_for_addr'
ggianfar.c:2898: error: invalid storage class for function 'gfar_set_mac_for_addr'
ggianfar.c:2922: error: invalid storage class for function 'gfar_error'
ggianfar.c:3020: warning: ISO C90 forbids mixed declarations and code
ggianfar.c:3032: error: invalid storage class for function 'gfar_init'
ggianfar.c:3037: error: invalid storage class for function 'gfar_exit'
ggianfar.c:3041: error: initializer element is not constant
ggianfar.c:3042: error: initializer element is not constant
ggianfar.c:3042: warning: ISO C90 forbids mixed declarations and code
ggianfar.c:3042: error: expected declaration or statement at end of input
make[1]: *** [ggianfar.o] Error 1

This patch fixes the issue.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Wed, Dec 09, 2009 at 05:56:44PM +1100, Benjamin Herrenschmidt wrote:
> In my next (not pushed out yet as I'm writing this but will be by the
> time you read it hopefully), I get a build failure:
> 
> /home/benh/linux-powerpc-test/drivers/net/gianfar.c: In function ‘gfar_netpoll’:
> /home/benh/linux-powerpc-test/drivers/net/gianfar.c:2653: error: invalid storage class for function ‘gfar_interrupt’
[...]
> make[3]: *** [drivers/net/gianfar.o] Error 1
> 
> Stephen says that breakage has been in -next for some time...
> 
> Can you guys sort it out ?

 drivers/net/gianfar.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 16def13..6850dc0 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -2644,6 +2644,7 @@ static void gfar_netpoll(struct net_device *dev)
 			gfar_interrupt(priv->gfargrp[i].interruptTransmit,
 						&priv->gfargrp[i]);
 			enable_irq(priv->gfargrp[i].interruptTransmit);
+		}
 	}
 }
 #endif
-- 
1.6.3.3
