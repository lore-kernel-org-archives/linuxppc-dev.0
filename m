Return-Path: <satyakiran@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by ozlabs.org (Postfix) with ESMTP id C4278DDEA2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 04:38:44 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i21so666056wra
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 11:38:41 -0700 (PDT)
Message-ID: <acbcf3840707101138t24597799s6511f9326ed2243e@mail.gmail.com>
Date: Tue, 10 Jul 2007 13:38:41 -0500
From: Satya <satyakiran@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: hugetlbfs for ppc440 - kernel BUG
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kazutomo@mcs.anl.gov, edi@linux.vnet.ibm.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hello,
I am trying to implement hugetlbfs on the IBM Bluegene/L IO node
(ppc440) and I have a big problem as well as a few questions to ask
the group. I patched a 2.6.21.6 linux kernel (manually) with Edi
Shmueli's hugetlbfs implementation (found here:
http://patchwork.ozlabs.org/linuxppc/patch?id=8427) for this. I did
have to make slight changes (described at the end) to make it work.
My test program is a shortened version of a sys v shared memory
example described in Documentation/vm/hugetlbpage.txt

I get the following kernel BUG when a page fault occurs on a huge page address:
BUG: scheduling while atomic: shmtest2/0x10000001/1291
Call Trace:
[CFF0BCE0] [C00084F4] show_stack+0x4c/0x194 (unreliable)
 [CFF0BD20] [C01A53C4] schedule+0x664/0x668
[CFF0BD60] [C00175F8] __cond_resched+0x24/0x50
[CFF0BD80] [C01A5A6C] cond_resched+0x50/0x58
[CFF0BD90] [C005A31C] clear_huge_page+0x28/0x174
[CFF0BDC0] [C005B360] hugetlb_no_page+0xb4/0x220
[CFF0BE00] [C005B5BC] hugetlb_fault+0xf0/0xf4
[CFF0BE30] [C0052AC0] __handle_mm_fault+0x3a8/0x3ac
[CFF0BE70] [C00094A0] do_page_fault+0x118/0x428
[CFF0BF40] [C0002360] handle_page_fault+0xc/0x80
BUG: scheduling while atomic: shmtest2/0x10000001/1291

Now for my questions:

1. Can the kernel really reschedule in a page fault handler context ?

2. Just to test where this "scheduling while atomic" bug is arising, i
put schedule() calls at various places in the path of the stack trace
shown above.
I found that a call to pte_alloc_map() puts the kernel in a context
where it cannot reschedule without throwing up. Here is a trace of
what's going on:

__handle_mm_fault -> hugetlb_fault -> huge_pte_alloc() -> pte_alloc_map()

Any call to schedule() before pte_alloc_map() does not throw this
error. Well, this might be a flawed experiment, I am no expert kernel
hacker. Does this throw any light on the problem?

Here are the modifications I made to Edi's patch:

arch/ppc/mm/hugetlbpage.c
struct page *
follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
{
  pte_t *pte;
  struct page *page;
+  struct vm_area_struct *vma;
+
+  vma = find_vma(mm, address);
+ if (!vma || !is_vm_hugetlb_page(vma))
+    return ERR_PTR(-EINVAL);

  pte = huge_pte_offset(mm, address);
  page = pte_page(*pte);
  return page;
}

+int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
+{
+        return 0;
+}

Here is my test program:

#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/mman.h>

#ifndef SHM_HUGETLB
#define SHM_HUGETLB 04000
#endif

#define LENGTH (16UL*1024*1024)

#define dprintf(x)  printf(x)

#define ADDR (void *)(0x0UL)
#define SHMAT_FLAGS (0)


int main(void)
{
        int shmid;
        unsigned long i;
        char *shmaddr;

        if ((shmid = shmget(2, LENGTH,
                            SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W)) < 0) {
                perror("shmget");
                exit(1);
        }
        printf("shmid: 0x%x\n", shmid);

        shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
        if (shmaddr == (char *)-1) {
                perror("Shared memory attach failure");
                shmctl(shmid, IPC_RMID, NULL);
                exit(2);
        }
        printf("shmaddr: %p\n", shmaddr);
        printf("touching a huge page..\n");

        shmaddr[0]='a';
        shmaddr[1]='b';

        if (shmdt((const void *)shmaddr) != 0) {
                perror("Detach failure");
                shmctl(shmid, IPC_RMID, NULL);
                exit(3);
        }

        shmctl(shmid, IPC_RMID, NULL);

        return 0;
}

thanks!
Satya.
