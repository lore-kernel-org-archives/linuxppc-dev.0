Return-Path: <wcohen@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDmxM2LPTzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 04:21:11 +1100 (AEDT)
Subject: Re: gcc trunk fails to build kernel on PowerPC64 due to oprofile
 warnings
To: Robert Richter <rric@kernel.org>
References: <20170126100044.7e439f72@kryten>
 <fe2c2fd9-d255-61ca-5328-ca5d45827f47@redhat.com>
 <20170126160512.GE4906@rric.localdomain>
Cc: Michael Ellerman <mpe@ellerman.id.au>, oprofile-list@lists.sf.net,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: William Cohen <wcohen@redhat.com>
Message-ID: <d37c39a5-01aa-82dd-4e7a-178227025bfe@redhat.com>
Date: Thu, 2 Feb 2017 12:21:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170126160512.GE4906@rric.localdomain>
Content-Type: multipart/mixed; boundary="------------9240D772B256603F117928C1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------9240D772B256603F117928C1
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 01/26/2017 11:06 AM, Robert Richter wrote:
> On 26.01.17 10:46:43, William Cohen wrote:
>> From 7e46dbd7dc5bc941926a4a63c28ccebf46493e8d Mon Sep 17 00:00:00 2001
>> From: William Cohen <wcohen@redhat.com>
>> Date: Thu, 26 Jan 2017 10:33:59 -0500
>> Subject: [PATCH] Avoid hypthetical string truncation in oprofile stats buffer
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> Increased the size of an internal oprofile driver buffer ensuring that
>> the string was never truncated for any possible int value to avoid the
>> following gcc-7 compiler error on ppc when building the kernel:
> 
> Please test gcc7 for other archs first. I don't think this is the only
> change needed to avoid this warning in oprofile code.
> 
> Thanks,
> 
> -Robert
> 

Hi Robert,

I looked through the oprofile arch specific code for other snprintf uses with small character arrays and added those to the patch.  Attached is current patch to increase the size of the buffers to make sure that they will not be truncated.

OProfile since 1.0.0 has used the kernels perf infrastructure rather than the oprofile kernel driver.  OProfile 1.0 was released September 2014, over two years ago.  Would it make sense to deprecate and at some point remove the oprofile driver kernel from the kernel?  Recent Fedora distributions already have CONFIG_OPROFILE unset in the kernel configurations.

-Will


--------------9240D772B256603F117928C1
Content-Type: text/x-patch;
 name="0001-Avoid-hypthetical-string-truncation-in-various-oprof.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-Avoid-hypthetical-string-truncation-in-various-oprof.pa";
 filename*1="tch"

>From e5490da918186cbd42b8609da146946fbdadf0e5 Mon Sep 17 00:00:00 2001
From: William Cohen <wcohen@redhat.com>
Date: Thu, 2 Feb 2017 12:02:51 -0500
Subject: [PATCH] Avoid hypthetical string truncation in various oprofile
 buffers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Increased the size of internal oprofile driver buffers ensuring that
the strings were never truncated for any possible values to avoid
warning/errors like the following GCC 7 compiler error on ppc when
building the kernel:

linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c: In function ‘oprofile_create_stats_files’:
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:25: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Werror=format-truncation=]
   snprintf(buf, 10, "cpu%d", i);
                         ^~
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:21: note: using the range [1, -2147483648] for directive argument
   snprintf(buf, 10, "cpu%d", i);
                     ^~~~~~~
linux/arch/powerpc/oprofile/../../../drivers/oprofile/oprofile_stats.c:55:3: note: format output between 5 and 15 bytes into a destination of size 10
   snprintf(buf, 10, "cpu%d", i);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  LD      crypto/async_tx/built-in.o
  CC      lib/random32.o
cc1: all warnings being treated as errors

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 arch/alpha/oprofile/common.c         | 4 ++--
 arch/avr32/oprofile/op_model_avr32.c | 2 +-
 arch/mips/oprofile/common.c          | 4 ++--
 arch/powerpc/oprofile/common.c       | 4 ++--
 arch/x86/oprofile/nmi_int.c          | 2 +-
 drivers/oprofile/oprofile_perf.c     | 4 ++--
 drivers/oprofile/oprofile_stats.c    | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/alpha/oprofile/common.c b/arch/alpha/oprofile/common.c
