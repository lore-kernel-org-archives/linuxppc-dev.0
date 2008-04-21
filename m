Return-Path: <fenkes@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 02F78DE1AB
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 18:07:06 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m3L871Nr092488
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:07:01 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m3L871vV1896460
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 09:07:01 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m3L86xqL024601
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 08:07:00 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 4/5] IB/ehca: Make some module parameters bool,
	update descriptions
References: <200804211003.10695.fenkes@de.ibm.com>
In-Reply-To: <200804211003.10695.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Mon, 21 Apr 2008 09:06:58 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804211006.59197.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_main.c |   37 +++++++++++++++----------------
 1 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index ab02ac8..45fe35a 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -69,41 +69,40 @@ int ehca_static_rate   = -1;
 int ehca_scaling_code  = 0;
 int ehca_lock_hcalls   = -1;
 
-module_param_named(open_aqp1,     ehca_open_aqp1,     int, S_IRUGO);
-module_param_named(debug_level,   ehca_debug_level,   int, S_IRUGO);
-module_param_named(hw_level,      ehca_hw_level,      int, S_IRUGO);
-module_param_named(nr_ports,      ehca_nr_ports,      int, S_IRUGO);
-module_param_named(use_hp_mr,     ehca_use_hp_mr,     int, S_IRUGO);
-module_param_named(port_act_time, ehca_port_act_time, int, S_IRUGO);
-module_param_named(poll_all_eqs,  ehca_poll_all_eqs,  int, S_IRUGO);
-module_param_named(static_rate,   ehca_static_rate,   int, S_IRUGO);
-module_param_named(scaling_code,  ehca_scaling_code,  int, S_IRUGO);
+module_param_named(open_aqp1,     ehca_open_aqp1,     bool, S_IRUGO);
+module_param_named(debug_level,   ehca_debug_level,   int,  S_IRUGO);
+module_param_named(hw_level,      ehca_hw_level,      int,  S_IRUGO);
+module_param_named(nr_ports,      ehca_nr_ports,      int,  S_IRUGO);
+module_param_named(use_hp_mr,     ehca_use_hp_mr,     bool, S_IRUGO);
+module_param_named(port_act_time, ehca_port_act_time, int,  S_IRUGO);
+module_param_named(poll_all_eqs,  ehca_poll_all_eqs,  bool, S_IRUGO);
+module_param_named(static_rate,   ehca_static_rate,   int,  S_IRUGO);
+module_param_named(scaling_code,  ehca_scaling_code,  bool, S_IRUGO);
 module_param_named(lock_hcalls,   ehca_lock_hcalls,   bool, S_IRUGO);
 
 MODULE_PARM_DESC(open_aqp1,
-		 "AQP1 on startup (0: no (default), 1: yes)");
+		 "Open AQP1 on startup (default: no)");
 MODULE_PARM_DESC(debug_level,
 		 "Amount of debug output (0: none (default), 1: traces, "
 		 "2: some dumps, 3: lots)");
 MODULE_PARM_DESC(hw_level,
-		 "hardware level"
-		 " (0: autosensing (default), 1: v. 0.20, 2: v. 0.21)");
+		 "Hardware level (0: autosensing (default), "
+		 "0x10..0x14: eHCA, 0x20..0x23: eHCA2)");
 MODULE_PARM_DESC(nr_ports,
 		 "number of connected ports (-1: autodetect, 1: port one only, "
 		 "2: two ports (default)");
 MODULE_PARM_DESC(use_hp_mr,
-		 "high performance MRs (0: no (default), 1: yes)");
+		 "Use high performance MRs (default: no)");
 MODULE_PARM_DESC(port_act_time,
-		 "time to wait for port activation (default: 30 sec)");
+		 "Time to wait for port activation (default: 30 sec)");
 MODULE_PARM_DESC(poll_all_eqs,
-		 "polls all event queues periodically"
-		 " (0: no, 1: yes (default))");
+		 "Poll all event queues periodically (default: yes)");
 MODULE_PARM_DESC(static_rate,
-		 "set permanent static rate (default: disabled)");
+		 "Set permanent static rate (default: no static rate)");
 MODULE_PARM_DESC(scaling_code,
-		 "set scaling code (0: disabled/default, 1: enabled)");
+		 "Enable scaling code (default: no)");
 MODULE_PARM_DESC(lock_hcalls,
-		 "serialize all hCalls made by the driver "
+		 "Serialize all hCalls made by the driver "
 		 "(default: autodetect)");
 
 DEFINE_RWLOCK(ehca_qp_idr_lock);
-- 
1.5.5
