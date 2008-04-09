Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Wed, 09 Apr 2008 17:21:34 +1000
Subject: [PATCH 5/6] [POWERPC] properly declare onstack completion in iseries
	veth
Message-Id: <20080409072230.C861EDDED0@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The iSeries veth driver uses an on-stack struct completion that
it initializes using the COMPLETION_INITIALIZER instead of
COMPLETION_INITIALIZER_ONSTACK macro, causing problems with
lockdep.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/net/iseries_veth.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-work.orig/drivers/net/iseries_veth.c	2008-04-09 13:55:24.000000000 +1000
+++ linux-work/drivers/net/iseries_veth.c	2008-04-09 13:55:48.000000000 +1000
@@ -308,7 +308,8 @@ static void veth_complete_allocation(voi
 
 static int veth_allocate_events(HvLpIndex rlp, int number)
 {
-	struct veth_allocation vc = { COMPLETION_INITIALIZER(vc.c), 0 };
+	struct veth_allocation vc =
+		{ COMPLETION_INITIALIZER_ONSTACK(vc.c), 0 };
 
 	mf_allocate_lp_events(rlp, HvLpEvent_Type_VirtualLan,
 			    sizeof(struct veth_lpevent), number,
