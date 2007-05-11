Return-Path: <rientjes@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4887DDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 09:31:13 +1000 (EST)
Date: Fri, 11 May 2007 16:29:29 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] powerpc: use __used attribute
Message-ID: <alpine.DEB.0.99.0705111628430.16028@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the newly introduced __used attribute instead of the deprecated
__attribute_used__.  Functionally the same.

Cc: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/powerpc/boot/Makefile              |    2 +-
 arch/powerpc/kernel/sysfs.c             |    2 +-
 arch/powerpc/oprofile/op_model_power4.c |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -54,7 +54,7 @@ obj-wlib := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-wlib))))
 obj-plat := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-plat))))
 
 quiet_cmd_copy_zlib = COPY    $@
-      cmd_copy_zlib = sed "s@__attribute_used__@@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
+      cmd_copy_zlib = sed "s@__used@@;s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
 
 quiet_cmd_copy_zlibheader = COPY    $@
       cmd_copy_zlibheader = sed "s@<linux/\([^>]\+\).*@\"\1\"@" $< > $@
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -158,7 +158,7 @@ static ssize_t show_##NAME(struct sys_device *dev, char *buf) \
 	unsigned long val = run_on_cpu(cpu->sysdev.id, read_##NAME, 0); \
 	return sprintf(buf, "%lx\n", val); \
 } \
-static ssize_t __attribute_used__ \
+static ssize_t __used \
 	store_##NAME(struct sys_device *dev, const char *buf, size_t count) \
 { \
 	struct cpu *cpu = container_of(dev, struct cpu, sysdev); \
diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
--- a/arch/powerpc/oprofile/op_model_power4.c
+++ b/arch/powerpc/oprofile/op_model_power4.c
@@ -165,15 +165,15 @@ static void power4_stop(void)
 }
 
 /* Fake functions used by canonicalize_pc */
-static void __attribute_used__ hypervisor_bucket(void)
+static void __used hypervisor_bucket(void)
 {
 }
 
-static void __attribute_used__ rtas_bucket(void)
+static void __used rtas_bucket(void)
 {
 }
 
-static void __attribute_used__ kernel_unknown_bucket(void)
+static void __used kernel_unknown_bucket(void)
 {
 }
 
