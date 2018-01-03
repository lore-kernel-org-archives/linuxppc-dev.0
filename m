Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBWfv13PszDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 00:16:55 +1100 (AEDT)
In-Reply-To: <20180101052458.132027-1-jsperbeck@google.com>
To: John Sperbeck <jsperbeck@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: John Sperbeck <jsperbeck@google.com>
Subject: Re: powerpc/mm: restore SEGV_ACCERR for segv on mapped region
Message-Id: <3zBWft73J4z9s81@ozlabs.org>
Date: Thu,  4 Jan 2018 00:16:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-01-01 at 05:24:58 UTC, John Sperbeck wrote:
> A recent refactoring of the powerpc page fault handler caused
> access to protected memory regions to indicate SEGV_MAPERR instead
> of the traditional SEGV_ACCERR in the si_code field of a user-space
> signal handler.  This can confuse debug libraries that temporarily
> change the protection of memory regions, and expect to use
> SEGV_ACCERR as an indication to restore access to a region.
> 
> This change restores the previous behavior.  The following program
> exhibits the issue:
> 
>     $ ./repro read  || echo "FAILED"
>     $ ./repro write || echo "FAILED"
>     $ ./repro exec  || echo "FAILED"
> 
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <string.h>
>     #include <unistd.h>
>     #include <signal.h>
>     #include <sys/mman.h>
>     #include <assert.h>
> 
>     static void segv_handler(int n, siginfo_t *info, void *arg) {
>             _exit(info->si_code == SEGV_ACCERR ? 0 : 1);
>     }
> 
>     int main(int argc, char **argv)
>     {
>             void *p = NULL;
>             struct sigaction act = {
>                     .sa_sigaction = segv_handler,
>                     .sa_flags = SA_SIGINFO,
>             };
> 
>             assert(argc == 2);
>             p = mmap(NULL, getpagesize(),
>                     (strcmp(argv[1], "write") == 0) ? PROT_READ : 0,
>                     MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
>             assert(p != MAP_FAILED);
> 
>             assert(sigaction(SIGSEGV, &act, NULL) == 0);
>             if (strcmp(argv[1], "read") == 0)
>                     printf("%c", *(unsigned char *)p);
>             else if (strcmp(argv[1], "write") == 0)
>                     *(unsigned char *)p = 0;
>             else if (strcmp(argv[1], "exec") == 0)
>                     ((void (*)(void))p)();
>             return 1;  /* failed to generate SEGV */
>     }
> 
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ecb101aed86156ec7cd71e5dca668e

cheers
