Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 05/15] ps3: Detect the current lpar environment
Date: Mon,  1 Aug 2011 22:02:56 +0200
Message-Id: <1312228986-32307-6-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is more than the OtherOS lpar the kernel can be launched in.
Detect it by reading the ss laid repository node, and be verbose about
it.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/include/asm/ps3.h          |    7 +++++++
 arch/powerpc/platforms/ps3/platform.h   |    4 ++++
 arch/powerpc/platforms/ps3/repository.c |   19 +++++++++++++++++++
 arch/powerpc/platforms/ps3/setup.c      |   22 ++++++++++++++++++++++
 4 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index 7f065e1..136354a 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -39,6 +39,13 @@ union ps3_firmware_version {
 void ps3_get_firmware_version(union ps3_firmware_version *v);
 int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev);
 
+enum ps3_ss_laid {
+	PS3_SS_LAID_GAMEOS = 0x1070000002000001UL,
+	PS3_SS_LAID_OTHEROS = 0x1080000004000001UL,
+};
+
+enum ps3_ss_laid ps3_get_ss_laid(void);
+
 /* 'Other OS' area */
 
 enum ps3_param_av_multi_out {
diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index 9a196a8..1ba15b8 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -232,4 +232,8 @@ int ps3_repository_read_spu_resource_id(unsigned int res_index,
 int ps3_repository_read_vuart_av_port(unsigned int *port);
 int ps3_repository_read_vuart_sysmgr_port(unsigned int *port);
 
+/* repository ss info */
+
+int ps3_repository_read_ss_laid(enum ps3_ss_laid *laid);
+
 #endif
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 5e304c2..6fa3e96 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -1002,6 +1002,25 @@ int ps3_repository_read_lpm_privileges(unsigned int be_index, u64 *lpar,
 			    lpar, rights);
 }
 
+/**
+ * ps3_repository_read_ss_laid - Read the lpar auth id
+ */
+
+int ps3_repository_read_ss_laid(enum ps3_ss_laid *laid)
+{
+	int result;
+	u64 id, v1;
+
+	lv1_get_logical_partition_id(&id);
+	result = read_node(PS3_LPAR_ID_PME,
+			   make_first_field("ss", 0),
+			   make_field("laid", 0),
+			   id, 0,
+			   &v1, NULL);
+	*laid = v1;
+	return result;
+}
+
 #if defined(DEBUG)
 
 int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 149bea2..f430279 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -47,6 +47,7 @@ DEFINE_MUTEX(ps3_gpu_mutex);
 EXPORT_SYMBOL_GPL(ps3_gpu_mutex);
 
 static union ps3_firmware_version ps3_firmware_version;
+static enum ps3_ss_laid ps3_ss_laid;
 
 void ps3_get_firmware_version(union ps3_firmware_version *v)
 {
@@ -68,6 +69,12 @@ int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev)
 }
 EXPORT_SYMBOL_GPL(ps3_compare_firmware_version);
 
+enum ps3_ss_laid ps3_get_ss_laid(void)
+{
+	return ps3_ss_laid;
+}
+EXPORT_SYMBOL_GPL(ps3_get_ss_laid);
+
 static void ps3_power_save(void)
 {
 	/*
@@ -192,6 +199,7 @@ static int ps3_set_dabr(unsigned long dabr)
 
 static void __init ps3_setup_arch(void)
 {
+	const char *laid_str;
 
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
@@ -200,6 +208,20 @@ static void __init ps3_setup_arch(void)
 	       ps3_firmware_version.major, ps3_firmware_version.minor,
 	       ps3_firmware_version.rev);
 
+	ps3_repository_read_ss_laid(&ps3_ss_laid);
+	switch (ps3_ss_laid) {
+	case PS3_SS_LAID_GAMEOS:
+		laid_str = "GameOS";
+		break;
+	case PS3_SS_LAID_OTHEROS:
+		laid_str = "OtherOS";
+		break;
+	default:
+		laid_str = "unknown";
+		break;
+	}
+	printk(KERN_INFO "Running in %s lpar\n", laid_str);
+
 	ps3_spu_set_platform();
 
 #ifdef CONFIG_SMP
-- 
1.7.5.4
