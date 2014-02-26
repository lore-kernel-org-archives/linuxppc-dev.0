Return-Path: <kernelfans@gmail.com>
Received: from mail-yh0-x233.google.com (mail-yh0-x233.google.com
 [IPv6:2607:f8b0:4002:c01::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9EEE72C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 14:09:23 +1100 (EST)
Received: by mail-yh0-f51.google.com with SMTP id t59so354189yho.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 19:09:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <62DB3340-5AF7-4DA4-A790-77EE00696F57@suse.de>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
 <CAFgQCTthThEtNEG7EOuYFCtOm46-br59u9QUNkxF0w-TM+RdJQ@mail.gmail.com>
 <62DB3340-5AF7-4DA4-A790-77EE00696F57@suse.de>
Date: Wed, 26 Feb 2014 11:09:19 +0800
Message-ID: <CAFgQCTus1MdPfRc3h7=hehfVkP9-EoRKTb0UhzLh+RGH7Wsd+w@mail.gmail.com>
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry to update lately. It takes a long time to apply for test machine
and then, I hit a series of other bugs which I could not resolve
easily. And for now, I have some high priority task, and will come
back to this topic when time is available.
Besides this, I had do some basic test for numa-fault and no
numa-fault test for HV guest, it shows that 10% drop in performance
when  numa-fault is on. (Test with $pg_access_random 60 4 200, and
guest has 10GB mlocked pages ).
I thought this is caused based on the following factors: cache-miss,
tlb-miss, guest->host exit and hw-thread cooperate to exit from guest
state.  Hope my patches to be helpful to reduce the cost of
guest->host exit and hw-thread cooperate to exit.

My test case launches 4 threads on guest( as 4 hw-threads ), and each
of them has random access to PAGE_ALIGN area.
Hope from some suggestion about the test case, so when I had time, I
could improve and finish the test.

Thanks,
Fan

--- test case: usage: pg_random_access  secs  fork_num  mem_size---
#include <ctype.h>
#include <errno.h>
#include <libgen.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <time.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/timerfd.h>
#include <time.h>
#include <stdint.h>        /* Definition of uint64_t */
#include <poll.h>


/* */
#define CMD_STOP 0x1234
#define SHM_FNAME "/numafault_shm"
#define PAGE_SIZE (1<<12)

/* the protocol defined on the shm */
#define SHM_CMD_OFF 0x0
#define SHM_CNT_OFF 0x1
#define SHM_MESSAGE_OFF 0x2

#define handle_error(msg) \
        do { perror(msg); exit(EXIT_FAILURE); } while (0)


void __inline__ random_access(void *region_start, int len)
{
        int *p;
        int num;

        num = random();
        num &= ~(PAGE_SIZE - 1);
        num &= (len - 1);
        p = region_start + num;
        *p = 0x654321;
}

static int numafault_body(int size_MB)
{
        /* since MB is always align on PAGE_SIZE, so it is ok to test
fault on page */
        int size = size_MB*1024*1024;
        void *region_start = malloc(size);
        unsigned long *pmap;
        int shm_fid;
        unsigned long cnt = 0;
        pid_t pid = getpid();
        char *dst;
        char buf[128];

        shm_fid = shm_open(SHM_FNAME, O_RDWR, S_IRUSR | S_IWUSR);
        ftruncate(shm_fid, 2*sizeof(long));
        pmap = mmap(NULL, 2*sizeof(long), PROT_WRITE | PROT_READ,
MAP_SHARED, shm_fid, 0);
        if (!pmap) {
                printf("child fail to setup mmap of shm\n");
                return -1;
        }

        while (*(pmap+SHM_CMD_OFF) != CMD_STOP){
                random_access(region_start, size);
                cnt++;
        }

        __atomic_fetch_add((pmap+SHM_CNT_OFF), cnt, __ATOMIC_SEQ_CST);
        dst = (char *)(pmap+SHM_MESSAGE_OFF);
        //tofix, need lock
        sprintf(buf, "child [%i] cnt=%u\n\0", pid, cnt);
        strcat(dst, buf);

        munmap(pmap, 2*sizeof(long));
        shm_unlink(SHM_FNAME);
        fprintf(stdout, "[%s] cnt=%lu\n", pid, cnt);
        fflush(stdout);
        exit(0);

}

int main(int argc, char **argv)
{
        int i;
        pid_t pid;
        int shm_fid;
        unsigned long *pmap;
        int fork_num;
        int size;
        char *dst_info;

        struct itimerspec new_value;
        int fd;
        struct timespec now;
        uint64_t exp, tot_exp;
        ssize_t s;
        struct pollfd pfd;
        int elapsed;

        if (argc != 4){
            fprintf(stderr, "%s wait-secs [secs elapsed before parent
asks the children to exit]\n \
                    fork-num [child num]\n \
                    size [memory region covered by each child in MB]\n",
                    argv[0]);
            exit(EXIT_FAILURE);
        }
        elapsed = atoi(argv[1]);
        fork_num = atoi(argv[2]);
        size = atoi(argv[3]);
        printf("fork %i child process to test mem %i MB for a period: %i sec\n",
                fork_num, size, elapsed);

        fd = timerfd_create(CLOCK_REALTIME, 0);
        if (fd == -1)
            handle_error("timerfd_create");


        shm_fid = shm_open(SHM_FNAME, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
        ftruncate(shm_fid, PAGE_SIZE);
        pmap = mmap(NULL, PAGE_SIZE, PROT_WRITE | PROT_READ,
MAP_SHARED, shm_fid, 0);
        if (!pmap) {
                printf("fail to setup mmap of shm\n");
                return -1;
        }
        memset(pmap, 0, 2*sizeof(long));
        //wmb();

        for (i = 0; i < fork_num; i++){
                switch (pid = fork())
                {
                case 0:            /* child */
                        numafault_body(size);
                        exit(0);
                case -1:           /* error */
                        err (stderr, "fork failed: %s\n", strerror (errno));
                        break;
                default:           /* parent */
                        printf("fork child [%i]\n", pid);
                }
        }

        if (clock_gettime(CLOCK_REALTIME, &now) == -1)
                handle_error("clock_gettime");

        /* Create a CLOCK_REALTIME absolute timer with initial
expiration and interval as specified in command line */

        new_value.it_value.tv_sec = now.tv_sec + elapsed;
        new_value.it_value.tv_nsec = now.tv_nsec;
        new_value.it_interval.tv_sec = 0;
        new_value.it_interval.tv_nsec = 0;

        if (timerfd_settime(fd, TFD_TIMER_ABSTIME, &new_value, NULL) == -1)
                handle_error("timerfd_settime");

        pfd.fd = fd;
        pfd.events = POLLIN;
        pfd.revents = 0;
        /* -1: infinite wait */
        poll(&pfd, 1, -1);



        /* ask children to stop and get back cnt */

        *(pmap + SHM_CMD_OFF) = CMD_STOP;

        wait(NULL);
        dst_info = (char *)(pmap + SHM_MESSAGE_OFF);
        printf(dst_info);
        printf("total cnt:%lu\n", *(pmap + SHM_CNT_OFF));

        munmap(pmap, PAGE_SIZE);
        shm_unlink(SHM_FNAME);
}




On Mon, Jan 20, 2014 at 10:48 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 15.01.2014, at 07:36, Liu ping fan <kernelfans@gmail.com> wrote:
>
>> On Thu, Jan 9, 2014 at 8:08 PM, Alexander Graf <agraf@suse.de> wrote:
>>>
>>> On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>>
>>>> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: Numa faults support for ppc64"
>>>>
>>>> For this series, I apply the same idea from the previous thread "[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
>>>> (for which, I still try to get a machine to show nums)
>>>>
>>>> But for this series, I think that I have a good justification -- the fact of heavy cost when switching context between guest and host,
>>>> which is  well known.
>>>
>>> This cover letter isn't really telling me anything. Please put a proper description of what you're trying to achieve, why you're trying to achieve what you're trying and convince your readers that it's a good idea to do it the way you do it.
>>>
>> Sorry for the unclear message. After introducing the _PAGE_NUMA,
>> kvmppc_do_h_enter() can not fill up the hpte for guest. Instead, it
>> should rely on host's kvmppc_book3s_hv_page_fault() to call
>> do_numa_page() to do the numa fault check. This incurs the overhead
>> when exiting from rmode to vmode.  My idea is that in
>> kvmppc_do_h_enter(), we do a quick check, if the page is right placed,
>> there is no need to exit to vmode (i.e saving htab, slab switching)
>>
>>>> If my suppose is correct, will CCing kvm@vger.kernel.org from next version.
>>>
>>> This translates to me as "This is an RFC"?
>>>
>> Yes, I am not quite sure about it. I have no bare-metal to verify it.
>> So I hope at least, from the theory, it is correct.
>
> Paul, could you please give this some thought and maybe benchmark it?
>
>
> Alex
>
