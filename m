Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2E8F7B7C7E
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 20:39:28 +1100 (EST)
Date: Mon, 29 Mar 2010 11:39:22 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drivers/macintosh: Correct potential double free
Message-ID: <Pine.LNX.4.64.1003291138520.21896@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

The conditionals were testing different values, but then all freeing the
same one, which could result in a double free.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,e;
identifier f;
iterator I;
statement S;
@@

*kfree(x);
... when != &x
    when != x = e
    when != I(x,...) S
*x
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/macintosh/windfarm_pm91.c   |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/macintosh/windfarm_pm91.c b/drivers/macintosh/windfarm_pm91.c
index bea9916..3442732 100644
--- a/drivers/macintosh/windfarm_pm91.c
+++ b/drivers/macintosh/windfarm_pm91.c
@@ -687,12 +687,9 @@ static int __devexit wf_smu_remove(struct platform_device *ddev)
 		wf_put_control(cpufreq_clamp);
 
 	/* Destroy control loops state structures */
-	if (wf_smu_slots_fans)
-		kfree(wf_smu_cpu_fans);
-	if (wf_smu_drive_fans)
-		kfree(wf_smu_cpu_fans);
-	if (wf_smu_cpu_fans)
-		kfree(wf_smu_cpu_fans);
+	kfree(wf_smu_slots_fans);
+	kfree(wf_smu_drive_fans);
+	kfree(wf_smu_cpu_fans);
 
 	return 0;
 }
