Return-Path: <grant@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 36AC3DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 14:41:24 +1100 (EST)
Received: from pd4mr5so.prod.shaw.ca (pd4mr5so-qfe3.prod.shaw.ca [10.0.141.50])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JY400GX54WNNU60@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 21 Mar 2008 21:41:11 -0600 (MDT)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JY4002W24WMHE20@pd4mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 21 Mar 2008 21:41:11 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JY400EPY4WHVW20@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 21 Mar 2008 21:41:10 -0600 (MDT)
Date: Fri, 21 Mar 2008 21:41:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc5200: fix null dereference if bestcomm fails to
	initialize
In-reply-to: <>
To: linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <1206157265-6973-1-git-send-email-grant.likely@secretlab.ca>
References: <>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the bestcomm initialization fails, calls to the task allocate
function should fail gracefully instead of oopsing with a NULL deref.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Paul, here's another bug fix that I'd like picked up for .25

 arch/powerpc/sysdev/bestcomm/bestcomm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/bestcomm/bestcomm.c b/arch/powerpc/sysdev/bestcomm/bestcomm.c
index f589999..f9cd04e 100644
--- a/arch/powerpc/sysdev/bestcomm/bestcomm.c
+++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
@@ -52,6 +52,10 @@ bcom_task_alloc(int bd_count, int bd_size, int priv_size)
 	int i, tasknum = -1;
 	struct bcom_task *tsk;
 
+	/* Don't try to do anything is bestcomm init failed */
+	if (!bcom_eng)
+		return NULL;
+
 	/* Get and reserve a task num */
 	spin_lock(&bcom_eng->lock);
 
-- 
1.5.4.3
