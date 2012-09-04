Return-Path: <anton@samba.org>
Date: Tue, 4 Sep 2012 12:47:56 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/4] powerpc: Update DSCR on all CPUs when writing sysfs
 dscr_default
Message-ID: <20120904124756.4ddeb535@kryten>
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


Writing to dscr_default in sysfs doesn't actually change the DSCR -
we rely on a context switch on each CPU to do the work. There is no
guarantee we will get a context switch in a reasonable amount of time
so fire off an IPI to force an immediate change.

This issue was found with the following test case:

http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c

Signed-off-by: Anton Blanchard <anton@samba.org>  
Cc: <stable@kernel.org> # 3.0+
---

Index: b/arch/powerpc/kernel/sysfs.c
===================================================================
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -194,6 +194,12 @@ static ssize_t show_dscr_default(struct
 	return sprintf(buf, "%lx\n", dscr_default);
 }
 
+static void update_dscr(void *dummy)
+{
+	if (!current->thread.dscr_inherit)
+		mtspr(SPRN_DSCR, dscr_default);
+}
+
 static ssize_t __used store_dscr_default(struct device *dev,
 		struct device_attribute *attr, const char *buf,
 		size_t count)
@@ -206,6 +212,8 @@ static ssize_t __used store_dscr_default
 		return -EINVAL;
 	dscr_default = val;
 
+	on_each_cpu(update_dscr, NULL, 1);
+
 	return count;
 }
 
