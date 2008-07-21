Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D2C31DE0A1
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 03:16:51 +1000 (EST)
Date: Mon, 21 Jul 2008 10:16:50 -0700 (PDT)
Message-Id: <20080721.101650.181903456.davem@davemloft.net>
To: smaclennan@pikatech.com
Subject: Re: Networkl problems with lastest kernel....
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080721130536.3ca72f3e@lappy.seanm.ca>
References: <20080721121829.28faffab@lappy.seanm.ca>
	<20080721.093110.141511905.davem@davemloft.net>
	<20080721130536.3ca72f3e@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sean MacLennan <smaclennan@pikatech.com>
Date: Mon, 21 Jul 2008 13:05:36 -0400

> But I have attached the new OOPS anyway.

The same problem is still there, this driver will
unfortunately require quite a bit more surgery.

You can instead add the following patch, it will
warn instead of BUG on you, and try to continue.

>From 867d79fb9a4d5929ad8335c896fcfe11c3b2ef14 Mon Sep 17 00:00:00 2001
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Jul 2008 09:54:18 -0700
Subject: [PATCH] net: In __netif_schedule() use WARN_ON instead of BUG_ON

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/core/dev.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7e2d527..cbc34c0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1327,7 +1327,8 @@ static void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 
 void __netif_schedule(struct Qdisc *q)
 {
-	BUG_ON(q == &noop_qdisc);
+	if (WARN_ON_ONCE(q == &noop_qdisc))
+		return;
 
 	if (!test_and_set_bit(__QDISC_STATE_SCHED, &q->state)) {
 		struct softnet_data *sd;
-- 
1.5.6.4.433.g09651
