Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A74E1A0D86
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 19:58:20 +1100 (AEDT)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 15 Jan 2015 08:58:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 631931B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 08:58:51 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F8wEd055574704
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 08:58:14 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F8wEDX012563
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 01:58:14 -0700
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] kernel: Fix sparse warning for ACCESS_ONCE
Date: Thu, 15 Jan 2015 09:58:34 +0100
Message-Id: <1421312314-72330-9-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit a91ed664749c ("kernel: tighten rules for ACCESS ONCE") results in
sparse warnings like "Using plain integer as NULL pointer" - Let's add a
type cast to the dummy assignment.
To avoid warnings lik "sparse: warning: cast to restricted __hc32" we also
use __force on that cast.

Fixes: a91ed664749c ("kernel: tighten rules for ACCESS ONCE")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5e186bf..7bebf05 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -461,7 +461,7 @@ static __always_inline void __assign_once_size(volatile void *p, void *res, int
  * If possible use READ_ONCE/ASSIGN_ONCE instead.
  */
 #define __ACCESS_ONCE(x) ({ \
-	 __maybe_unused typeof(x) __var = 0; \
+	 __maybe_unused typeof(x) __var = (__force typeof(x)) 0; \
 	(volatile typeof(x) *)&(x); })
 #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
 
-- 
1.9.3