index 310a4ce..a1704ee 100644
--- a/arch/alpha/oprofile/common.c
+++ b/arch/alpha/oprofile/common.c
@@ -112,9 +112,9 @@ op_axp_create_files(struct dentry *root)
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry *dir;
-		char buf[4];
+		char buf[32];
 
-		snprintf(buf, sizeof buf, "%d", i);
+		snprintf(buf, sizeof(buf), "%d", i);
 		dir = oprofilefs_mkdir(root, buf);
 
 		oprofilefs_create_ulong(dir, "enabled", &ctr[i].enabled);
diff --git a/arch/avr32/oprofile/op_model_avr32.c b/arch/avr32/oprofile/op_model_avr32.c
index 08308be..af1249b 100644
--- a/arch/avr32/oprofile/op_model_avr32.c
+++ b/arch/avr32/oprofile/op_model_avr32.c
@@ -101,7 +101,7 @@ static int avr32_perf_counter_create_files(struct dentry *root)
 {
 	struct dentry *dir;
 	unsigned int i;
-	char filename[4];
+	char filename[32];
 
 	for (i = 0; i < NR_counter; i++) {
 		snprintf(filename, sizeof(filename), "%u", i);
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 2f33992..20583cd 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -41,9 +41,9 @@ static int op_mips_create_files(struct dentry *root)
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry *dir;
-		char buf[4];
+		char buf[32];
 
-		snprintf(buf, sizeof buf, "%d", i);
+		snprintf(buf, sizeof(buf), "%d", i);
 		dir = oprofilefs_mkdir(root, buf);
 
 		oprofilefs_create_ulong(dir, "enabled", &ctr[i].enabled);
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
index bf094c5..5ac7b88 100644
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -157,9 +157,9 @@ static int op_powerpc_create_files(struct dentry *root)
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry *dir;
-		char buf[4];
+		char buf[32];
 
-		snprintf(buf, sizeof buf, "%d", i);
+		snprintf(buf, sizeof(buf), "%d", i);
 		dir = oprofilefs_mkdir(root, buf);
 
 		oprofilefs_create_ulong(dir, "enabled", &ctr[i].enabled);
diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index ffdbc48..dec2fd0 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -416,7 +416,7 @@ static int nmi_create_files(struct dentry *root)
 
 	for (i = 0; i < model->num_virt_counters; ++i) {
 		struct dentry *dir;
-		char buf[4];
+		char buf[32];
 
 		/* quick little hack to _not_ expose a counter if it is not
 		 * available for use.  This should protect userspace app.
diff --git a/drivers/oprofile/oprofile_perf.c b/drivers/oprofile/oprofile_perf.c
index d5b2732..acc74c4 100644
--- a/drivers/oprofile/oprofile_perf.c
+++ b/drivers/oprofile/oprofile_perf.c
@@ -144,9 +144,9 @@ static int oprofile_perf_create_files(struct dentry *root)
 
 	for (i = 0; i < num_counters; i++) {
 		struct dentry *dir;
-		char buf[4];
+		char buf[32];
 
-		snprintf(buf, sizeof buf, "%d", i);
+		snprintf(buf, sizeof(buf), "%d", i);
 		dir = oprofilefs_mkdir(root, buf);
 		oprofilefs_create_ulong(dir, "enabled", &counter_config[i].enabled);
 		oprofilefs_create_ulong(dir, "event", &counter_config[i].event);
diff --git a/drivers/oprofile/oprofile_stats.c b/drivers/oprofile/oprofile_stats.c
index 59659ce..14d0585 100644
--- a/drivers/oprofile/oprofile_stats.c
+++ b/drivers/oprofile/oprofile_stats.c
@@ -43,7 +43,7 @@ void oprofile_create_stats_files(struct dentry *root)
 	struct oprofile_cpu_buffer *cpu_buf;
 	struct dentry *cpudir;
 	struct dentry *dir;
-	char buf[10];
+	char buf[32];
 	int i;
 
 	dir = oprofilefs_mkdir(root, "stats");
@@ -52,7 +52,7 @@ void oprofile_create_stats_files(struct dentry *root)
 
 	for_each_possible_cpu(i) {
 		cpu_buf = &per_cpu(op_cpu_buffer, i);
-		snprintf(buf, 10, "cpu%d", i);
+		snprintf(buf, sizeof(buf), "cpu%d", i);
 		cpudir = oprofilefs_mkdir(dir, buf);
 
 		/* Strictly speaking access to these ulongs is racy,
-- 
2.9.3


--------------9240D772B256603F117928C1--
