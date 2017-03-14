Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjDlN6X5vzDr8h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 23:37:20 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g2so19791569pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 05:37:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 6/6] powerpc/64s: POWER8 add missing machine check definitions
Date: Tue, 14 Mar 2017 22:36:48 +1000
Message-Id: <20170314123648.26068-7-npiggin@gmail.com>
In-Reply-To: <20170314123648.26068-1-npiggin@gmail.com>
References: <20170314123648.26068-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8 uses bit 36 in SRR1 like POWER9 for i-side machine checks, and
contains several conditions for link timeouts that are not currently
handled.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 95ed9d85ebcf..736530219bc3 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -184,27 +184,33 @@ static const struct mce_ierror_table mce_p7_ierror_table[] = {
 { 0, 0, 0, 0, 0, 0 } };
 
 static const struct mce_ierror_table mce_p8_ierror_table[] = {
-{ 0x00000000001c0000, 0x0000000000040000, true,
+{ 0x00000000081c0000, 0x0000000000040000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000001c0000, 0x0000000000080000, true,
+{ 0x00000000081c0000, 0x0000000000080000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000001c0000, 0x00000000000c0000, true,
+{ 0x00000000081c0000, 0x00000000000c0000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000001c0000, 0x0000000000100000, true,
+{ 0x00000000081c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000001c0000, 0x0000000000140000, true,
+{ 0x00000000081c0000, 0x0000000000140000, true,
   MCE_ERROR_TYPE_TLB, MCE_TLB_ERROR_MULTIHIT,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000001c0000, 0x0000000000180000, true,
+{ 0x00000000081c0000, 0x0000000000180000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000001c0000, 0x00000000001c0000, true,
+{ 0x00000000081c0000, 0x00000000001c0000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000008000000, true,
+  MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_IFETCH_TIMEOUT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x0000000008040000, true,
+  MCE_ERROR_TYPE_LINK,MCE_LINK_ERROR_PAGE_TABLE_WALK_IFETCH_TIMEOUT,
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
 { 0, 0, 0, 0, 0, 0 } };
 
 static const struct mce_ierror_table mce_p9_ierror_table[] = {
@@ -289,6 +295,12 @@ static const struct mce_derror_table mce_p8_derror_table[] = {
 { 0x00004000, true,
   MCE_ERROR_TYPE_UE,   MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00002000, true,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_LOAD_TIMEOUT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00001000, true,
+  MCE_ERROR_TYPE_LINK, MCE_LINK_ERROR_PAGE_TABLE_WALK_LOAD_STORE_TIMEOUT,
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0x00000800, true,
   MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-- 
2.11.0
