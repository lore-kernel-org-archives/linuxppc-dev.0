Return-Path: <fenkes@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36C1BDDF08
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:33:30 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8BDXOaq095718
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 13:33:24 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8BDXOVq3100804
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 14:33:24 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8BDX7kU031176
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 14:33:08 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH 07/12] IB/ehca: ehca_gen_warn() should always print
References: <200709111518.26276.fenkes@de.ibm.com>
In-Reply-To: <200709111518.26276.fenkes@de.ibm.com>
MIME-Version: 1.0
Date: Tue, 11 Sep 2007 15:32:50 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111532.51179.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---
 drivers/infiniband/hw/ehca/ehca_tools.h |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index 57c77a7..f9b264b 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -98,15 +98,12 @@ extern int ehca_debug_level;
 	} while (0)
 
 #define ehca_gen_warn(format, arg...) \
-	do { \
-		if (unlikely(ehca_debug_level)) \
-			printk(KERN_INFO "PU%04x EHCA_WARN:%s " format "\n", \
-			       get_paca()->paca_index, __FUNCTION__, ## arg); \
-	} while (0)
+	printk(KERN_INFO "PU%04x EHCA_WARN:%s " format "\n", \
+	       get_paca()->paca_index, __FUNCTION__, ## arg)
 
 #define ehca_gen_err(format, arg...) \
 	printk(KERN_ERR "PU%04x EHCA_ERR:%s " format "\n", \
-		get_paca()->paca_index, __FUNCTION__, ## arg)
+	       get_paca()->paca_index, __FUNCTION__, ## arg)
 
 /**
  * ehca_dmp - printk a memory block, whose length is n*8 bytes.
-- 
1.5.2
