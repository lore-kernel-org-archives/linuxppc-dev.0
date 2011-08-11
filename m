Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH part1 v2 6/9] ps3: Detect the current lpar
Date: Thu, 11 Aug 2011 21:31:10 +0200
Message-Id: <1313091073-4572-7-git-send-email-a.heider@gmail.com>
In-Reply-To: <1313091073-4572-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
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

Detect it by reading the ss laid repository node, and make it
accessible via ps3_get_ss_laid().

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/powerpc/include/asm/ps3.h          |    6 ++++++
 arch/powerpc/platforms/ps3/platform.h   |    4 ++++
 arch/powerpc/platforms/ps3/repository.c |   19 +++++++++++++++++++
 arch/powerpc/platforms/ps3/setup.c      |    9 +++++++++
 4 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index 7f065e1..9e8c878 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -39,6 +39,12 @@ union ps3_firmware_version {
 void ps3_get_firmware_version(union ps3_firmware_version *v);
 int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev);
 
+enum ps3_ss_laid {
+	PS3_SS_LAID_OTHEROS = 0x1080000004000001UL,
+};
+
+enum ps3_ss_laid ps3_get_ss_laid(void);
+
 /* 'Other OS' area */
 
 enum ps3_param_av_multi_out {
diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index d9b4ec0..b912d15 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -235,4 +235,8 @@ int ps3_repository_read_spu_resource_id(unsigned int res_index,
 int ps3_repository_read_vuart_av_port(unsigned int *port);
 int ps3_repository_read_vuart_sysmgr_port(unsigned int *port);
 
+/* repository ss info */
+
+int ps3_repository_read_ss_laid(enum ps3_ss_laid *laid);
+
 #endif
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 9908d61..06f8801 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -1038,6 +1038,25 @@ int ps3_repository_read_lpm_privileges(unsigned int be_index, u64 *lpar,
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
index 149bea2..9f23a6d 100644
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
@@ -200,6 +207,8 @@ static void __init ps3_setup_arch(void)
 	       ps3_firmware_version.major, ps3_firmware_version.minor,
 	       ps3_firmware_version.rev);
 
+	ps3_repository_read_ss_laid(&ps3_ss_laid);
+
 	ps3_spu_set_platform();
 
 #ifdef CONFIG_SMP
-- 
1.7.5.4
