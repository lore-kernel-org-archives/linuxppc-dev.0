Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C57C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:54:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF35218EA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk5NWedE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF35218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbK52pJLzDqQm
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:54:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fk5NWedE"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTcM18L7zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:36:50 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id h5so7772798pfo.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IfqU4/UXf/Yt5Z3TsJjlHSt1Rz8r3Ba7+ENZjbN6q1Q=;
 b=Fk5NWedEJJ+GlOPXAGsf/q/eNPDZTOiqVtMQnnju8YSZAhD6Y5nhzyTq8Bqek6fG3k
 P9XYZUkkHli5T7irmeb07oJArkxZWNhwv8RlDmbqradPIkagjX1OAarVb2vprcgU41vi
 SqLoF6xbpqf2Bi8tO/seigwq88DXPWl+rQXECNwBpKARu43ZX8ez0K55f5Xo7EvwIzZS
 DBAO0emNG9DXdCBkyn9GrSYv19SB8CKsc4Q5Bgmi7i+F/QUE+lBEJcPzxocCxxiefs31
 XAUPpVGYh7f7MJityqWAu1W6No/DnTi7j8B15tqMezquxc25xdrk6HuzSifrGd6c3yAR
 IX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IfqU4/UXf/Yt5Z3TsJjlHSt1Rz8r3Ba7+ENZjbN6q1Q=;
 b=OXlrJBI2r3okjLbITYOjxmeSiHA5s7sfsgr7pTSrMbuRPWdS25EQrXaMMNyBUQZRbg
 9TolaB0qldqXtz15ibdKGCEqB4gQOHFf7kL0ghS7KV9SF8Cr6JgN+Y9axJXqWLdNXYdF
 tl6DljjJfCdcIryzfPJ8PUnPz/gCAvejfDrcpFpO6TkknHjxRqNj2F1oC0k5/FGsKxjx
 lbj61ucCPckLDiwAubUI5PZgJjx8J6YtjgknDinYv0yUx6ivXtyzCoKiX3+ElS78ABF8
 w7yNOtOk2oav6PM+dxce5bfX4O/wRQG99ylhYnetAtVOL/2DdkX9ApLlPiEv5Q6rWRr2
 WqUQ==
X-Gm-Message-State: APjAAAVt+eiLAQxu41+yM6165olK0UqogYe50aN7PfBfUQwV6ff/ajnm
 tcIRTSmH53xNeOsWZSnM9e8=
X-Google-Smtp-Source: APXvYqww63zu1RyHhbwKdm/CbpTRuIE6aMSQdIsWRtzhQqQ/+oSAMu6R/9sqXI2duoovtaksFcJv+w==
X-Received: by 2002:a63:5020:: with SMTP id e32mr12881217pgb.215.1556037409091; 
 Tue, 23 Apr 2019 09:36:49 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.36.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:36:48 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 39/63] Documentation: x86: convert topology.txt to reST
Date: Wed, 24 Apr 2019 00:29:08 +0800
Message-Id: <20190423162932.21428-40-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:32 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst    |   1 +
 Documentation/x86/topology.rst | 228 +++++++++++++++++++++++++++++++++
 Documentation/x86/topology.txt | 217 -------------------------------
 3 files changed, 229 insertions(+), 217 deletions(-)
 create mode 100644 Documentation/x86/topology.rst
 delete mode 100644 Documentation/x86/topology.txt

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 8f08caf4fbbb..2033791e53bc 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -9,3 +9,4 @@ Linux x86 Support
    :numbered:
 
    boot
