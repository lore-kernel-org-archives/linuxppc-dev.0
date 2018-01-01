Return-Path: <jsperbeck@google.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z95Hc5ZSKzDr51
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jan 2018 16:25:16 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id v30so14363403iov.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Dec 2017 21:25:16 -0800 (PST)
From: John Sperbeck <jsperbeck@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: John Sperbeck <jsperbeck@google.com>
Subject: [PATCH] powerpc/mm: restore SEGV_ACCERR for segv on mapped region
Date: Sun, 31 Dec 2017 21:24:58 -0800
Message-Id: <20180101052458.132027-1-jsperbeck@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A recent refactoring of the powerpc page fault handler caused
access to protected memory regions to indicate SEGV_MAPERR instead
of the traditional SEGV_ACCERR in the si_code field of a user-space
signal handler.  This can confuse debug libraries that temporarily
change the protection of memory regions, and expect to use
SEGV_ACCERR as an indication to restore access to a region.

This change restores the previous behavior.  The following program
exhibits the issue:

    $ ./repro read  || echo "FAILED"
    $ ./repro write || echo "FAILED"
    $ ./repro exec  || echo "FAILED"

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <unistd.h>
    #include <signal.h>
    #include <sys/mman.h>
    #include <assert.h>

    static void segv_handler(int n, siginfo_t *info, void *arg) {
            _exit(info->si_code == SEGV_ACCERR ? 0 : 1);
    }

    int main(int argc, char **argv)
    {
            void *p = NULL;
            struct sigaction act = {
                    .sa_sigaction = segv_handler,
                    .sa_flags = SA_SIGINFO,
            };

            assert(argc == 2);
            p = mmap(NULL, getpagesize(),
                    (strcmp(argv[1], "write") == 0) ? PROT_READ : 0,
                    MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
            assert(p != MAP_FAILED);

            assert(sigaction(SIGSEGV, &act, NULL) == 0);
            if (strcmp(argv[1], "read") == 0)
                    printf("%c", *(unsigned char *)p);
            else if (strcmp(argv[1], "write") == 0)
                    *(unsigned char *)p = 0;
            else if (strcmp(argv[1], "exec") == 0)
                    ((void (*)(void))p)();
            return 1;  /* failed to generate SEGV */
    }

Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 arch/powerpc/mm/fault.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 4797d08581ce..6e1e39035380 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -145,6 +145,11 @@ static noinline int bad_area(struct pt_regs *regs, unsigned long address)
 	return __bad_area(regs, address, SEGV_MAPERR);
 }
 
+static noinline int bad_access(struct pt_regs *regs, unsigned long address)
+{
+	return __bad_area(regs, address, SEGV_ACCERR);
+}
+
 static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     unsigned int fault)
 {
@@ -490,7 +495,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 good_area:
 	if (unlikely(access_error(is_write, is_exec, vma)))
-		return bad_area(regs, address);
+		return bad_access(regs, address);
 
 	/*
 	 * If for any reason at all we couldn't handle the fault,
-- 
2.15.1.620.gb9897f4670-goog
