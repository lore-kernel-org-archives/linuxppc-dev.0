Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD7C02C05B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:41:16 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 13:10:02 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4E14BE0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:11:37 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0M7f8xR39583822
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 13:11:08 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0M7f7uB011796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 18:41:09 +1100
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 23/45] [SCSI] fcoe: Use get/put_online_cpus_atomic() to
 prevent CPU offline
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com,
 paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org,
 akpm@linux-foundation.org, namhyung@kernel.org
Date: Tue, 22 Jan 2013 13:09:22 +0530
Message-ID: <20130122073919.13822.73176.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, fweisbec@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu,
 wangyun@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Robert Love <robert.w.love@intel.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: devel@open-fcoe.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/scsi/fcoe/fcoe.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 666b7ac..c971a17 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1475,6 +1475,7 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 	 * was originated, otherwise select cpu using rx exchange id
 	 * or fcoe_select_cpu().
 	 */
+	get_online_cpus_atomic();
 	if (ntoh24(fh->fh_f_ctl) & FC_FC_EX_CTX)
 		cpu = ntohs(fh->fh_ox_id) & fc_cpu_mask;
 	else {
@@ -1484,8 +1485,10 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 			cpu = ntohs(fh->fh_rx_id) & fc_cpu_mask;
 	}
 
-	if (cpu >= nr_cpu_ids)
+	if (cpu >= nr_cpu_ids) {
+		put_online_cpus_atomic();
 		goto err;
+	}
 
 	fps = &per_cpu(fcoe_percpu, cpu);
 	spin_lock(&fps->fcoe_rx_list.lock);
@@ -1505,6 +1508,7 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 		spin_lock(&fps->fcoe_rx_list.lock);
 		if (!fps->thread) {
 			spin_unlock(&fps->fcoe_rx_list.lock);
+			put_online_cpus_atomic();
 			goto err;
 		}
 	}
@@ -1526,6 +1530,7 @@ static int fcoe_rcv(struct sk_buff *skb, struct net_device *netdev,
 	if (fps->thread->state == TASK_INTERRUPTIBLE)
 		wake_up_process(fps->thread);
 	spin_unlock(&fps->fcoe_rx_list.lock);
+	put_online_cpus_atomic();
 
 	return 0;
 err:
