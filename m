Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: Add length setting to set_dawr
Date: Fri, 25 Jan 2013 12:02:58 +1100
Message-Id: <1359075779-27492-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we set the length field in the DAWR to 0 which defaults it to one
double word (64bits) which is the same as the DABR.

Change this so that we can set it to longer values as supported by the DAWR.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/process.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bccc81b..f49a05f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -420,7 +420,7 @@ static inline int set_dabr(struct arch_hw_breakpoint *brk)
 
 static inline int set_dawr(struct arch_hw_breakpoint *brk)
 {
-	unsigned long dawr, dawrx;
+	unsigned long dawr, dawrx, mrd;
 
 	dawr = brk->address;
 
@@ -430,6 +430,14 @@ static inline int set_dawr(struct arch_hw_breakpoint *brk)
 		                   << (63 - 59); //* translate */
 	dawrx |= (brk->type & (HW_BRK_TYPE_PRIV_ALL)) \
 		                   >> 3; //* PRIM bits */
+	/* dawr length is stored in field MDR bits 48:53.  Matches range in
+	   doublewords (64 bits) baised by -1 eg. 0b000000=1DW and
+	   0b111111=64DW.
+	   brk->len is in bytes.
+	   This aligns up to double word size, shifts and does the bias.
+	*/
+	mrd = ((brk->len + 7) >> 3) - 1;
+	dawrx |= (mrd & 0x3f) << (63 - 53);
 
 	if (ppc_md.set_dawr)
 		return ppc_md.set_dawr(dawr, dawrx);
-- 
1.7.10.4
