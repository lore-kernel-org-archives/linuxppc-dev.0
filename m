Return-Path: <hnguyen@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B27B367D93
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 07:47:09 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kA5Kkjl1215830
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:46:45 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA5KnR672568368
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:49:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA5Kkd25014923
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 20:46:39 GMT
From: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
To: rolandd@cisco.com
Subject: [PATCH 2.6.19 4/4] ehca: ehca_av.c use constant for max mtu
Date: Sun, 5 Nov 2006 21:42:56 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QzkTFQwVfAgoAV9"
Message-Id: <200611052142.56722.hnguyen@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_QzkTFQwVfAgoAV9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Roland!
This is a patch for ehca, mainly a code change to adhere to
kernel coding style. It defines and uses a constant EHCA_MAX_MTU 
instead hardcoded value.
Thanks!
Nam


Signed-off-by: Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_av.c |    5 ++---
 hipz_hw.h |    2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_av.c b/drivers/infiniband/hw/ehca/ehca_av.c
index 3bac197..214e2fd 100644
--- a/drivers/infiniband/hw/ehca/ehca_av.c
+++ b/drivers/infiniband/hw/ehca/ehca_av.c
@@ -118,8 +118,7 @@ struct ib_ah *ehca_create_ah(struct ib_p
   }
   memcpy(&av->av.grh.word_1, &gid, sizeof(gid));
  }
- /* for the time being we use a hard coded PMTU of 2048 Bytes */
- av->av.pmtu = 4;
+ av->av.pmtu = EHCA_MAX_MTU;
 
  /* dgid comes in grh.word_3 */
  memcpy(&av->av.grh.word_3, &ah_attr->grh.dgid,
@@ -193,7 +192,7 @@ int ehca_modify_ah(struct ib_ah *ah, str
   memcpy(&new_ehca_av.grh.word_1, &gid, sizeof(gid));
  }
 
- new_ehca_av.pmtu = 4; /* see also comment in create_ah() */
+ new_ehca_av.pmtu = EHCA_MAX_MTU;
 
  memcpy(&new_ehca_av.grh.word_3, &ah_attr->grh.dgid,
         sizeof(ah_attr->grh.dgid));
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index 3fc92b0..fad9136 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -45,6 +45,8 @@ #define __HIPZ_HW_H__
 
 #include "ehca_tools.h"
 
+#define EHCA_MAX_MTU 4
+
 /* QP Table Entry Memory Map */
 struct hipz_qptemm {
  u64 qpx_hcr;

--Boundary-00=_QzkTFQwVfAgoAV9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="roland_svnehca_0018_maxmtu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="roland_svnehca_0018_maxmtu.patch"

diff --git a/drivers/infiniband/hw/ehca/ehca_av.c b/drivers/infiniband/hw/ehca/ehca_av.c
index 3bac197..214e2fd 100644
--- a/drivers/infiniband/hw/ehca/ehca_av.c
+++ b/drivers/infiniband/hw/ehca/ehca_av.c
@@ -118,8 +118,7 @@ struct ib_ah *ehca_create_ah(struct ib_p
 		}
 		memcpy(&av->av.grh.word_1, &gid, sizeof(gid));
 	}
-	/* for the time being we use a hard coded PMTU of 2048 Bytes */
-	av->av.pmtu = 4;
+	av->av.pmtu = EHCA_MAX_MTU;
 
 	/* dgid comes in grh.word_3 */
 	memcpy(&av->av.grh.word_3, &ah_attr->grh.dgid,
@@ -193,7 +192,7 @@ int ehca_modify_ah(struct ib_ah *ah, str
 		memcpy(&new_ehca_av.grh.word_1, &gid, sizeof(gid));
 	}
 
-	new_ehca_av.pmtu = 4; /* see also comment in create_ah() */
+	new_ehca_av.pmtu = EHCA_MAX_MTU;
 
 	memcpy(&new_ehca_av.grh.word_3, &ah_attr->grh.dgid,
 	       sizeof(ah_attr->grh.dgid));
diff --git a/drivers/infiniband/hw/ehca/hipz_hw.h b/drivers/infiniband/hw/ehca/hipz_hw.h
index 3fc92b0..fad9136 100644
--- a/drivers/infiniband/hw/ehca/hipz_hw.h
+++ b/drivers/infiniband/hw/ehca/hipz_hw.h
@@ -45,6 +45,8 @@ #define __HIPZ_HW_H__
 
 #include "ehca_tools.h"
 
+#define EHCA_MAX_MTU 4
+
 /* QP Table Entry Memory Map */
 struct hipz_qptemm {
 	u64 qpx_hcr;

--Boundary-00=_QzkTFQwVfAgoAV9--
