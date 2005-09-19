Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2005 23:15:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050919231551.2e13b6d8.sfr@canb.auug.org.au>
In-Reply-To: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
References: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/6] Merge arch/ppc*/oprofile/Makefile into
 arch/powerpc/oprofile
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/oprofile/Makefile |   11 +++++++++++
 arch/ppc/oprofile/Makefile     |   15 +--------------
 arch/ppc64/oprofile/Makefile   |   10 +---------
 3 files changed, 13 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/oprofile/Makefile

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

03447d2b4ddb0a51f7316c32c280dbc497ce8d83
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/oprofile/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_OPROFILE) += oprofile.o
+
+DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
+		oprof.o cpu_buffer.o buffer_sync.o \
+		event_buffer.o oprofile_files.o \
+		oprofilefs.o oprofile_stats.o \
+		timer_int.o )
+
+oprofile-y := $(DRIVER_OBJS) common.o
+oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
+oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
diff --git a/arch/ppc/oprofile/Makefile b/arch/ppc/oprofile/Makefile
--- a/arch/ppc/oprofile/Makefile
+++ b/arch/ppc/oprofile/Makefile
@@ -1,14 +1 @@
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y := $(DRIVER_OBJS) common.o
-
-ifeq ($(CONFIG_FSL_BOOKE),y)
-	oprofile-y += op_model_fsl_booke.o
-endif
-
+include arch/powerpc/oprofile/Makefile
diff --git a/arch/ppc64/oprofile/Makefile b/arch/ppc64/oprofile/Makefile
--- a/arch/ppc64/oprofile/Makefile
+++ b/arch/ppc64/oprofile/Makefile
@@ -1,9 +1 @@
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y := $(DRIVER_OBJS) common.o op_model_rs64.o op_model_power4.o
+include arch/powerpc/oprofile/Makefile
