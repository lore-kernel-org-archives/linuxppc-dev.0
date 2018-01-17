Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM4Cf13ZCzF0bw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 22:11:25 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc/mm: Fix growth direction for hugepages mmaps
 with slice
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180109101810.2471D6C6CF@localhost.localdomain>
 <87wp0haizf.fsf@linux.vnet.ibm.com>
 <d5f6060f-3061-dc3c-66f7-3cec05d50169@c-s.fr>
 <f5f2af23-f535-8fca-4edf-a0ec4107a7df@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <dd2e281e-0dea-8acf-30dc-b85d0d438cf3@c-s.fr>
Date: Wed, 17 Jan 2018 12:11:16 +0100
MIME-Version: 1.0
In-Reply-To: <f5f2af23-f535-8fca-4edf-a0ec4107a7df@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 17/01/2018 à 04:19, Aneesh Kumar K.V a écrit :
> 
> 
> On 01/16/2018 10:18 PM, Christophe LEROY wrote:
>>
>>
>> Le 16/01/2018 à 17:03, Aneesh Kumar K.V a écrit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> An application running with libhugetlbfs fails to allocate
>>>> additional pages to HEAP due to the hugemap being done
>>>> inconditionally as topdown mapping:
>>>>
>>>> mmap(0x10080000, 1572864, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0) = 0x73e80000
>>>> [...]
>>>> mmap(0x74000000, 1048576, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d80000
>>>> munmap(0x73d80000, 1048576)             = 0
>>>> [...]
>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>>> munmap(0x73d00000, 1572864)             = 0
>>>> [...]
>>>> mmap(0x74000000, 1572864, PROT_READ|PROT_WRITE, 
>>>> MAP_PRIVATE|MAP_ANONYMOUS|0x40000, -1, 0x180000) = 0x73d00000
>>>> munmap(0x73d00000, 1572864)             = 0
>>>> [...]
>>>>
>>>
>>> Can you explain the failure details above. I am not sure I understand
>>> what to read from the above output.
>>
>> libhugetlbfs first requests an area of size 1.5Mbytes, at address 
>> 0x10080000
>> mmap() returns an area at address 0x73e80000
>>
>> Then libhugetlbfs requests an additional area on top of that, ie at 
>> address 0x74000000, to expand the heap.
>> But mmap() returns an area at address 0x73d80000, ie under the 
>> previous area.
>>
> 
> 
> Can you share the test details?. Why does it not fail on book3s64? We 
> use topdown search with book3s64.

I don't know about book3s64, I only have 8xx.

Here is my test app:


#include <sys/mman.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main()
{
	char *p;
	char buf[16384];
	char filename[32];
	int fd, r;
	
	sprintf(filename, "/proc/%d/maps", getpid());

	fd = open(filename, O_RDONLY);
	r = read(fd, buf, sizeof(buf));
	close(fd);
	buf[r] = 0;
	fputs(buf, stderr);
	fputc('\n', stderr);
	
	p = malloc(1024*1024);
	fprintf(stderr, "\nAllocated 1Mbytes at %p\n\n", p);

	p = malloc(1024*1024);
	fprintf(stderr, "\nAllocated 1Mbytes at %p\n\n", p);

	p = malloc(1024*1024);
	fprintf(stderr, "\nAllocated 1Mbytes at %p\n\n", p);

	fd = open(filename, O_RDONLY);
	r = read(fd, buf, sizeof(buf));
	close(fd);
	buf[r] = 0;
	fputs(buf, stderr);
	fputc('\n', stderr);

	exit(0);
}

It is linked with -lhugetlbfs (version 2.20)
My 8xx board is configured with 64 huge pages, default size 512k:

root@vgoip:~# cat /proc/meminfo
MemTotal:         123664 kB
MemFree:           58464 kB
MemAvailable:      67904 kB
Buffers:               0 kB
Cached:            14480 kB
SwapCached:            0 kB
Active:            11616 kB
Inactive:           7872 kB
Active(anon):       7584 kB
Inactive(anon):      240 kB
Active(file):       4032 kB
Inactive(file):     7632 kB
Unevictable:        2560 kB
Mlocked:            2560 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:          7568 kB
Mapped:             7456 kB
Shmem:               736 kB
Slab:               7456 kB
SReclaimable:       3120 kB
SUnreclaim:         4336 kB
KernelStack:         568 kB
PageTables:         1024 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       45440 kB
Committed_AS:      38880 kB
VmallocTotal:     866304 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HugePages_Total:      64
HugePages_Free:       64
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:        512 kB


Without the patch, my test app gives the following results: as you can 
see, second and third malloc returns address which is not in a hugepage. 
strace shows that libhugetlbfs fallsback on regular mmap because 
hugepage has not been allocated at the requested address.

root@vgoip:~# HUGETLB_MORECORE=yes ./huge_malloc_test
00100000-00108000 r-xp 00000000 00:00 0          [vdso]
0fde4000-0fde8000 r-xp 00000000 00:0f 168        /lib/libdl-2.23.so
0fde8000-0fe00000 ---p 00004000 00:0f 168        /lib/libdl-2.23.so
0fe00000-0fe04000 r--p 0000c000 00:0f 168        /lib/libdl-2.23.so
0fe04000-0fe08000 rwxp 00010000 00:0f 168        /lib/libdl-2.23.so
0fe18000-0ff88000 r-xp 00000000 00:0f 191        /lib/libc-2.23.so
0ff88000-0ffa4000 ---p 00170000 00:0f 191        /lib/libc-2.23.so
0ffa4000-0ffa8000 r--p 0017c000 00:0f 191        /lib/libc-2.23.so
0ffa8000-0ffac000 rwxp 00180000 00:0f 191        /lib/libc-2.23.so
0ffac000-0ffb0000 rwxp 00000000 00:00 0
0ffc0000-0ffd4000 r-xp 00000000 00:0f 90         /lib/libhugetlbfs.so
0ffd4000-0ffe0000 ---p 00014000 00:0f 90         /lib/libhugetlbfs.so
0ffe0000-0ffe4000 rwxp 00010000 00:0f 90         /lib/libhugetlbfs.so
0ffe4000-0fff0000 rwxp 00000000 00:00 0
10000000-10004000 r-xp 00000000 00:0f 3076       /root/huge_malloc_test
10010000-10014000 rwxp 00000000 00:0f 3076       /root/huge_malloc_test
77940000-77964000 r-xp 00000000 00:0f 171        /lib/ld-2.23.so
7797c000-77980000 r--p 0002c000 00:0f 171        /lib/ld-2.23.so
77980000-77984000 rwxp 00030000 00:0f 171        /lib/ld-2.23.so
7fa58000-7fa7c000 rw-p 00000000 00:00 0          [stack]

libhugetlbfs: WARNING: Heap originates at 0x73e80000 instead of 0x10080000

Allocated 1Mbytes at 0x73e80008

libhugetlbfs: WARNING: New heap segment mapped at 0x73d80000 instead of 
0x74000000

Allocated 1Mbytes at 0x777fc008

libhugetlbfs: WARNING: New heap segment mapped at 0x73d00000 instead of 
0x74000000

Allocated 1Mbytes at 0x776b8008

00100000-00108000 r-xp 00000000 00:00 0          [vdso]
0fde4000-0fde8000 r-xp 00000000 00:0f 168        /lib/libdl-2.23.so
0fde8000-0fe00000 ---p 00004000 00:0f 168        /lib/libdl-2.23.so
0fe00000-0fe04000 r--p 0000c000 00:0f 168        /lib/libdl-2.23.so
0fe04000-0fe08000 rwxp 00010000 00:0f 168        /lib/libdl-2.23.so
0fe18000-0ff88000 r-xp 00000000 00:0f 191        /lib/libc-2.23.so
0ff88000-0ffa4000 ---p 00170000 00:0f 191        /lib/libc-2.23.so
0ffa4000-0ffa8000 r--p 0017c000 00:0f 191        /lib/libc-2.23.so
0ffa8000-0ffac000 rwxp 00180000 00:0f 191        /lib/libc-2.23.so
0ffac000-0ffb0000 rwxp 00000000 00:00 0
0ffc0000-0ffd4000 r-xp 00000000 00:0f 90         /lib/libhugetlbfs.so
0ffd4000-0ffe0000 ---p 00014000 00:0f 90         /lib/libhugetlbfs.so
0ffe0000-0ffe4000 rwxp 00010000 00:0f 90         /lib/libhugetlbfs.so
0ffe4000-0fff0000 rwxp 00000000 00:00 0
10000000-10004000 r-xp 00000000 00:0f 3076       /root/huge_malloc_test
10010000-10014000 rwxp 00000000 00:0f 3076       /root/huge_malloc_test
73e80000-74000000 rw-p 00000000 00:0b 98386      /anon_hugepage (deleted)
776b8000-77940000 rw-p 00000000 00:00 0
77940000-77964000 r-xp 00000000 00:0f 171        /lib/ld-2.23.so
7797c000-77980000 r--p 0002c000 00:0f 171        /lib/ld-2.23.so
77980000-77984000 rwxp 00030000 00:0f 171        /lib/ld-2.23.so
7fa58000-7fa7c000 rw-p 00000000 00:00 0          [stack]


With the patch applied, it works properly, each malloc get an address 
within the hugepage space.

root@vgoip:~# HUGETLB_MORECORE=yes ./huge_malloc_test
00100000-00108000 r-xp 00000000 00:00 0          [vdso]
0fde4000-0fde8000 r-xp 00000000 00:0f 168        /lib/libdl-2.23.so
0fde8000-0fe00000 ---p 00004000 00:0f 168        /lib/libdl-2.23.so
0fe00000-0fe04000 r--p 0000c000 00:0f 168        /lib/libdl-2.23.so
0fe04000-0fe08000 rwxp 00010000 00:0f 168        /lib/libdl-2.23.so
0fe18000-0ff88000 r-xp 00000000 00:0f 191        /lib/libc-2.23.so
0ff88000-0ffa4000 ---p 00170000 00:0f 191        /lib/libc-2.23.so
0ffa4000-0ffa8000 r--p 0017c000 00:0f 191        /lib/libc-2.23.so
0ffa8000-0ffac000 rwxp 00180000 00:0f 191        /lib/libc-2.23.so
0ffac000-0ffb0000 rwxp 00000000 00:00 0
0ffc0000-0ffd4000 r-xp 00000000 00:0f 90         /lib/libhugetlbfs.so
0ffd4000-0ffe0000 ---p 00014000 00:0f 90         /lib/libhugetlbfs.so
0ffe0000-0ffe4000 rwxp 00010000 00:0f 90         /lib/libhugetlbfs.so
0ffe4000-0fff0000 rwxp 00000000 00:00 0
10000000-10004000 r-xp 00000000 00:0f 3076       /root/huge_malloc_test
10010000-10014000 rwxp 00000000 00:0f 3076       /root/huge_malloc_test
77884000-778a8000 r-xp 00000000 00:0f 171        /lib/ld-2.23.so
778c0000-778c4000 r--p 0002c000 00:0f 171        /lib/ld-2.23.so
778c4000-778c8000 rwxp 00030000 00:0f 171        /lib/ld-2.23.so
7ff98000-7ffbc000 rw-p 00000000 00:00 0          [stack]

libhugetlbfs: WARNING: Heap originates at 0x30000000 instead of 0x10080000

Allocated 1Mbytes at 0x30000008


Allocated 1Mbytes at 0x30100010


Allocated 1Mbytes at 0x30200018

00100000-00108000 r-xp 00000000 00:00 0          [vdso]
0fde4000-0fde8000 r-xp 00000000 00:0f 168        /lib/libdl-2.23.so
0fde8000-0fe00000 ---p 00004000 00:0f 168        /lib/libdl-2.23.so
0fe00000-0fe04000 r--p 0000c000 00:0f 168        /lib/libdl-2.23.so
0fe04000-0fe08000 rwxp 00010000 00:0f 168        /lib/libdl-2.23.so
0fe18000-0ff88000 r-xp 00000000 00:0f 191        /lib/libc-2.23.so
0ff88000-0ffa4000 ---p 00170000 00:0f 191        /lib/libc-2.23.so
0ffa4000-0ffa8000 r--p 0017c000 00:0f 191        /lib/libc-2.23.so
0ffa8000-0ffac000 rwxp 00180000 00:0f 191        /lib/libc-2.23.so
0ffac000-0ffb0000 rwxp 00000000 00:00 0
0ffc0000-0ffd4000 r-xp 00000000 00:0f 90         /lib/libhugetlbfs.so
0ffd4000-0ffe0000 ---p 00014000 00:0f 90         /lib/libhugetlbfs.so
0ffe0000-0ffe4000 rwxp 00010000 00:0f 90         /lib/libhugetlbfs.so
0ffe4000-0fff0000 rwxp 00000000 00:00 0
10000000-10004000 r-xp 00000000 00:0f 3076       /root/huge_malloc_test
10010000-10014000 rwxp 00000000 00:0f 3076       /root/huge_malloc_test
30000000-30180000 rw-p 00000000 00:0b 7321       /anon_hugepage (deleted)
30180000-30280000 rw-p 00180000 00:0b 7322       /anon_hugepage (deleted)
30280000-30380000 rw-p 00280000 00:0b 7323       /anon_hugepage (deleted)
77884000-778a8000 r-xp 00000000 00:0f 171        /lib/ld-2.23.so
778c0000-778c4000 r--p 0002c000 00:0f 171        /lib/ld-2.23.so
778c4000-778c8000 rwxp 00030000 00:0f 171        /lib/ld-2.23.so
7ff98000-7ffbc000 rw-p 00000000 00:00 0          [stack]



Christophe
