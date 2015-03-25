Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ABE51A0671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:21:41 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D88C214015A
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:40 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 09:21:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1B0C22BB0055
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2PNLTmr45744334
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2PNL4Vk032691
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 10:21:04 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 4/4] drivers/vfio: Remove duplicated PE states
Date: Thu, 26 Mar 2015 10:20:37 +1100
Message-Id: <1427325637-14345-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1427325637-14345-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The set of constants for PE states defined in uapi/linux/vfio.h is
duplicated to uapi/asm/eeh.h. The patch removes the set from the
former.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 include/uapi/linux/vfio.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index d81c17f..3fd1e86 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -492,11 +492,6 @@ struct vfio_eeh_pe_op {
 #define VFIO_EEH_PE_UNFREEZE_IO		2	/* Enable IO for frozen PE   */
 #define VFIO_EEH_PE_UNFREEZE_DMA	3	/* Enable DMA for frozen PE  */
 #define VFIO_EEH_PE_GET_STATE		4	/* PE state retrieval        */
-#define  VFIO_EEH_PE_STATE_NORMAL	0	/* PE in functional state    */
-#define  VFIO_EEH_PE_STATE_RESET	1	/* PE reset in progress      */
-#define  VFIO_EEH_PE_STATE_STOPPED	2	/* Stopped DMA and IO        */
-#define  VFIO_EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only          */
-#define  VFIO_EEH_PE_STATE_UNAVAIL	5	/* State unavailable         */
 #define VFIO_EEH_PE_RESET_DEACTIVATE	5	/* Deassert PE reset         */
 #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
 #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
-- 
1.8.3.2
