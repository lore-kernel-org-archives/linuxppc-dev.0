Message-ID: <20030822214334.97407.qmail@web21411.mail.yahoo.com>
Date: Fri, 22 Aug 2003 14:43:34 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
Subject: kernel BUG at page_alloc.c:225 on PPC440GP
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I got this kernel panic only on linux 2.4.19 PPC440GP
port, not seen this problem on PPC405GP port.

oom_test is the utility that does continous malloc
until it fails. The command line does 4K malloc each
time until the total memory malloced is 256MB(this is
the total physical memory in my test box). On PPC405GP
machine, oom_killer kicked in and killed this process.
But on PPC440GP box, the kernel got panic. I attached
the oom_test code in the bottom.

One thing I am not clear is that why the machine
dependent code has anything to do with page_alloc.c
which is kind of machine-independent.

Thanks anyone for any idea.

================================================
sh-2.04# ./oom_test -r 4 -l 262144
growing memory at rate = 4 KB/sec
limiting growth at 262144 KB
kernel BUG at page_alloc.c:225!
Exception in kernel mode: sig=4
Oops: Exception in kernel mode, sig: 4
NIP: C0031F08 XER: 00000000 LR: C0031F08 SP: C093DD40
REGS: c093dc80 TRAP: 0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c093c000[60] 'oom_test' Last syscall: 45
last math 00000000 last altivec 00000000
PLB0: bear= 0x00030004 acr=   0xbb000000 besr=
0x00000000

GPR00: C0031F08 C093DD40 C093C000 00000020 00001030
00000001 00000020 C02A0000
GPR08: 00001230 C01DCCA8 00000000 C093DC60 001D6049
10056858 00000000 00000000
GPR16: 00000000 00000000 C02A8E34 C02A8E34 C02A0000
00000001 C01B0000 C01B0000
GPR24: 00000000 BA2E8BA3 00000AFF C01DDDB0 00000000
C01DDDC8 00000001 C036A4BC
Call backtrace:
C0031F08 C003229C C0031F84 C0026164 C00262B0 C00264D0
C000EB44
C0003774 10003E5C 100037D8 10000740 10000A24 00000000

>>NIP; c0031f08 <rmqueue+0x2cc/0x328 [kernel]>
<=====
Trace; c0031f08 <rmqueue+0x2cc/0x328 [kernel]>
Trace; c003229c <__alloc_pages+0x58/0x1f4 [kernel]>
Trace; c0031f84 <_alloc_pages+0x20/0x30 [kernel]>
Trace; c0026164 <do_anonymous_page+0x68/0x158
[kernel]>
Trace; c00262b0 <do_no_page+0x5c/0x1f8 [kernel]>
Trace; c00264d0 <handle_mm_fault+0x84/0x12c [kernel]>
Trace; c000eb44 <do_page_fault+0x24c/0x3dc [kernel]>
Trace; c0003774 <ret_from_except+0x0/0x34 [kernel]>
Trace; 10003e5c <Unknown (0x10003e5c)>
Trace; 100037d8 <Unknown (0x100037d8)>
Trace; 10000740 <Unknown (0x10000740)>
Trace; 10000a24 <Unknown (0x10000a24)>
Trace; 00000000 <Unknown (0x0)>

Oops: kernel access of bad area, sig: 11
NIP: C001E398 XER: 00000000 LR: C001E428 SP: C093DA70
REGS: c093d9b0 TRAP: 0800    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c093c000[60] 'oom_test' Last syscall: 45
last math 00000000 last altivec 00000000
PLB0: bear= 0x00030004 acr=   0xbb000000 besr=
0x00000000

GPR00: 00000000 C093DA70 C093C000 00000800 00001030
C02A0000 C02A0000 00000000
GPR08: 00000000 00000000 00000000 C01DA070 0000001B
10056858 00000000 00000000
GPR16: 00000000 00000000 C02A8E34 C02A8E34 00001032
C093DB50 00000000 C000376C
GPR24: C00050D8 BA2E8BA3 C028AF00 00000000 C02A0000
00000001 00000000 000000A7
Call backtrace:
C001E400 C001A054 C0019F14 C0019B54 C000530C C000376C
C0003934
C000399C C0003C60 C0003774 C0031F08 C003229C C0031F84
C0026164
C00262B0 C00264D0 C000EB44 C0003774 10003E5C 100037D8
10000740
10000A24 00000000

