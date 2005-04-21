Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C54D167A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 09:47:02 +1000 (EST)
Date: Thu, 21 Apr 2005 15:50:27 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: 26-devel@cyclades.com,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050421185027.GB12442@logos.cnet>
References: <20050421183239.GJ6525@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
In-Reply-To: <20050421183239.GJ6525@logos.cnet>
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2005 at 03:32:39PM -0300, Marcelo Tosatti wrote:
> Capture session of /proc/tlbmiss with 1 second interval:

Forgot to attach /proc/tlbmiss patch, here it is.

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tlbmiss-count-2.4.patch"

--- linux-216.orig/arch/ppc/kernel/head_8xx.S	2005-01-19 10:37:12.000000000 -0200
+++ linux-216/arch/ppc/kernel/head_8xx.S	2005-03-04 18:56:38.351004576 -0300
@@ -331,10 +331,21 @@
 	 * kernel page tables.
 	 */
 	andi.	r21, r20, 0x0800	/* Address >= 0x80000000 */
-	beq	3f
+	beq	4f
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
 	rlwimi	r20, r21, 0, 2, 19
+
+        lis     r3,(itlbkernel_miss-KERNELBASE)@ha
+        lwz     r11,(itlbkernel_miss-KERNELBASE)@l(r3)
+        addi    r11,r11,1
+        stw     r11,(itlbkernel_miss-KERNELBASE)@l(r3)
+        beq 3f
+4:
+	lis     r3,(itlbuser_miss-KERNELBASE)@ha
+        lwz     r11,(itlbuser_miss-KERNELBASE)@l(r3)
+        addi    r11,r11,1
+        stw     r11,(itlbuser_miss-KERNELBASE)@l(r3)
 3:
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
 	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
@@ -414,10 +425,23 @@
 	 * kernel page tables.
 	 */
 	andi.	r21, r20, 0x0800
-	beq	3f
+	beq	4f
 	lis	r21, swapper_pg_dir@h
 	ori	r21, r21, swapper_pg_dir@l
 	rlwimi r20, r21, 0, 2, 19
+
+        lis     r3,(dtlbkernel_miss-KERNELBASE)@ha
+        lwz     r11,(dtlbkernel_miss-KERNELBASE)@l(r3)
+        addi    r11,r11,1
+        stw     r11,(dtlbkernel_miss-KERNELBASE)@l(r3)
+        beq 3f
+
+4:
+        lis     r3,(dtlbuser_miss-KERNELBASE)@ha
+        lwz     r11,(dtlbuser_miss-KERNELBASE)@l(r3)
+        addi    r11,r11,1
+        stw     r11,(dtlbuser_miss-KERNELBASE)@l(r3)
+
 3:
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
 	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
@@ -989,3 +1013,14 @@
 	.space	16
 #endif
 
+_GLOBAL(itlbuser_miss)
+        .space 4
+                                                                                       
+_GLOBAL(itlbkernel_miss)
+        .space 4
+                                                                                       
+_GLOBAL(dtlbuser_miss)
+        .long 0
+                                                                                       
+_GLOBAL(dtlbkernel_miss)
+        .long 0
--- linux-216.orig/fs/proc/proc_misc.c	2005-01-19 10:37:12.000000000 -0200
+++ linux-216/fs/proc/proc_misc.c	2005-03-04 18:57:37.241051928 -0300
@@ -621,6 +621,12 @@
 		if (entry)
 			entry->proc_fops = &ppc_htab_operations;
 	}
+        {
+        extern struct file_operations ppc_tlbmiss_operations;
+        entry = create_proc_entry("tlbmiss", S_IRUGO|S_IWUSR, NULL);
+        if (entry)
+                entry->proc_fops = &ppc_tlbmiss_operations;
+        }
 #endif
 	entry = create_proc_read_entry("slabinfo", S_IWUSR | S_IRUGO, NULL,
 				       slabinfo_read_proc, NULL);
--- linux-216.orig/arch/ppc/kernel/ppc_htab.c	2005-01-19 10:37:12.000000000 -0200
+++ linux-216/arch/ppc/kernel/ppc_htab.c	2005-03-04 19:04:05.276061640 -0300
@@ -21,6 +21,7 @@
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
 #include <linux/threads.h>
+#include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -32,6 +33,51 @@
 #include <asm/cputable.h>
 #include <asm/system.h>
 
+#if 1
+
+extern unsigned long itlbuser_miss, itlbkernel_miss;
+extern unsigned long dtlbuser_miss, dtlbkernel_miss;
+
+static ssize_t ppc_tlbmiss_write(struct file *file, const char * buffer,
+                                size_t count, loff_t *ppos);
+static int ppc_tlbmiss_show(struct seq_file *m, void *v);
+static int ppc_tlbmiss_open(struct inode *inode, struct file *file);
+
+struct file_operations ppc_tlbmiss_operations = {
+        .open   = ppc_tlbmiss_open,
+        .read   = seq_read,
+        .llseek = seq_lseek,
+        .write = ppc_tlbmiss_write,
+        .release = seq_release,
+};
+
+static int ppc_tlbmiss_open(struct inode *inode, struct file *file)
+{
+        return seq_open(file, &ppc_tlbmiss_show);
+}
+                                                                                         
+static int ppc_tlbmiss_show(struct seq_file *m, void *v)
+{
+        seq_printf(m, "I-TLB userspace misses: %lu\n"
+                      "I-TLB kernel misses: %lu\n"
+                      "D-TLB userspace misses: %lu\n"
+                      "D-TLB kernel misses: %lu\n",
+                        itlbuser_miss, itlbkernel_miss,
+                        dtlbuser_miss, dtlbkernel_miss);
+        return 0;
+}
+                                                                                         
+static ssize_t ppc_tlbmiss_write(struct file *file, const char * buffer,
+                                size_t count, loff_t *ppos)
+{
+        itlbuser_miss = 0;
+        itlbkernel_miss = 0;
+        dtlbuser_miss = 0;
+        dtlbkernel_miss = 0;
+}
+#endif
+
+
 static ssize_t ppc_htab_read(struct file * file, char * buf,
 			     size_t count, loff_t *ppos);
 static ssize_t ppc_htab_write(struct file * file, const char * buffer,

--fUYQa+Pmc3FrFX/N--
