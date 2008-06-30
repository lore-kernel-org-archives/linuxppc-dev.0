Return-Path: <emunson@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 812D5DDF2E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:13:54 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5UGDgc2019954
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 12:13:42 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5UGCQIu196906
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 12:12:26 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5UGCKUp027756
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 12:12:20 -0400
From: Eric Munson <ebmunson@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V3] Keep 3 high personality bytes across exec
Date: Mon, 30 Jun 2008 09:12:13 -0700
Message-Id: <1214842333-21428-1-git-send-email-ebmunson@us.ibm.com>
In-Reply-To: <20080628000813.GA19960@us.ibm.com>
References: <20080628000813.GA19960@us.ibm.com>
Cc: Eric Munson <ebmunson@us.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently when a 32 bit process is exec'd on a powerpc 64 bit host the value
in the top three bytes of the personality is clobbered.  This patch adds a
check in the SET_PERSONALITY macro that will carry all the values in the top
three bytes across the exec.

These three bytes currently carry flags to disable address randomisation,
limit the address space, force zeroing of an mmapped page, etc.  Should an
application set any of these bits they will be maintained and honoured on
homogeneous environment but discarded and ignored on a heterogeneous
environment.  So if an application requires all mmapped pages to be initialised
to zero and a wrapper is used to setup the personality and exec the target,
these flags will remain set on an all 32 or all 64 bit envrionment, but they
will be lost in the exec on a mixed 32/64 bit environment.  Losing these bits
means that the same application would behave differently in different
environments.  Tested on a POWER5+ machine with 64bit kernel and a mixed
64/32 bit user space.

Signed-off-by: Eric B Munson <ebmunson@us.ibm.com>
---
V3
Based on 2.6.26-rc8

Changes from V2:
Use ~PER_MASK instead of PER_INHERIT
Remove PER_INHERIT
Rebase to 2.6.26-rc8

Changes from V1:
Updated changelog with a better description of why this change is useful

 include/asm-powerpc/elf.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index 9080d85..5eee73e 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -257,7 +257,8 @@ do {								\
 	else							\
 		clear_thread_flag(TIF_ABI_PENDING);		\
 	if (personality(current->personality) != PER_LINUX32)	\
-		set_personality(PER_LINUX);			\
+		set_personality(PER_LINUX |			\
+			(current->personality & (~PER_MASK)));	\
 } while (0)
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
-- 
1.5.6.1
