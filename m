Return-Path: <ananth@in.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407FF1A07F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 20:57:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 16 Jul 2015 20:57:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 857342CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 20:57:30 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6GAvJUL55443538
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 20:57:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6GAuv1n005245
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 20:56:58 +1000
Subject: [PATCH] kprobes: Mark OPTPROBES n/a for powerpc
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: masami.hiramatsu.pt@hitachi.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 16 Jul 2015 16:26:39 +0530
Message-ID: <20150716105639.9151.75671.stgit@thinktux.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kprobes uses a breakpoint instruction to trap into execution flow
and the probed instruction is single-stepped from an alternate location.

On some architectures like x86, under certain conditions, the OPTPROBES
feature enables replacing the probed instruction with a jump instead,
resulting in a significant perfomance boost (one single-step exception
is bypassed for each kprobe).

Powerpc has an in-kernel instruction emulator. Kprobes on powerpc uses
this emulator already and bypasses the single-step exception, with a
lot less complexity.

Hence, mark OPTPROBES n/a for powerpc.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
---
 .../features/debug/optprobes/arch-support.txt      |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index b8999d8..0a3ca33 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -27,7 +27,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: | n/a  |
     |        s390: | TODO |
     |       score: | TODO |
     |          sh: | TODO |