>>NIP; c001e398 <count_active_tasks+0x20/0x4c
[kernel]>    <=====
Trace; c001e400 <timer_bh+0x3c/0x458 [kernel]>
Trace; c001a054 <bh_action+0x3c/0x8c [kernel]>
Trace; c0019f14 <tasklet_hi_action+0xa0/0xe0 [kernel]>
Trace; c0019b54 <do_softirq+0x88/0x100 [kernel]>
Trace; c000530c <timer_interrupt+0x234/0x24c [kernel]>
Trace; c000376c <ret_from_intercept+0x0/0x8 [kernel]>
Trace; c0003934 <die+0x60/0x80 [kernel]>
Trace; c000399c <_exception+0x48/0x68 [kernel]>
Trace; c0003c60 <ProgramCheckException+0xa0/0xc4
[kernel]>
Trace; c0003774 <ret_from_except+0x0/0x34 [kernel]>
Trace; c0031f08 <rmqueue+0x2cc/0x328 [kernel]>
Trace; c003229c <__alloc_pages+0x58/0x1f4 [kernel]>
Trace; c0031f84 <_alloc_pages+0x20/0x30 [kernel]>
Trace; c0026164 <do_anonymous_page+0x68/0x158
[kernel]>
Trace; c00262b0 <do_no_page+0x5c/0x1f8 [kernel]>
Trace; c00264d0 <handle_mm_fault+0x84/0x12c [kernel]>
Trace; c000eb44 <do_page_fault+0x24c/0x3dc [kernel]>
Trace; c0003774 <ret_from_except+0x0/0x34 [kernel]>
Trace; 10003e5c <Unknown (0x10003e5c)>
Trace; 100037d8 <Unknown (0x100037d8)>
Trace; 10000740 <Unknown (0x10000740)>
Trace; 10000a24 <Unknown (0x10000a24)>
Trace; 00000000 <Unknown (0x0)>

Kernel panic: Aiee, killing interrupt handler!


===========oom_test.c==========================
int main(int argc, char **argv)
{
    int gotosleep = 0;
    int rate = 10;
    int limit = 0;
    int total = 0;
    int writetest = 0;
    int usecalloc = 0;
    int i;
    char *ptr;

    if(argc == 1)
        usage(argv[0]);

    i = 0;
    while(++i < argc)
    {
        if(strcmp(argv[i], "-r") == 0)
        {
            i++;
            sscanf(argv[i], "%d", &rate);
        }
        if(strcmp(argv[i], "-l") == 0)
        {
            i++;
            sscanf(argv[i], "%d", &limit);
        }
        if(strcmp(argv[i], "-w") == 0)
        {
            writetest = 1;
            continue;
        }
        if(strcmp(argv[i], "-s") == 0)
        {
            gotosleep = 1;
            continue;
        }
        if(strcmp(argv[i], "-c") == 0)
        {
            usecalloc = 1;
            continue;
        }
        if(strcmp(argv[i], "--help") == 0)
            usage(argv[0]);
    }

    fprintf(stdout, "growing memory at rate = %d
KB/sec\n", rate);
    if(limit)
        fprintf(stdout, "limiting growth at %d KB\n",
limit);
    else
        fprintf(stdout, "no limit\n");

    if(gotosleep)
        fprintf(stdout, "sleeping after limit is
reached\n");

    if(writetest)
        fprintf(stdout, "writing data into allocated
memory\n");

    if(usecalloc)
        fprintf(stdout, "calling calloc()\n");

    total = 0;
    while(1)
    {
        int i;
        int size;

        if(limit)
            size = MIN(rate, limit-total);
        else
            size = rate;

        if(usecalloc)
            ptr = calloc(size*1024, 1);
        else
            ptr = malloc(size*1024);

        if(ptr == NULL)
            fprintf(stderr, "Failed to allocate %d
KB\n", size);
        else
            total += size;

        if(writetest && ptr)
            for(i=0; i<size*1024; i+=4096)
                memset(&ptr[i], 1, 1);

        if(ptr) {
            for(i=0; i<size*1024; i+=4096)
                if(ptr[i+4] != 0)
                {
                    printf("Found non-zero data:
%d\n", ptr[i]);
                    break;
                }
        }

        if(limit != 0 && total >= limit)
        {
            fprintf(stdout, "Limit of %d KB
reached\n", total);
            break;
        }
    }
    if(gotosleep)
        sleep(10000000);

    fprintf(stdout, "Done!\n");
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
