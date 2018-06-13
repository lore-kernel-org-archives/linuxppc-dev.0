Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415SCy372jzDrbK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 23:25:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/64s: Report SLB multi-hit rather than parity error
Date: Wed, 13 Jun 2018 23:24:14 +1000
Message-Id: <20180613132414.32207-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we take an SLB multi-hit on bare metal, we see both the multi-hit
and parity error bits set in DSISR. The user manuals indicates this is
expected to always happen on Power8, whereas on Power9 it says a
multi-hit will "usually" also cause a parity error.

We decide what to do based on the various error tables in mce_power.c,
and because we process them in order and only report the first, we
currently always report a parity error but not the multi-hit, eg:

  Severe Machine check interrupt [Recovered]
    Initiator: CPU
    Error type: SLB [Parity]
      Effective address: c000000ffffd4300

Although this is correct, it leaves the user wondering why they got a
parity error. It would be clearer instead if we reported the
multi-hit because that is more likely to be simply a software bug,
whereas a true parity error is possibly an indication of a bad core.

We can do that simply by reordering the error tables so that multi-hit
appears before parity. That doesn't affect the error recovery at all,
because we flush the SLB either way.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/mce_power.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 38c5b4764bfe..1e450d0c4f72 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -140,12 +140,12 @@ static const struct mce_ierror_table mce_p7_ierror_table[] = {
 { 0x00000000001c0000, 0x0000000000040000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000001c0000, 0x00000000000c0000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
 { 0x00000000001c0000, 0x0000000000080000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000001c0000, 0x00000000000c0000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
 { 0x00000000001c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
@@ -164,12 +164,12 @@ static const struct mce_ierror_table mce_p8_ierror_table[] = {
 { 0x00000000081c0000, 0x0000000000040000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x00000000000c0000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
 { 0x00000000081c0000, 0x0000000000080000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000081c0000, 0x00000000000c0000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
 { 0x00000000081c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
@@ -194,12 +194,12 @@ static const struct mce_ierror_table mce_p9_ierror_table[] = {
 { 0x00000000081c0000, 0x0000000000040000, true,
   MCE_ERROR_TYPE_UE,  MCE_UE_ERROR_IFETCH,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
+{ 0x00000000081c0000, 0x00000000000c0000, true,
+  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
 { 0x00000000081c0000, 0x0000000000080000, true,
   MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_PARITY,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
-{ 0x00000000081c0000, 0x00000000000c0000, true,
-  MCE_ERROR_TYPE_SLB, MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
 { 0x00000000081c0000, 0x0000000000100000, true,
   MCE_ERROR_TYPE_ERAT,MCE_ERAT_ERROR_MULTIHIT,
   MCE_INITIATOR_CPU,  MCE_SEV_ERROR_SYNC, },
@@ -257,12 +257,12 @@ static const struct mce_derror_table mce_p7_derror_table[] = {
 { 0x00000400, true,
   MCE_ERROR_TYPE_TLB,  MCE_TLB_ERROR_MULTIHIT,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000080, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0x00000100, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-{ 0x00000080, true,
-  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0x00000040, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_INDETERMINATE, /* BOTH */
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
@@ -290,12 +290,12 @@ static const struct mce_derror_table mce_p8_derror_table[] = {
 { 0x00000200, true,
   MCE_ERROR_TYPE_ERAT, MCE_ERAT_ERROR_MULTIHIT, /* SECONDARY ERAT */
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000080, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0x00000100, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-{ 0x00000080, true,
-  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0, false, 0, 0, 0, 0 } };
 
 static const struct mce_derror_table mce_p9_derror_table[] = {
@@ -320,12 +320,12 @@ static const struct mce_derror_table mce_p9_derror_table[] = {
 { 0x00000200, false,
   MCE_ERROR_TYPE_USER, MCE_USER_ERROR_TLBIE,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
+{ 0x00000080, true,
+  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,	/* Before PARITY */
+  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0x00000100, true,
   MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_PARITY,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-{ 0x00000080, true,
-  MCE_ERROR_TYPE_SLB,  MCE_SLB_ERROR_MULTIHIT,
-  MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
 { 0x00000040, true,
   MCE_ERROR_TYPE_RA,   MCE_RA_ERROR_LOAD,
   MCE_INITIATOR_CPU,   MCE_SEV_ERROR_SYNC, },
-- 
2.14.1
