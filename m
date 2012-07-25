Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0DEA32C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 01:21:51 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Jul 2012 01:21:29 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6PFD67N57278664
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 01:13:07 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6PFLFGP026312
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 01:21:15 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH -V4 12/12] arch/powerpc: properly isolate kernel and user
 proto-VSID
In-Reply-To: <1343221085-30661-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1343221085-30661-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343221085-30661-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 25 Jul 2012 20:51:09 +0530
Message-ID: <87txwv7tp6.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


MAX_CONTEXT change in this patch was not related. So may be we need it 
to be a separate patch ?

-aneesh

>From c67fb1b973c317f114ee256110cfc1b016dc1841 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 25 Jul 2012 18:34:12 +0530
Subject: [PATCH -V4] arch/powerpc: Replace open coded CONTEXT_BITS value

To clarify the meaning for future readers, replace the open coded
19 with CONTEXT_BITS

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mmu_context_hash64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 40677aa..daa076c 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -34,7 +34,7 @@ static DEFINE_IDA(mmu_context_ida);
  * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
  * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
  */
-#define MAX_CONTEXT	((1UL << 19) - 1)
+#define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)
 
 int __init_new_context(void)
 {
-- 
1.7.10
