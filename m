Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E97D667B16
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 01:00:39 +1000 (EST)
In-Reply-To: <010f01c56c39$9d5a8ca0$0102000a@loop.com.tw>
References: <010f01c56c39$9d5a8ca0$0102000a@loop.com.tw>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6164723869a135f51d827844e4a9e0a0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 8 Jun 2005 09:59:33 -0500
To: "Nai-Hsien" <dennis@loop.com.tw>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8272 runs application with segmentation fault
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Jun 8, 2005, at 9:51 AM, Nai-Hsien wrote:

> Kumar,
> I got the kernel from Montavista version 3.1, which uses Linux kernel
> 2.4.20.
> According to readelf, my libc is version 2.3.2, which is also from
> Montavista.

There is your problem, change the 256, 256 in this entry to 32, 32.

> In cputable.c, I already added following entry for MPC8272.
>
>     { /* 827x, 828x (8270, 8275, 8280, 8272 are all 603e cores) */
>  0x7fff0000, 0x00820000, "827x & 828x",
>  CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB,
>  COMMON_PPC,
>  256, 256,
>  __setup_cpu_603
>     },

- kumar

> ----- Original Message -----
> From: "Kumar Gala" <kumar.gala@freescale.com>
> To: "Nai-Hsien" <dennis@loop.com.tw>
> Cc: <linuxppc-embedded@ozlabs.org>; "Andrew Williams" 
> <awilliam@nortel.com>
> Sent: Wednesday, June 08, 2005 9:52 PM
> Subject: Re: MPC8272 runs application with segmentation fault
>
>
>> A few questions, where did you get the kernel for the 8272 you are
>> using?  Can you report back what libc version you are running with.
>> Also, can see what entry in arch/ppc/kernel/cputable.c has a pvr_value
>> of 0x00820000 and report that back as well.
>>
>> - kumar
>>
>> On Jun 8, 2005, at 8:39 AM, Nai-Hsien wrote:
>>
>>> Andrew,
>>> I believe I already modify my u-boot to detect the processor.
>>>
>>> If I statically link my program, I find that the program can run
>>> on my MPC8272 platform properly, so I think maybe the problem
>>> is caused by shared library. However, the same file system (of 
>>> course,
>>> same shared library) can run on my MPC8245 platform.
>>>
>>> With the observation, I think my kernel is not handling shared 
>>> library
>>> properly. Is there any part of the kernel I should check?
>>>
>>> I added some code in do_page_fault() to dump some information, shown
>>> as below, when my program get problem.
>>>
>>> PID=34(console): Trap=300, NIP=0x0ffc6d90, LR=0x0ffc6d20, VM:
>>> (start=0x30000000,
>>> end=0x30017000, flags=0x00000875), addr=0x2e313056
>>> Segmentation fault
>>>
>>> Thank you
>>> Dennis
>>>
>>>
>>> ----- Original Message -----
>>> From: Andrew  <mailto:awilliam@nortel.com> Williams
>>> To: Nai-Hsien <mailto:dennis@loop.com.tw>  ;
>>> linuxppc-embedded@ozlabs.org
>>> Sent: Tuesday, June 07, 2005 10:17 PM
>>> Subject: RE: MPC8272 runs application with segmentation fault
>>>
>>> Take a alook at the checkcpu() routine in /cpu/mpc8260/cpu.c .
>>> Validate that your CPU is correctly being identified, and thus
>>> initialized.
>>> We had identical symptoms with the 8270.
>>>
>>> We added the following after the case for the PVR_8260_HIP7:
>>>
>>>         case PVR_8280a_HIP7:
>>>         case PVR_8280_HIP7:
>>>                 k = 7;
>>>                 printf (CPU_ID_STR " (HiP%d Rev %02x, Mask ", k, 
>>> rev);
>>>                 break;
>>>
>>> include/asm-ppc/processor.h
>>>
>>>     #define PVR_8280_HIP7   0x80822013
>>>     #define PVR_8280a_HIP7   0x80822014
>>>
>>> A.
>>>
>>> -----Original Message-----
>>> From: linuxppc-embedded-bounces@ozlabs.org
>>> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Nai-Hsien
>>> Sent: June 7, 2005 9:11 AM
>>> To: linuxppc-embedded@ozlabs.org
>>> Subject: MPC8272 runs application with segmentation fault
>>>
>>>
>>> Dear experts,
>>>
>>> I have two hardware boards, one uses MPC8245 and the other one uses
>>> MPC8272.
>>> Initially, I use the MPC8245 board to port Linux 2.4.20 and write 
>>> some
>>> applications.
>>> I already do a lot of test on the MPC8245 board and all my 
>>> application
>>> programs work
>>> fine.
>>>
>>> After this, I use the same kernel configuration and same file system
>>> that are being used
>>> by the MPC8245 board to port the whole system to my MPC8272.
>>> Now, I can boot the kernel and run busybox well. However, when
>>> I run my application programs, I always get segmentation fault.
>>> Following is a strace
>>> dump. Could anybody give me some idea?
>>>
>>> Thank you
>>> Dennis
>>>
>>> ====================================================
>>> execve("sbin/console", ["sbin/console"], [/* 6 vars */]) = 0
>>> uname({sys="Linux", node="6200_linux", ...}) = 0
>>> brk(0)                                  = 0x10059134
>>> open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
>>> directory)
>>> open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
>>> directory)
>>> open("/lib/libncurses.so.5", O_RDONLY)  = 3
>>> read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\001"...,
>>> 1024) = 1024
>>> fstat64(0x3, 0x7ffff098)                = 0
>>> mmap(0xff97000, 362628, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
>>> 0xff97000
>>> mprotect(0xffd4000, 112772, PROT_NONE)  = 0
>>> mmap(0xffd7000, 86016, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> MAP_PRIVATE|MAP_FIXED, 3, 0x30000) = 0xffd7000
>>> mmap(0xffec000, 14468, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffec000
>>> close(3)                                = 0
>>> open("/lib/libdl.so.2", O_RDONLY)       = 3
>>> read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\34"...,
>>> 1024) = 1024
>>> fstat64(0x3, 0x7ffff078)                = 0
>>> mmap(0xff74000, 74812, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
>>> 0xff74000
>>> mprotect(0xff77000, 62524, PROT_NONE)   = 0
>>> mmap(0xff84000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> MAP_PRIVATE|MAP_FIXED, 3, 0) = 0xff84000
>>> close(3)                                = 0
>>> open("/lib/libnsl.so.1", O_RDONLY)      = 3
>>> read(3,
>>> "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0A\274"..., 1024)
>>> = 1024
>>> fstat64(0x3, 0x7ffff058)                = 0
>>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
>>> 0) = 0x30017000
>>> mmap(0xff3e000, 152068, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
>>> 0xff3e000
>>> mprotect(0xff51000, 74244, PROT_NONE)   = 0
>>> mmap(0xff5e000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> MAP_PRIVATE|MAP_FIXED, 3, 0x10000) = 0xff5e000
>>> mmap(0xff61000, 8708, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff61000
>>> close(3)                                = 0
>>> open("/lib/libc.so.6", O_RDONLY)        = 3
>>> read(3, 
>>> "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\322"...,
>>> 1024) = 1024
>>> fstat64(0x3, 0x7ffff038)                = 0
>>> mmap(0xfddd000, 1379388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
>>> 0xfddd000
>>> mprotect(0xff16000, 97340, PROT_NONE)   = 0
>>> mmap(0xff1d000, 61440, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0xff1d000
>>> mmap(0xff2c000, 7228, PROT_READ|PROT_WRITE|PROT_EXEC,
>>> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff2c000
>>> close(3)                                = 0
>>> brk(0)                                  = 0x10059134
>>> brk(0x1005a134)                         = 0x1005a134
>>> brk(0x1005b000)                         = 0x1005b000
>>> write(2, "before init_ncurses()\n", 22) = 22
>>> write(2, "before initscr()\n", 17)      = 17
>>> access("/usr/share/terminfo/v/vt100", R_OK) = 0
>>> open("/usr/share/terminfo/v/vt100", O_RDONLY) = 3
>>> read(3, "\32\1,\0\25\0\7\0\16\1\3\2", 12) = 12
>>> read(3, "vt100|vt100-am|dec vt100 (w/adva"..., 44) = 44
>>> read(3, "\0\1\0\0\1\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1", 21) = 21
>>> read(3, "\0", 1)                        = 1
>>> read(3, "P\0\10\0\30\0\377\377\377\377\377\377\3\0", 14) = 14
>>> read(3, "\377\377\0\0\2\0\4\0\25\0\32\0&\0.\0\377\377\377\3777\0"...,
>>> 540) = 540
>>> read(3, "\7\0\r\0\33[%i%p1%d;%p2%dr\0\33[3g\0\33[H\33[J"..., 515) = 
>>> 515
>>> read(3, "", 1)                          = 0
>>> read(3, "", 10)                         = 0
>>> close(3)                                = 0
>>> -- SIGSEGV (Segmentation fault) @ 0 (0) ---
>>> +++ killed by SIGSEGV +++
>>> Segmentation fault
>>>
>>>
>>>
>>> <ATT169162.txt>
>>
>>
