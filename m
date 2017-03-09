Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf5Zh6VMCzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 21:03:56 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v29A3iqT020553
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 05:03:49 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292j70935n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 05:03:49 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 20:03:46 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v29A3aKi50855966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 21:03:44 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v29A3AxI029277
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 21:03:10 +1100
Subject: [libhugetlbfs] linkhuge_rw fails with gcc 6.2.0 on 4.11.0-rc1 ppc64le
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mpe <mpe@ellerman.id>,
 "aneesh.kumar" <aneesh.kumar@linux.vnet.ibm.com>, sachinp
 <sachinp@linux.vnet.ibm.com>
Date: Thu, 09 Mar 2017 15:32:52 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1489053772.3961.26.camel@abdul-ThinkPad-T450>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

linkhuge_rw test case fails on 4.11.0-rc1 kernel.


# HUGETLB_VERBOSE=99 HUGETLB_DEBUG=yes HUGETLB_SHARE=0
LD_LIBRARY_PATH=./obj64 HUGETLB_ELFMAP=R ./tests/obj64/linkhuge_rw 
libhugetlbfs [pkvmhab012:8026]: INFO: Found pagesize 16384 kB
libhugetlbfs [pkvmhab012:8026]: INFO: Detected page sizes:
libhugetlbfs [pkvmhab012:8026]: INFO:    Size: 16384 kB (default)
Mount: /dev/hugepages
libhugetlbfs [pkvmhab012:8026]: INFO: Parsed kernel version: [4] . [9] .
[0]  [pre-release: 6]
libhugetlbfs [pkvmhab012:8026]: INFO: Feature private_reservations is
present in this kernel
libhugetlbfs [pkvmhab012:8026]: INFO: Feature noreserve_safe is present
in this kernel
libhugetlbfs [pkvmhab012:8026]: INFO: Feature map_hugetlb is present in
this kernel
libhugetlbfs [pkvmhab012:8026]: INFO: Kernel has MAP_PRIVATE
reservations.  Disabling heap prefaulting.
libhugetlbfs [pkvmhab012:8026]: INFO: Kernel supports MAP_HUGETLB
libhugetlbfs [pkvmhab012:8026]: INFO: HUGETLB_SHARE=0, sharing disabled
libhugetlbfs [pkvmhab012:8026]: INFO: HUGETLB_NO_RESERVE=no,
reservations enabled
libhugetlbfs [pkvmhab012:8026]: INFO: Segment 0 (phdr 2): 0-0x133d4
(filesz=0x133d4) (prot = 0x5)
libhugetlbfs [pkvmhab012:8026]: DEBUG: Total memsz = 0x133d4, memsz of
largest segment = 0x133d4
libhugetlbfs [pkvmhab012:8026]: INFO: libhugetlbfs version: 2.20
(modified)
libhugetlbfs [pkvmhab012:8027]: INFO: Mapped hugeseg at 0x3effff000000.
Copying 0x133d4 bytes and 0 extra bytes from (nil)...libhugetlbfs
[pkvmhab012:8026]: INFO: Prepare succeeded
Starting testcase "./tests/obj64/linkhuge_rw", pid 8026
HUGETLB_ELFMAP=R
entry: small_data, data: 0x60d20010, writable: 1
entry: small_data, data: 0x60d20010, is_huge: 0
entry: big_data, data: 0x60d10010, writable: 1
entry: big_data, data: 0x60d10010, is_huge: 0
entry: small_bss, data: 0x60d30124, writable: 1
entry: small_bss, data: 0x60d30124, is_huge: 0
entry: big_bss, data: 0x60d20124, writable: 1
entry: big_bss, data: 0x60d20124, is_huge: 0
entry: small_const, data: 0x40d22e2c, writable: 0
entry: small_const, data: 0x40d22e2c, is_huge: 0
entry: big_const, data: 0x40d12e2c, writable: 0
entry: big_const, data: 0x40d12e2c, is_huge: 0
entry: static_func, data: 0x40d11cb0, writable: 0
entry: static_func, data: 0x40d11834, is_huge: 0
entry: global_func, data: 0x40d11c90, writable: 0
entry: global_func, data: 0x40d11834, is_huge: 0
Hugepages used for:
FAIL	small_const is not hugepage

# objdump  -p linkhuge_rw 

linkhuge_rw:     file format elf64-powerpcle

Program Header:
    PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr 0x0000000000000040 align 2**3
         filesz 0x00000000000001c0 memsz 0x00000000000001c0 flags r-x
  INTERP off    0x0000000000000200 vaddr 0x0000000000000200 paddr 0x0000000000000200 align 2**0
         filesz 0x0000000000000011 memsz 0x0000000000000011 flags r--
    LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**28
         filesz 0x00000000000133d4 memsz 0x00000000000133d4 flags r-x
    LOAD off    0x000000000ffffb50 vaddr 0x000000001ffffb50 paddr 0x000000001ffffb50 align 2**28
         filesz 0x00000000000105cc memsz 0x00000000000205e0 flags rw-
 DYNAMIC off    0x000000000ffffb68 vaddr 0x000000001ffffb68 paddr 0x000000001ffffb68 align 2**3
         filesz 0x0000000000000260 memsz 0x0000000000000260 flags rw-
    NOTE off    0x0000000000000214 vaddr 0x0000000000000214 paddr 0x0000000000000214 align 2**2
         filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
   STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
         filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
   RELRO off    0x000000000ffffb50 vaddr 0x000000001ffffb50 paddr 0x000000001ffffb50 align 2**0
         filesz 0x00000000000004b0 memsz 0x00000000000004b0 flags r--


# cat /proc/self/maps
10000000-10020000 r-xp 00000000 08:02 87687259                           /bin/cat
10020000-10030000 r--p 00010000 08:02 87687259                           /bin/cat
10030000-10040000 rw-p 00020000 08:02 87687259                           /bin/cat
10020490000-100204c0000 rw-p 00000000 00:00 0                            [heap]
3fffb1fd0000-3fffb2010000 rw-p 00000000 00:00 0 
3fffb2010000-3fffb2340000 r--p 00000000 08:02 154664970                  /usr/lib/locale/locale-archive
3fffb2340000-3fffb2500000 r-xp 00000000 08:02 4325397                    /lib/powerpc64le-linux-gnu/libc-2.24.so
3fffb2500000-3fffb2510000 r--p 001b0000 08:02 4325397                    /lib/powerpc64le-linux-gnu/libc-2.24.so
3fffb2510000-3fffb2520000 rw-p 001c0000 08:02 4325397                    /lib/powerpc64le-linux-gnu/libc-2.24.so
3fffb2530000-3fffb2550000 r-xp 00000000 00:00 0                          [vdso]
3fffb2550000-3fffb2590000 r-xp 00000000 08:02 4325389                    /lib/powerpc64le-linux-gnu/ld-2.24.so
3fffb2590000-3fffb25a0000 r--p 00030000 08:02 4325389                    /lib/powerpc64le-linux-gnu/ld-2.24.so
3fffb25a0000-3fffb25b0000 rw-p 00040000 08:02 4325389                    /lib/powerpc64le-linux-gnu/ld-2.24.so
3fffe31c0000-3fffe31f0000 rw-p 00000000 00:00 0                          [stack]


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
