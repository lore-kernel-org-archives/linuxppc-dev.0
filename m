Return-Path: <weiyj.lk@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTFNw16hVzDqZX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 01:25:04 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id n23so6157213pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 May 2017 08:25:04 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Subject: [PATCH net-next] ibmvnic: fix missing unlock on error in
 __ibmvnic_reset()
Date: Thu, 18 May 2017 15:24:52 +0000
Message-Id: <20170518152452.8606-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <weiyongjun1@huawei.com>

Add the missing unlock before return from function __ibmvnic_reset()
in the error handling case.

Fixes: ed651a10875f ("ibmvnic: Updated reset handling")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 4f2d329..27f7933 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1313,6 +1313,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 
 	if (rc) {
 		free_all_rwi(adapter);
+		mutex_unlock(&adapter->reset_lock);
 		return;
 	}
