Return-Path: <suzuki@in.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D01F72C00C5
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 17:52:23 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <suzuki@in.ibm.com>;
 Tue, 27 Aug 2013 01:52:21 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 66C9F1FF001B
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 01:46:49 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7R7qHqv125278
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 01:52:18 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7R7qH0t008242
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 01:52:17 -0600
Subject: [PATCH] powerpc: Set the NOTE type for SPE regset
To: benh@kernel.crashing.org
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Tue, 27 Aug 2013 13:22:14 +0530
Message-ID: <20130827075156.18056.87943.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
 Roland McGrath <roland@hack.frob.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The regset defintion for SPE doesn't have the core_note_type
set, which prevents it from being dumped. Add the note type
NT_PPC_SPE for SPE regset.

Signed-off-by: Suzuki K Poulose <suzuki@in.ibm.com>
Cc:	Roland McGrath <roland@hack.frob.com>
---
 arch/powerpc/kernel/ptrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9a0d24c..16edc5d 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -657,7 +657,7 @@ static const struct user_regset native_regsets[] = {
 #endif
 #ifdef CONFIG_SPE
 	[REGSET_SPE] = {
-		.n = 35,
+		.core_note_type = NT_PPC_SPE, .n = 35,
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = evr_active, .get = evr_get, .set = evr_set
 	},
