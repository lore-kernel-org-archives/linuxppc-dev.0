Return-Path: <anton@samba.org>
Date: Thu, 1 Dec 2011 12:46:45 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, hbabu@us.ibm.com,
 jkenisto@us.ibm.com
Subject: [PATCH] powerpc/nvram: Add spinlock to oops_to_nvram to prevent
 oops in compression code.
Message-ID: <20111201124645.24c6e54f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When issuing a system reset we almost always oops in the oops_to_nvram
code because multiple CPUs are using the deflate work area. Add a
spinlock to protect it.

To play it safe I'm using trylock to avoid locking up if the NVRAM
code oopses. This means we might miss multiple CPUs oopsing at exactly
the same time but I think it's best to play it safe for now. Once we
are happy with the reliability we can change it to a full spinlock.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/platforms/pseries/nvram.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/nvram.c	2011-12-01 09:44:27.205568463 +1100
+++ linux-build/arch/powerpc/platforms/pseries/nvram.c	2011-12-01 12:36:49.334478156 +1100
@@ -634,6 +634,8 @@ static void oops_to_nvram(struct kmsg_du
 {
 	static unsigned int oops_count = 0;
 	static bool panicking = false;
+	static DEFINE_SPINLOCK(lock);
+	unsigned long flags;
 	size_t text_len;
 	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
 	int rc = -1;
@@ -664,6 +666,9 @@ static void oops_to_nvram(struct kmsg_du
 	if (clobbering_unread_rtas_event())
 		return;
 
+	if (!spin_trylock_irqsave(&lock, flags))
+		return;
+
 	if (big_oops_buf) {
 		text_len = capture_last_msgs(old_msgs, old_len,
 			new_msgs, new_len, big_oops_buf, big_oops_buf_sz);
@@ -679,4 +684,6 @@ static void oops_to_nvram(struct kmsg_du
 
 	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
 		(int) (sizeof(*oops_len) + *oops_len), err_type, ++oops_count);
+
+	spin_unlock_irqrestore(&lock, flags);
 }
