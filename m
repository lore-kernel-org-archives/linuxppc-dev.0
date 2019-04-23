Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F2BC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:09:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EB1218D2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 21:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cow/C3D8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EB1218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pbgK6J09zDqQF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 07:09:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cow/C3D8"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTdy2Z4xzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:38:12 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id w26so945172pfj.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u1tp2ELIbvCM7I/PHHScr2H+N6Dz10Lsm+qX631gMBk=;
 b=cow/C3D817oiNWouFzWxIllbVUrXMcMbVCfcDieChyuQeH1FIg9ck/oHw/+sG1uL0o
 f23g2RnlRa8vGmX5ORzzZT2/bVNROALrALrjg8r9lpPkvD7wNbCHjD5BjNI9lpairu3u
 nJJUVMTTFCIOZHdL6pkUWdanXHyQxSGO7Kh2fgrZSUH96BqZrZlZHxgk4hmWEhjDCnju
 zHeEHiYc9DVThusO3The4J0wcd+PTE04C0kUd3YpxI1pRI8+fkykurKfp4GL4ZrsSOp5
 apc3gGMeJgCyQPKSYUwRm40rS/KPLsU7hjXjbYr2No17M+WhiAJGE6x4oj21DjnqweAp
 zPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u1tp2ELIbvCM7I/PHHScr2H+N6Dz10Lsm+qX631gMBk=;
 b=UQ+mHfhZn5zqR0jsHfpXVbfO3lo3oxxWWxkVdnU6tNciqgilwWbtO4OVNtKpZUKiMf
 hXcHbYGwjphBGcJvSikH7WKjVCHw423+9wSTvwA+EfIYrQVAcX97YwLssJEfNbXD7nxl
 8huPiDQsZl30SIqlJyKhE8Hzd0dEPRLcHW/mQwYm2qglZGRVDLYfAJeWRaJ8r/y5zFc7
 vu+69ZYUKb1DRA3US9mbLtYsK1KFjjNTf2cSDtAA+FUSf2B7afQE1+aIaMJ87Q2dfvar
 fmNeIJk4d+IaaiakmCflKK9JUZKzXtILfcQ+blPReqgkVcDOTkchBJm060Hc6MWLgK9K
 VLGw==
X-Gm-Message-State: APjAAAX+lEVxxRPNwmSu+gf8GeUW5PyvpnxxEFFldcVS0wXb0BR5EoKa
 m8G2qCDdTP6yWsnIzbsytHP3GvN8
X-Google-Smtp-Source: APXvYqz5NAdF8yYD4rHwGYu+nptnedBDxc2lz+4bMD6kNlv8bWIQc5GpIl4RQMF2292u1cBWLLkO+A==
X-Received: by 2002:a63:c605:: with SMTP id w5mr24993062pgg.355.1556037489920; 
 Tue, 23 Apr 2019 09:38:09 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.38.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:38:09 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 49/63] Documentation: x86: convert intel_mpx.txt to reST
Date: Wed, 24 Apr 2019 00:29:18 +0800
Message-Id: <20190423162932.21428-50-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:33 +1000
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
 Documentation/x86/index.rst                   |   1 +
 .../x86/{intel_mpx.txt => intel_mpx.rst}      | 120 ++++++++++--------
 2 files changed, 65 insertions(+), 56 deletions(-)
 rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 576628b121cc..20091d3e5d97 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,3 +19,4 @@ Linux x86 Support
    mtrr
    pat
    protection-keys
+   intel_mpx
diff --git a/Documentation/x86/intel_mpx.txt b/Documentation/x86/intel_mpx.rst
similarity index 75%
rename from Documentation/x86/intel_mpx.txt
rename to Documentation/x86/intel_mpx.rst
index 85d0549ad846..387a640941a6 100644
--- a/Documentation/x86/intel_mpx.txt
+++ b/Documentation/x86/intel_mpx.rst
@@ -1,5 +1,11 @@
-1. Intel(R) MPX Overview
-========================
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+Intel(R) Memory Protection Extensions (MPX)
+===========================================
+
+Intel(R) MPX Overview
+=====================
 
 Intel(R) Memory Protection Extensions (Intel(R) MPX) is a new capability
 introduced into Intel Architecture. Intel MPX provides hardware features
@@ -7,7 +13,7 @@ that can be used in conjunction with compiler changes to check memory
 references, for those references whose compile-time normal intentions are
 usurped at runtime due to buffer overflow or underflow.
 
-You can tell if your CPU supports MPX by looking in /proc/cpuinfo:
+You can tell if your CPU supports MPX by looking in /proc/cpuinfo::
 
 	cat /proc/cpuinfo  | grep ' mpx '
 
@@ -21,8 +27,8 @@ can be downloaded from
 http://software.intel.com/en-us/articles/intel-software-development-emulator
 
 
-2. How to get the advantage of MPX
-==================================
+How to get the advantage of MPX
+===============================
 
 For MPX to work, changes are required in the kernel, binutils and compiler.
 No source changes are required for applications, just a recompile.
@@ -84,14 +90,15 @@ Kernel MPX Code:
    is unmapped.
 
 
-3. How does MPX kernel code work
-================================
+How does MPX kernel code work
+=============================
 
 Handling #BR faults caused by MPX
 ---------------------------------
 
 When MPX is enabled, there are 2 new situations that can generate
 #BR faults.
+
   * new bounds tables (BT) need to be allocated to save bounds.
   * bounds violation caused by MPX instructions.
 
@@ -124,37 +131,37 @@ the kernel. It can theoretically be done completely from userspace. Here
 are a few ways this could be done. We don't think any of them are practical
 in the real-world, but here they are.
 
