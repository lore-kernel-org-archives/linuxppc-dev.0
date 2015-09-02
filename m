Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 868221A1E29
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 21:14:45 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Sep 2015 16:44:41 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4A1F5E0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 16:43:58 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t82BEbqw18940102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 16:44:38 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t82BEWGq009423
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 16:44:37 +0530
Message-ID: <55E6DA17.5030101@linux.vnet.ibm.com>
Date: Wed, 02 Sep 2015 16:44:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RESEND] Soft lockup after huge page offline attempt
References: <55E6CA60.6030502@linux.vnet.ibm.com>
 <1441189221.7208.19.camel@neuling.org>
In-Reply-To: <1441189221.7208.19.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/02/2015 03:50 PM, Michael Neuling wrote:
> On Wed, 2015-09-02 at 15:37 +0530, Anshuman Khandual wrote:
>> Hello,
>>
>> Worked on a modified version of the following selftest
>> test case in the kernel source.
>>
>> tools/testing/selftests/vm/hugepage-mmap.c
> 
> Please send the test case and how to run it here.

Please find them here.


Script (modified from tools/testing/selftests/vm/run_vmtests)
=============================================================
#!/bin/bash
#please run as root

#we need 256M, below is the size in kB
needmem=262144
mnt=./huge
exitcode=0

#get pagesize and freepages from /proc/meminfo
while read name size unit; do
        if [ "$name" = "HugePages_Free:" ]; then
                freepgs=$size
        fi
        if [ "$name" = "Hugepagesize:" ]; then
                pgsize=$size
        fi
done < /proc/meminfo

#set proper nr_hugepages
if [ -n "$freepgs" ] && [ -n "$pgsize" ]; then
        nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
        needpgs=`expr $needmem / $pgsize`
        if [ $freepgs -lt $needpgs ]; then
                lackpgs=$(( $needpgs - $freepgs ))
                echo $(( ($lackpgs + $nr_hugepgs) * 4)) > /proc/sys/vm/nr_hugepages
                if [ $? -ne 0 ]; then
                        echo "Please run this test as root"
                        exit 1
                fi
        fi
else
        echo "no hugetlbfs support in kernel?"
        exit 1
fi

mkdir $mnt
mount -t hugetlbfs none $mnt

echo "--------------------"
echo "running hugepage-mmap"
echo "--------------------"
./hugepage-mmap
if [ $? -ne 0 ]; then
        echo "[FAIL]"
        exitcode=1
else
        echo "[PASS]"
fi

#cleanup
umount $mnt
rm -rf $mnt
echo $nr_hugepgs > /proc/sys/vm/nr_hugepages

testcase (modified from /testing/selftests/vm/hugepage-mmap.c)
==============================================================

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FILE_NAME "huge/hugepagefile"
#define LENGTH (256UL*1024*1024)
#define PROTECTION (PROT_READ | PROT_WRITE)

#define ADDR (void *)(0x0UL)
#define FLAGS (MAP_SHARED)

#define SOFT_OFFLINE "/sys/devices/system/memory/soft_offline_page"
#define PAGE_MAP "/proc/self/pagemap"
#define PAGEMAP_LEN 8
#define HPAGE 16384 * 1024
#define PFN_MASK 0x007FFFFFFFFFFFFFUL

static void check_bytes(char *addr)
{
        printf("First hex is %x\n", *((unsigned int *)addr));
}

static void write_bytes(char *addr)
{
        unsigned long i;

        for (i = 0; i < LENGTH; i++)
                *(addr + i) = (char)i;
}

static int read_bytes(char *addr)
{
        unsigned long i;

        check_bytes(addr);
        for (i = 0; i < LENGTH; i++)
                if (*(addr + i) != (char)i) {
                        printf("Mismatch at %lu\n", i);
                        return 1;
                }
        return 0;
}

int main(void)
{
        void *addr, *tmp;
        int fd, fd1, fd2, ret;
        int i;
        unsigned long offset, pfn;
        char buf[20];

        fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
        if (fd < 0) {
                perror("Open failed");
                exit(1);
        }
        addr = mmap(ADDR, LENGTH, PROTECTION, FLAGS, fd, 0);
        if (addr == MAP_FAILED) {
                perror("mmap");
                unlink(FILE_NAME);
                exit(1);
        }

        if (mlock(addr, LENGTH) == -1) {
                perror("mlock");
                unlink(FILE_NAME);
                exit(1);
        }

        printf("Returned address is %p\n", addr);
        check_bytes(addr);
        write_bytes(addr);
        ret = read_bytes(addr);

        fd1 = open(PAGE_MAP, O_RDONLY);
        if (fd1 == -1) {
                perror("open");
                exit(-1);
        }

        fd2 = open(SOFT_OFFLINE, O_WRONLY);
        if (fd1 == -1) {
                perror("open");
                exit(-1);
        }

        for (i = 0; i < 16; i++) {
                tmp = addr + i * HPAGE;
                offset = ((unsigned long) tmp / getpagesize()) * PAGEMAP_LEN;

                if (lseek(fd1, offset, SEEK_SET) == -1) {
                        perror("seek");
                        exit(-1);
                }

                if (read(fd1, &pfn, sizeof(pfn)) == -1) {
                        perror("read");
                        exit(-1);
                }

                printf("PFN: %lx ", pfn & PFN_MASK);
                pfn = (pfn & PFN_MASK) << 16;
                printf("Address: %lx\n", pfn);

                sprintf(buf, "0x%lx\n", pfn);
                printf("buf: %s\n", buf);

                if (write(fd2, buf, strlen(buf)) == -1) {
                        perror("write");
                }
        }

        munmap(addr, LENGTH);
        close(fd);
        close(fd1);
        close(fd2);
        unlink(FILE_NAME);
        return ret;
}