+   topology
diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
new file mode 100644
index 000000000000..1df5f56f4882
--- /dev/null
+++ b/Documentation/x86/topology.rst
@@ -0,0 +1,228 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+x86 Topology
+============
+
+This documents and clarifies the main aspects of x86 topology modelling and
+representation in the kernel. Update/change when doing changes to the
+respective code.
+
+The architecture-agnostic topology definitions are in
+Documentation/cputopology.txt. This file holds x86-specific
+differences/specialities which must not necessarily apply to the generic
+definitions. Thus, the way to read up on Linux topology on x86 is to start
+with the generic one and look at this one in parallel for the x86 specifics.
+
+Needless to say, code should use the generic functions - this file is *only*
+here to *document* the inner workings of x86 topology.
+
+Started by Thomas Gleixner <tglx@linutronix.de> and Borislav Petkov <bp@alien8.de>.
+
+The main aim of the topology facilities is to present adequate interfaces to
+code which needs to know/query/use the structure of the running system wrt
+threads, cores, packages, etc.
+
+The kernel does not care about the concept of physical sockets because a
+socket has no relevance to software. It's an electromechanical component. In
+the past a socket always contained a single package (see below), but with the
+advent of Multi Chip Modules (MCM) a socket can hold more than one package. So
+there might be still references to sockets in the code, but they are of
+historical nature and should be cleaned up.
+
+The topology of a system is described in the units of:
+
+    - packages
+    - cores
+    - threads
+
+Package
+=======
+
+Packages contain a number of cores plus shared resources, e.g. DRAM
+controller, shared caches etc.
+
+AMD nomenclature for package is 'Node'.
+
+Package-related topology information in the kernel:
+
+  - cpuinfo_x86.x86_max_cores:
+
+    The number of cores in a package. This information is retrieved via CPUID.
+
+  - cpuinfo_x86.phys_proc_id:
+
+    The physical ID of the package. This information is retrieved via CPUID
+    and deduced from the APIC IDs of the cores in the package.
+
+  - cpuinfo_x86.logical_id:
+
+    The logical ID of the package. As we do not trust BIOSes to enumerate the
+    packages in a consistent way, we introduced the concept of logical package
+    ID so we can sanely calculate the number of maximum possible packages in
+    the system and have the packages enumerated linearly.
+
+  - topology_max_packages():
+
+    The maximum possible number of packages in the system. Helpful for per
+    package facilities to preallocate per package information.
+
+  - cpu_llc_id:
+
+    A per-CPU variable containing:
+
+    - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
+      Cache.
+
+    - On AMD, the Node ID or Core Complex ID containing the Last Level
+      Cache. In general, it is a number identifying an LLC uniquely on the
+      system.
+
+Cores
+=====
+
+A core consists of 1 or more threads. It does not matter whether the threads
+are SMT- or CMT-type threads.
+
+AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
+"core".
+
+Core-related topology information in the kernel:
+
+  - smp_num_siblings:
+
+    The number of threads in a core. The number of threads in a package can be
+    calculated by::
+
+      threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
+
+
+Threads
+=======
+
+A thread is a single scheduling unit. It's the equivalent to a logical Linux
+CPU.
+
+AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
+uses "thread".
+
+Thread-related topology information in the kernel:
+
+  - topology_core_cpumask():
+
+    The cpumask contains all online threads in the package to which a thread
+    belongs.
+
+    The number of online threads is also printed in /proc/cpuinfo "siblings."
+
+  - topology_sibling_cpumask():
+
+    The cpumask contains all online threads in the core to which a thread
+    belongs.
+
+  - topology_logical_package_id():
+
+    The logical package ID to which a thread belongs.
+
+  - topology_physical_package_id():
+
+    The physical package ID to which a thread belongs.
+
+  - topology_core_id();
+
+    The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
+    "core_id."
+
+
+
+System topology examples
+========================
+
+.. note:: The alternative Linux CPU enumeration depends on how the BIOS
+  enumerates the threads. Many BIOSes enumerate all threads 0 first and
+  then all threads 1. That has the "advantage" that the logical Linux CPU
+  numbers of threads 0 stay the same whether threads are enabled or not.
+  That's merely an implementation detail and has no practical impact.
+
+1) Single Package, Single Core
+::
+
+   [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
+
+2) Single Package, Dual Core
+
+  a) One thread per core
+  ::
+
+    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
+          -> [core 1] -> [thread 0] -> Linux CPU 1
+
+  b) Two threads per core
+  ::
+
+    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
+          -> [thread 1] -> Linux CPU 1
+          -> [core 1] -> [thread 0] -> Linux CPU 2
+          -> [thread 1] -> Linux CPU 3
+
+  Alternative enumeration::
+
+    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
+          -> [thread 1] -> Linux CPU 2
+          -> [core 1] -> [thread 0] -> Linux CPU 1
+          -> [thread 1] -> Linux CPU 3
+
+  AMD nomenclature for CMT systems::
+
+    [node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
+              -> [Compute Unit Core 1] -> Linux CPU 1
+      -> [Compute Unit 1] -> [Compute Unit Core 0] -> Linux CPU 2
+              -> [Compute Unit Core 1] -> Linux CPU 3
+
+4) Dual Package, Dual Core
+
+  a) One thread per core
+  ::
+
+    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
+          -> [core 1] -> [thread 0] -> Linux CPU 1
+
+    [package 1] -> [core 0] -> [thread 0] -> Linux CPU 2
+          -> [core 1] -> [thread 0] -> Linux CPU 3
+
+  b) Two threads per core
+  ::
+
+    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
+          -> [thread 1] -> Linux CPU 1
+          -> [core 1] -> [thread 0] -> Linux CPU 2
+          -> [thread 1] -> Linux CPU 3
+
+    [package 1] -> [core 0] -> [thread 0] -> Linux CPU 4
+          -> [thread 1] -> Linux CPU 5
+          -> [core 1] -> [thread 0] -> Linux CPU 6
+          -> [thread 1] -> Linux CPU 7
+
+  Alternative enumeration::
+
+    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
+          -> [thread 1] -> Linux CPU 4
+          -> [core 1] -> [thread 0] -> Linux CPU 1
+          -> [thread 1] -> Linux CPU 5
+
+    [package 1] -> [core 0] -> [thread 0] -> Linux CPU 2
+          -> [thread 1] -> Linux CPU 6
+          -> [core 1] -> [thread 0] -> Linux CPU 3
+          -> [thread 1] -> Linux CPU 7
+
+  AMD nomenclature for CMT systems::
+
+    [node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
+              -> [Compute Unit Core 1] -> Linux CPU 1
+      -> [Compute Unit 1] -> [Compute Unit Core 0] -> Linux CPU 2
+              -> [Compute Unit Core 1] -> Linux CPU 3
+
+    [node 1] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 4
+              -> [Compute Unit Core 1] -> Linux CPU 5
+      -> [Compute Unit 1] -> [Compute Unit Core 0] -> Linux CPU 6
+              -> [Compute Unit Core 1] -> Linux CPU 7
diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
deleted file mode 100644
index 2953e3ec9a02..000000000000
--- a/Documentation/x86/topology.txt
+++ /dev/null
@@ -1,217 +0,0 @@
-x86 Topology
-============
-
-This documents and clarifies the main aspects of x86 topology modelling and
-representation in the kernel. Update/change when doing changes to the
-respective code.
-
-The architecture-agnostic topology definitions are in
-Documentation/cputopology.txt. This file holds x86-specific
-differences/specialities which must not necessarily apply to the generic
-definitions. Thus, the way to read up on Linux topology on x86 is to start
-with the generic one and look at this one in parallel for the x86 specifics.
-
-Needless to say, code should use the generic functions - this file is *only*
-here to *document* the inner workings of x86 topology.
-
-Started by Thomas Gleixner <tglx@linutronix.de> and Borislav Petkov <bp@alien8.de>.
-
-The main aim of the topology facilities is to present adequate interfaces to
-code which needs to know/query/use the structure of the running system wrt
-threads, cores, packages, etc.
-
-The kernel does not care about the concept of physical sockets because a
-socket has no relevance to software. It's an electromechanical component. In
-the past a socket always contained a single package (see below), but with the
-advent of Multi Chip Modules (MCM) a socket can hold more than one package. So
-there might be still references to sockets in the code, but they are of
-historical nature and should be cleaned up.
-
-The topology of a system is described in the units of:
-
-    - packages
-    - cores
-    - threads
-
-* Package:
-
-  Packages contain a number of cores plus shared resources, e.g. DRAM
-  controller, shared caches etc.
-
-  AMD nomenclature for package is 'Node'.
-
-  Package-related topology information in the kernel:
-
-  - cpuinfo_x86.x86_max_cores:
-
-    The number of cores in a package. This information is retrieved via CPUID.
-
-  - cpuinfo_x86.phys_proc_id:
-
-    The physical ID of the package. This information is retrieved via CPUID
-    and deduced from the APIC IDs of the cores in the package.
-
-  - cpuinfo_x86.logical_id:
-
-    The logical ID of the package. As we do not trust BIOSes to enumerate the
-    packages in a consistent way, we introduced the concept of logical package
-    ID so we can sanely calculate the number of maximum possible packages in
-    the system and have the packages enumerated linearly.
-
-  - topology_max_packages():
-
-    The maximum possible number of packages in the system. Helpful for per
-    package facilities to preallocate per package information.
-
-  - cpu_llc_id:
-
-    A per-CPU variable containing:
-    - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
-    Cache
-
-    - On AMD, the Node ID or Core Complex ID containing the Last Level
-    Cache. In general, it is a number identifying an LLC uniquely on the
-    system.
-
-* Cores:
-
-  A core consists of 1 or more threads. It does not matter whether the threads
-  are SMT- or CMT-type threads.
-
-  AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
-  "core".
-
-  Core-related topology information in the kernel:
-
-  - smp_num_siblings:
-
-    The number of threads in a core. The number of threads in a package can be
-    calculated by:
-
-	threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
-
-
-* Threads:
-
-  A thread is a single scheduling unit. It's the equivalent to a logical Linux
-  CPU.
-
-  AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
-  uses "thread".
-
-  Thread-related topology information in the kernel:
-
-  - topology_core_cpumask():
-
-    The cpumask contains all online threads in the package to which a thread
-    belongs.
-
-    The number of online threads is also printed in /proc/cpuinfo "siblings."
-
-  - topology_sibling_cpumask():
-
-    The cpumask contains all online threads in the core to which a thread
-    belongs.
-
-   - topology_logical_package_id():
-
-    The logical package ID to which a thread belongs.
-
-   - topology_physical_package_id():
-
-    The physical package ID to which a thread belongs.
-
-   - topology_core_id();
-
-    The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
-    "core_id."
-
-
-
-System topology examples
-
-Note:
-
-The alternative Linux CPU enumeration depends on how the BIOS enumerates the
-threads. Many BIOSes enumerate all threads 0 first and then all threads 1.
-That has the "advantage" that the logical Linux CPU numbers of threads 0 stay
-the same whether threads are enabled or not. That's merely an implementation
-detail and has no practical impact.
-
-1) Single Package, Single Core
-
-   [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
-
-2) Single Package, Dual Core
-
-   a) One thread per core
-
-	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
-		    -> [core 1] -> [thread 0] -> Linux CPU 1
-
-   b) Two threads per core
-
-	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
-				-> [thread 1] -> Linux CPU 1
-		    -> [core 1] -> [thread 0] -> Linux CPU 2
-				-> [thread 1] -> Linux CPU 3
-
-      Alternative enumeration:
-
-	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
-				-> [thread 1] -> Linux CPU 2
-		    -> [core 1] -> [thread 0] -> Linux CPU 1
-				-> [thread 1] -> Linux CPU 3
-
-      AMD nomenclature for CMT systems:
-
-	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
-				     -> [Compute Unit Core 1] -> Linux CPU 1
-		 -> [Compute Unit 1] -> [Compute Unit Core 0] -> Linux CPU 2
-				     -> [Compute Unit Core 1] -> Linux CPU 3
-
-4) Dual Package, Dual Core
-
-   a) One thread per core
-
-	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
-		    -> [core 1] -> [thread 0] -> Linux CPU 1
-
-	[package 1] -> [core 0] -> [thread 0] -> Linux CPU 2
-		    -> [core 1] -> [thread 0] -> Linux CPU 3
-
-   b) Two threads per core
-
-	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
-				-> [thread 1] -> Linux CPU 1
-		    -> [core 1] -> [thread 0] -> Linux CPU 2
-				-> [thread 1] -> Linux CPU 3
-
-	[package 1] -> [core 0] -> [thread 0] -> Linux CPU 4
-				-> [thread 1] -> Linux CPU 5
-		    -> [core 1] -> [thread 0] -> Linux CPU 6
-				-> [thread 1] -> Linux CPU 7
-
-      Alternative enumeration:
-
-	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
-				-> [thread 1] -> Linux CPU 4
-		    -> [core 1] -> [thread 0] -> Linux CPU 1
-				-> [thread 1] -> Linux CPU 5
-
-	[package 1] -> [core 0] -> [thread 0] -> Linux CPU 2
-				-> [thread 1] -> Linux CPU 6
-		    -> [core 1] -> [thread 0] -> Linux CPU 3
-				-> [thread 1] -> Linux CPU 7
-
-      AMD nomenclature for CMT systems:
-
-	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
-				     -> [Compute Unit Core 1] -> Linux CPU 1
-		 -> [Compute Unit 1] -> [Compute Unit Core 0] -> Linux CPU 2
-				     -> [Compute Unit Core 1] -> Linux CPU 3
-
-	[node 1] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 4
-				     -> [Compute Unit Core 1] -> Linux CPU 5
-		 -> [Compute Unit 1] -> [Compute Unit Core 0] -> Linux CPU 6
-				     -> [Compute Unit Core 1] -> Linux CPU 7
-- 
2.20.1