-Q: Can virtual space simply be reserved for the bounds tables so that we
-   never have to allocate them?
-A: MPX-enabled application will possibly create a lot of bounds tables in
-   process address space to save bounds information. These tables can take
-   up huge swaths of memory (as much as 80% of the memory on the system)
-   even if we clean them up aggressively. In the worst-case scenario, the
-   tables can be 4x the size of the data structure being tracked. IOW, a
-   1-page structure can require 4 bounds-table pages. An X-GB virtual
-   area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
-   If we were to preallocate them for the 128TB of user virtual address
-   space, we would need to reserve 512TB+2GB, which is larger than the
-   entire virtual address space today. This means they can not be reserved
-   ahead of time. Also, a single process's pre-populated bounds directory
-   consumes 2GB of virtual *AND* physical memory. IOW, it's completely
-   infeasible to prepopulate bounds directories.
-
-Q: Can we preallocate bounds table space at the same time memory is
-   allocated which might contain pointers that might eventually need
-   bounds tables?
-A: This would work if we could hook the site of each and every memory
-   allocation syscall. This can be done for small, constrained applications.
-   But, it isn't practical at a larger scale since a given app has no
-   way of controlling how all the parts of the app might allocate memory
-   (think libraries). The kernel is really the only place to intercept
-   these calls.
-
-Q: Could a bounds fault be handed to userspace and the tables allocated
-   there in a signal handler instead of in the kernel?
-A: mmap() is not on the list of safe async handler functions and even
-   if mmap() would work it still requires locking or nasty tricks to
-   keep track of the allocation state there.
+:Q: Can virtual space simply be reserved for the bounds tables so that we
+    never have to allocate them?
+:A: MPX-enabled application will possibly create a lot of bounds tables in
+    process address space to save bounds information. These tables can take
+    up huge swaths of memory (as much as 80% of the memory on the system)
+    even if we clean them up aggressively. In the worst-case scenario, the
+    tables can be 4x the size of the data structure being tracked. IOW, a
+    1-page structure can require 4 bounds-table pages. An X-GB virtual
+    area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
+    If we were to preallocate them for the 128TB of user virtual address
+    space, we would need to reserve 512TB+2GB, which is larger than the
+    entire virtual address space today. This means they can not be reserved
+    ahead of time. Also, a single process's pre-populated bounds directory
+    consumes 2GB of virtual *AND* physical memory. IOW, it's completely
+    infeasible to prepopulate bounds directories.
+
+:Q: Can we preallocate bounds table space at the same time memory is
+    allocated which might contain pointers that might eventually need
+    bounds tables?
+:A: This would work if we could hook the site of each and every memory
+    allocation syscall. This can be done for small, constrained applications.
+    But, it isn't practical at a larger scale since a given app has no
+    way of controlling how all the parts of the app might allocate memory
+    (think libraries). The kernel is really the only place to intercept
+    these calls.
+
+:Q: Could a bounds fault be handed to userspace and the tables allocated
+    there in a signal handler instead of in the kernel?
+:A: mmap() is not on the list of safe async handler functions and even
+    if mmap() would work it still requires locking or nasty tricks to
+    keep track of the allocation state there.
 
 Having ruled out all of the userspace-only approaches for managing
 bounds tables that we could think of, we create them on demand in
@@ -167,20 +174,20 @@ If a #BR is generated due to a bounds violation caused by MPX.
 We need to decode MPX instructions to get violation address and
 set this address into extended struct siginfo.
 
-The _sigfault field of struct siginfo is extended as follow:
-
-87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-88		struct {
-89			void __user *_addr; /* faulting insn/memory ref. */
-90 #ifdef __ARCH_SI_TRAPNO
-91			int _trapno;	/* TRAP # which caused the signal */
-92 #endif
-93			short _addr_lsb; /* LSB of the reported address */
-94			struct {
-95				void __user *_lower;
-96				void __user *_upper;
-97			} _addr_bnd;
-98		} _sigfault;
+The _sigfault field of struct siginfo is extended as follow::
+
+  87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+  88		struct {
+  89			void __user *_addr; /* faulting insn/memory ref. */
+  90 #ifdef __ARCH_SI_TRAPNO
+  91			int _trapno;	/* TRAP # which caused the signal */
+  92 #endif
+  93			short _addr_lsb; /* LSB of the reported address */
+  94			struct {
+  95				void __user *_lower;
+  96				void __user *_upper;
+  97			} _addr_bnd;
+  98		} _sigfault;
 
 The '_addr' field refers to violation address, and new '_addr_and'
 field refers to the upper/lower bounds when a #BR is caused.
@@ -209,9 +216,10 @@ Adding new prctl commands
 
 Two new prctl commands are added to enable and disable MPX bounds tables
 management in kernel.
+::
 
-155	#define PR_MPX_ENABLE_MANAGEMENT	43
-156	#define PR_MPX_DISABLE_MANAGEMENT	44
+  155	#define PR_MPX_ENABLE_MANAGEMENT	43
+  156	#define PR_MPX_DISABLE_MANAGEMENT	44
 
 Runtime library in userspace is responsible for allocation of bounds
 directory. So kernel have to use XSAVE instruction to get the base
@@ -223,8 +231,8 @@ into struct mm_struct to be used in future during PR_MPX_ENABLE_MANAGEMENT
 command execution.
 
 
-4. Special rules
-================
+Special rules
+=============
 
 1) If userspace is requesting help from the kernel to do the management
 of bounds tables, it may not create or modify entries in the bounds directory.
-- 
2.20.1

