Return-Path: <anton@samba.org>
Date: Tue, 1 Oct 2013 16:54:05 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, paulmck@linux.vnet.ibm.com
Subject: [PATCH] powerpc: Fix parameter clobber in csum_partial_copy_generic()
Message-ID: <20131001165405.325f053c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

The csum_partial_copy_generic() uses register r7 to adjust the remaining
bytes to process.  Unfortunately, r7 also holds a parameter, namely the
address of the flag to set in case of access exceptions while reading
the source buffer.  Lacking a quantum implementation of PowerPC, this
commit instead uses register r9 to do the adjusting, leaving r7's
pointer uncorrupted.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---

Index: b/arch/powerpc/lib/checksum_64.S
===================================================================
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -269,8 +269,8 @@ _GLOBAL(csum_partial_copy_generic)
 	rldicl. r6,r3,64-1,64-2		/* r6 = (r3 & 0x3) >> 1 */
 	beq	.Lcopy_aligned
 
-	li	r7,4
-	sub	r6,r7,r6
+	li	r9,4
+	sub	r6,r9,r6
 	mtctr	r6
 
 1:
