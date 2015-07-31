Return-Path: <pebolle@tiscali.nl>
Received: from lb3-smtp-cloud3.xs4all.net (lb3-smtp-cloud3.xs4all.net
 [194.109.24.30])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B63711A088D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 22:09:07 +1000 (AEST)
Message-ID: <1438344538.13223.9.camel@tiscali.nl>
Subject: [PATCH] windfarm: decrement client count when unregistering
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 31 Jul 2015 14:08:58 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wf_unregister_client() increments the client count when a client
unregisters. That is obviously incorrect. Decrement that client count
instead.

Fixes: 75722d3992f5 ("[PATCH] ppc64: Thermal control for SMU based machines")

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
cross-compiled only. I don't have a PPC machine at hand, sorry. And this
does need some run-time testing, I'd day.

windfarm_corex_exit() contains:
    BUG_ON(wf_client_count != 0);

I wonder why that, apparently. never triggered.

 drivers/macintosh/windfarm_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_core.c
b/drivers/macintosh/windfarm_core.c
index 3ee198b65843..cc7ece1712b5 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -435,7 +435,7 @@ int wf_unregister_client(struct notifier_block *nb)
 {
 	mutex_lock(&wf_lock);
 	blocking_notifier_chain_unregister(&wf_client_list, nb);
-	wf_client_count++;
+	wf_client_count--;
 	if (wf_client_count == 0)
 		wf_stop_thread();
 	mutex_unlock(&wf_lock);
-- 
2.4.3
