Return-Path: <gromero@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44BAD1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 03:23:42 +1100 (AEDT)
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Fri, 22 Jan 2016 14:23:37 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 070BF352006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 11:23:27 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0MGOAIO4763856
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 14:24:11 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0MGNVFJ000370
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 14:23:32 -0200
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: [RFC] Fix si->si_code for guard page access on PowerPC
Message-ID: <56A25783.7040502@linux.vnet.ibm.com>
Date: Fri, 22 Jan 2016 14:23:31 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix si->si_code for guard page access on PowerPC

Currently, the mm code on PowerPC/POWER returns a si->si_code = 2
(SEGV_ACCERR) when the stack tries to grow beyond the stack guard
(stack ulimit). On other architectures, notably x86, the si->si_code
returned when a guard page access occurs is 1 (SEGV_MAPERR).

Although si->si_code is not historically reliable and hence no
program should trust it for any semantic behavior, the right
si->si_code for a guard page access is 1 (SEGV_MAPERR) and,
besides that, some tests still trust it in specific cases.

On PowerPC/POWER, if the mm tries to expand the stack and
hits a page mapped by the program (say, an anonymous page
with permission ---p) it generates a SIG_SEGV and a si->si_code = 2
(SEGV_ACCERR), the same way it happens on x86. But then, when this
guard page is removed (un-mapped) and the stack grows again reaching
the stack guard (stack ulimit), the mm generates a SIG_SEGV and a
si->si_code = 2 (SEGV_ACCERR) again, contrary to, for example,
what happens on x86 (si->si_code = 1 (SIG_MAPERR)). It means that
on PowerPC/POWER there is no semantic difference between a stack
growth hitting a mapped area the stack has no permission to rd/wr
and reaching the stack limit (stack ulimit), although indeed there
is a difference.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
  arch/powerpc/mm/fault.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a67c6d7..6954971 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -431,8 +431,10 @@ good_area:
            */
           fault = handle_mm_fault(mm, vma, address, flags);
           if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
-                  if (fault & VM_FAULT_SIGSEGV)
+                  if (fault & VM_FAULT_SIGSEGV) {
+                           code = SEGV_MAPERR;
                             goto bad_area;
+                  }
                    rc = mm_fault_error(regs, address, fault);
                    if (rc >= MM_FAULT_RETURN)
                             goto bail;
