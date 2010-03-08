Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 374B8B7D03
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 08:00:13 +1100 (EST)
Message-ID: <4B956156.8010807@harris.com>
Date: Mon, 08 Mar 2010 15:43:02 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: BUG: Bad page map in process mm2
Content-Type: multipart/mixed; boundary="------------020903020303040201040403"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020903020303040201040403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I've written a simple program to mmap /dev/mem (attached).
It just displays a little physical memory beginning at
address 0.  I wrote this as a test case - I'm trying to
debug a user-space driver, but I wanted to post the
simplest example that illustrates the problem.

This program runs properly on a PPC440EPx, (and on an
Intel desktop), but crashes on a PPC405EX.  Kernel version
on both PPC boards (sequoia and kilauea) is a fairly
vanilla 2.6.30.3.

Has anyone seen anything similar?  If you have a similar
eval board, and you are willing to run the program, I'd be
very interested in your results.  Finally, any suggestions
as to how to debug this would be appreciated!  I'm not sure
yet how to interpret the dump:

BUG: Bad page map in process mm2  pte:00000452 pmd:0f6ba400
78 7c9e2378 7cbdpage:c0396000 flags:00000404 count:1 mapcount:-1 mapping:(null) index:0
2b78 7cdc3378
addr:4801f000 vm_flags:400844fb anon_vma:(null) mapping:ce399430 index:0
00000010: 7cfb3bvma->vm_ops->fault: 0x0
78 480022ad 3c00vma->vm_file->f_op->mmap: mmap_mem+0x0/0xa4
0002 60001032
Call Trace:
00000020: 7c1b03[cf4c5d90] [c0006cf4] show_stack+0x44/0x16ca6 3c00c000 6000 (unreliable)2210 7c1a03a6

00000030: 4c0000[cf4c5dd0] [c0067800] print_bad_pte+0x140/0x1cc64 48000000 0000
0000 00000000
[cf4c5e00] [c0068640] unmap_vmas+0x41c/0x594
[cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150
[cf4c5ea0] [c0020948] mmput+0x50/0xe0
[cf4c5eb0] [c0024504] exit_mm+0xec/0x10c
[cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4
[cf4c5f20] [c0026124] do_group_exit+0x44/0xa4
[cf4c5f30] [c0026198] sys_exit_group+0x14/0x28
[cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c
Disabling lock debugging due to kernel taint
BUG: Bad page state in process mm2  pfn:00000
page:c0396000 flags:00000404 count:0 mapcount:-1 mapping:(null) index:0
Call Trace:
[cf4c5d80] [c0006cf4] show_stack+0x44/0x16c (unreliable)
[cf4c5dc0] [c00585bc] bad_page+0x94/0x12c
[cf4c5de0] [c005d234] put_page+0x4c/0x170
[cf4c5df0] [c0073e54] free_page_and_swap_cache+0x34/0x8c
[cf4c5e00] [c0068490] unmap_vmas+0x26c/0x594
[cf4c5e80] [c006c8f0] exit_mmap+0xb8/0x150
[cf4c5ea0] [c0020948] mmput+0x50/0xe0
[cf4c5eb0] [c0024504] exit_mm+0xec/0x10c
[cf4c5ee0] [c0025bd0] do_exit+0xc4/0x5d4
[cf4c5f20] [c0026124] do_group_exit+0x44/0xa4
[cf4c5f30] [c0026198] sys_exit_group+0x14/0x28
[cf4c5f40] [c000edcc] ret_from_syscall+0x0/0x3c

--------------020903020303040201040403
Content-Type: text/x-csrc;
 name="mm2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm2.c"

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>

#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>

#define MAP_SIZE			4096UL
#define MAP_MASK 			(MAP_SIZE - 1)

#define DEV_MEM				"/dev/mem"

static unsigned long			addr = 0;
static unsigned long			len = 0x10;

int main()
{
    int			ii;
    int			fd;
    unsigned long	paddr = 0;
    unsigned long	offset;
    unsigned long	*map_lbase;

    if(getpagesize() != MAP_SIZE) {
	fprintf(stderr, "Incorrect page size\n");
	exit(1);
    }

    if((fd = open(DEV_MEM, O_RDWR | O_SYNC)) == -1) {
	fprintf(stderr, "cannot open %s - are you root?\n", DEV_MEM);
	exit(1);
    }

    // Calculate the page number, and the offset within the page.
    paddr  = addr & ~MAP_MASK;
    offset = addr &  MAP_MASK;

    // Map that page.
    map_lbase = (unsigned long *)mmap(NULL, MAP_SIZE,
	    PROT_READ | PROT_WRITE, MAP_SHARED, fd, paddr);
    if((long)map_lbase == -1) {
	perror("cannot mmap");
	exit(1);
    }

    // Get a pointer to the offset within the page.
    map_lbase += offset / 4;

    // Dump the requested bytes.
    for(ii = 0; ii < len; ii++) {
	if(ii % 4 == 0) {
	    printf("%08lx: ", addr + (ii * sizeof(unsigned long)));
	}
	printf("%08lx ", map_lbase[ii]);
	if(ii % 4 == 3) {
	    printf("\n");
	}
    }
    if((ii % 4) != 0) {
	printf("\n");
    }

    exit(0);
}

/*
 * Local Variables:
 *   mode: c
 *   tab-width: 8
 *   c-basic-offset: 4
 *   indent-tabs-mode: t
 * End:
 *
 * vim:ts=8:sw=4:sts=4
 */

--------------020903020303040201040403--
