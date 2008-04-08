Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18427.11023.8067.795279@cargo.ozlabs.ibm.com>
Date: Tue, 8 Apr 2008 18:21:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.25-rc2-git4 - Regression Kernel oops while running
	kernbench and tbench on powerpc
In-Reply-To: <47BC40BC.3040405@linux.vnet.ibm.com>
References: <47BC40BC.3040405@linux.vnet.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal writes:

> The Kernel oopses is seen while running the kernbench followed by tbench with 2.6.25-rc2-git4 
> kernel on powerpc, this oops was reported for the 2.6.24-rc8-mm1 kernel (http://lkml.org/lkml/2008/1/18/71)
> and is visible with almost all of the main line ,rc(s) and their git(s) release from then.
> 
> This oops is visible in the linux-next-20080220 kernel also.The machine is power4+ box with four cpus and 
> has 30 GB RAM.

Please try to replicate the oops with the patch below applied.  It
doesn't solve the cause of the oops but it should mean the kernel
prints out more useful information about the cause of the oops.

I assume you can replicate the oops easily on this machine - is that
right?

Paul.

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 11b4f6d..a3ac72a 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -621,7 +621,7 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 	mtlr	r10
 
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
-	beq-	unrecov_slb
+	beq-	2f
 
 .machine	push
 .machine	"power4"
@@ -643,6 +643,22 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 	rfid
 	b	.	/* prevent speculative execution */
 
+2:
+#ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
+	b	unrecov_slb
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
+#endif /* CONFIG_PPC_ISERIES */
+	mfspr	r11,SPRN_SRR0
+	clrrdi	r10,r13,32
+	LOAD_HANDLER(r10,unrecov_slb)
+	mtspr	SPRN_SRR0,r10
+	mfmsr	r10
+	ori	r10,r10,MSR_IR|MSR_DR|MSR_RI
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
+
 unrecov_slb:
 	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
 	DISABLE_INTS
