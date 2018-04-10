Return-Path: <keescook@chromium.org>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LMGg50slzF2Ff
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 08:26:48 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id p6so5858277pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 15:26:47 -0700 (PDT)
Date: Tue, 10 Apr 2018 15:26:43 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Daniel Micay <danielmicay@gmail.com>
Subject: [PATCH] ibmvnic: Define vnic_login_client_data name field as unsized
 array
Message-ID: <20180410222643.GA29473@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "name" field of struct vnic_login_client_data is a char array of
undefined length. This should be written as "char name[]" so the compiler
can make better decisions about the field (for example, not assuming
it's a single character). This was noticed while trying to tighten the
CONFIG_FORTIFY_SOURCE checking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index aad5658d79d5..35fbb41cd2d4 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3170,7 +3170,7 @@ static int send_version_xchg(struct ibmvnic_adapter *adapter)
 struct vnic_login_client_data {
 	u8	type;
 	__be16	len;
-	char	name;
+	char	name[];
 } __packed;
 
 static int vnic_client_data_len(struct ibmvnic_adapter *adapter)
@@ -3199,21 +3199,21 @@ static void vnic_add_client_data(struct ibmvnic_adapter *adapter,
 	vlcd->type = 1;
 	len = strlen(os_name) + 1;
 	vlcd->len = cpu_to_be16(len);
-	strncpy(&vlcd->name, os_name, len);
-	vlcd = (struct vnic_login_client_data *)((char *)&vlcd->name + len);
+	strncpy(vlcd->name, os_name, len);
+	vlcd = (struct vnic_login_client_data *)(vlcd->name + len);
 
 	/* Type 2 - LPAR name */
 	vlcd->type = 2;
 	len = strlen(utsname()->nodename) + 1;
 	vlcd->len = cpu_to_be16(len);
-	strncpy(&vlcd->name, utsname()->nodename, len);
-	vlcd = (struct vnic_login_client_data *)((char *)&vlcd->name + len);
+	strncpy(vlcd->name, utsname()->nodename, len);
+	vlcd = (struct vnic_login_client_data *)(vlcd->name + len);
 
 	/* Type 3 - device name */
 	vlcd->type = 3;
 	len = strlen(adapter->netdev->name) + 1;
 	vlcd->len = cpu_to_be16(len);
-	strncpy(&vlcd->name, adapter->netdev->name, len);
+	strncpy(vlcd->name, adapter->netdev->name, len);
 }
 
 static int send_login(struct ibmvnic_adapter *adapter)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
