Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXsCJ61SdzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 17:28:44 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB66Ow60051684
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 01:28:42 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 275qvjrsyu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 01:28:42 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 6 Dec 2016 16:28:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0E4762BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 17:28:31 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB66SVec34144436
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 17:28:31 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uB66SUb6011712
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Dec 2016 17:28:30 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kernel-hardening@lists.openwall.com,
 keescook@chromium.org, re.emese@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 pageexec@freemail.hu, spender@grsecurity.net, mmarek@suse.com
Subject: [PATCH 3/3] powerpc: enable support for GCC plugins
Date: Tue,  6 Dec 2016 17:28:00 +1100
In-Reply-To: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
References: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
Message-Id: <20161206062800.21800-3-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable support for GCC plugins on powerpc.

Add an additional version check in gcc-plugins-check to advise users to
upgrade to gcc 5.2+ on powerpc to avoid issues with header files (gcc <=
4.6) or missing copies of rs6000-cpus.def (4.8 to 5.1 on 64-bit targets).

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Open to bikeshedding on the gcc version check.

Compile tested with all plugins enabled on gcc 4.6-6.2,
x86->ppc{32,64,64le} and 4.8-6.2 ppc64le->ppc{32,64,64le}. Thanks to
Chris Smart for help with this.

I think it's best to take this through powerpc#next with an ACK from
Kees/Emese?
---
 arch/powerpc/Kconfig         | 1 +
 scripts/Makefile.gcc-plugins | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65fba4c..6efbc08 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -92,6 +92,7 @@ config PPC
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if MPROFILE_KERNEL
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_GCC_PLUGINS
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS if !PPC64
 	select HAVE_IDE
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 26c67b7..9835a75 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -47,6 +47,14 @@ gcc-plugins-check: FORCE
 ifdef CONFIG_GCC_PLUGINS
   ifeq ($(PLUGINCC),)
     ifneq ($(GCC_PLUGINS_CFLAGS),)
+      # Various gccs between 4.5 and 5.1 have bugs on powerpc due to missing
+      # header files. gcc <= 4.6 doesn't work at all, gccs from 4.8 to 5.1 have
+      # issues with 64-bit targets.
+      ifeq ($(ARCH),powerpc)
+        ifeq ($(call cc-ifversion, -le, 0501, y), y)
+	  @echo "Cannot use CONFIG_GCC_PLUGINS: plugin support on gcc <= 5.1 is buggy on powerpc, please upgrade to gcc 5.2 or newer" >&2 && exit 1
+        endif
+      endif
       ifeq ($(call cc-ifversion, -ge, 0405, y), y)
 	$(Q)$(srctree)/scripts/gcc-plugin.sh --show-error "$(__PLUGINCC)" "$(HOSTCXX)" "$(CC)" || true
 	@echo "Cannot use CONFIG_GCC_PLUGINS: your gcc installation does not support plugins, perhaps the necessary headers are missing?" >&2 && exit 1
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
