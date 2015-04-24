Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DAC211A0D38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 15:52:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <netdev@vger.kernel.org>
Subject: [PATCH] ehea: Fix memory hook reference counting crashes
Date: Fri, 24 Apr 2015 15:52:32 +1000
Message-Id: <1429854752-5698-1-git-send-email-mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Anton Blanchard <anton@samba.org>, cascardo@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent commit to only register the EHEA memory hotplug hooks on
adapter probe has a few problems.

Firstly the reference counting is wrong for multiple adapters, in that
the hooks are registered multiple times. Secondly the check in the tear
down path is backward. Finally the error path doesn't decrement the
count.

The multiple registration of the hooks is the biggest problem, as it
leads to oopses when the system is rebooted, and/or errors during memory
hotplug, eg:

  $ ./mem-on-off-test.sh -r 2
  ...
  ehea: memory is going offline
  ehea: LPAR memory changed - re-initializing driver
  ehea: re-initializing driver complete
  ehea: memory is going offline
  ehea: LPAR memory changed - re-initializing driver
  ehea: opcode=26c ret=fffffffffffffffc arg1=8000000003000003 arg2=0 arg3=700000060000d600 arg4=3fded0000 arg5=200 arg6=0 arg7=0
  ehea: register_rpage_mr failed
  ehea: registering mr failed
  ehea: register MR failed - driver inoperable!
  ehea: memory is going offline

Fixes: aa183323312d ("ehea: Register memory hotplug, reboot and crash hooks on adapter probe")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index c05e50759621..00d86be0c831 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -3347,7 +3347,7 @@ static int ehea_register_memory_hooks(void)
 {
 	int ret = 0;
 
-	if (atomic_inc_and_test(&ehea_memory_hooks_registered))
+	if (atomic_inc_return(&ehea_memory_hooks_registered) > 1)
 		return 0;
 
 	ret = ehea_create_busmap();
@@ -3381,12 +3381,14 @@ out3:
 out2:
 	unregister_reboot_notifier(&ehea_reboot_nb);
 out:
+	atomic_dec(&ehea_memory_hooks_registered);
 	return ret;
 }
 
 static void ehea_unregister_memory_hooks(void)
 {
-	if (atomic_read(&ehea_memory_hooks_registered))
+	/* Only remove the hooks if we've registered them */
+	if (atomic_read(&ehea_memory_hooks_registered) == 0)
 		return;
 
 	unregister_reboot_notifier(&ehea_reboot_nb);
-- 
2.1.0
