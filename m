To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Wild Pointer!!!! ( some more info ) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Oct 2001 21:41:20 +1000."
             <15316.1504.603255.831736@cargo.ozlabs.ibm.com>
Date: Mon, 22 Oct 2001 15:49:38 +0200
Message-Id: <20011022134943.B762D10CD6@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <15316.1504.603255.831736@cargo.ozlabs.ibm.com> you wrote:
>
> >           I recently ported the linux kernel v 2.4.11-pre5  to MDPPro (
> >   MPC860T processor ) board..the kernel dies with an Oops and everytime at a
> >   different place.... i have taken the code from bitkeeper
>
> The linuxppc_2_4 tree or the linuxppc_2_4_devel tree?  Have you made
> local changes?  If so what are they?

I see similar effects from linuxppc_2_4_devel (CS 1.592); I've traced
a few of them down;  they  are  "strange"  -  usually  it's  a  store
operation into a normal variable in BSS.

One example - this is on a custom MPC823-E system; I,m running  older
kernel versions on it without problems.

...
Linux version 2.4.13-pre5 (wd@denx.denx.de) (gcc version 2.95.3 20010315 (release/MontaVista)) #1 Mon Oct 22 15:05:53 MEST 2001
...
lcd823.c[667] call register_framebuffer()
fbmem.c[719]: register_framebuffer ENTER
fbmem.c[728]: register FB#0 max=32 [struct @ c0188900]
Oops: kernel access of bad area, sig: 11
NIP: C00ADC80 XER: C000247F LR: C00ADC7C SP: C0235F30 REGS: c0235e80 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: C0188900, DSISR: 82000000
TASK = c0234000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C00ADC7C C0235F30 C0234000 00000039 00001032 00000001 00000030 00000039
GPR08: FFFFFFFF C0160000 00000654 C0235E60 C02281D0 00000000 00FE0A00 007FFF00
GPR16: FFFFFFFF 00FD9DCC 00000000 00F9F3F8 00000001 00F9F7C0 00F9F3F8 00FE1564
GPR24: C0130000 C0130000 C018D8E8 00000000 C0130000 C0188900 C0130000 00000000
Call backtrace:
C00ADC7C C015EE84 C015CE34 C01597E4 C015471C C015476C C00022B4
C0004BD4

...
Reading symbols from System.map
C00ADC7C C015EE84 C015CE34 C01597E4 C015471C C015476C C00022B4
C0004BD4
0xc00adc7c -- 0xc00adbbc + 0x00c0   register_framebuffer
0xc015ee84 -- 0xc015ed20 + 0x0164   lcd823_init
0xc015ce34 -- 0xc015cd50 + 0x00e4   fbmem_init
0xc01597e4 -- 0xc0159798 + 0x004c   chr_dev_init
0xc015471c -- 0xc01546f4 + 0x0028   do_initcalls
0xc015476c -- 0xc0154744 + 0x0028   do_basic_setup
0xc00022b4 -- 0xc00022a0 + 0x0014   init
0xc0004bd4 -- 0xc0004ba8 + 0x002c   kernel_thread

-> grep registered_fb System.map
...
c0166498 B num_registered_fb
c0188900 B registered_fb



>From "drivers/video/fbmem.c":
    319
    320 struct fb_info *registered_fb[FB_MAX];
    321 int num_registered_fb;
    322 extern int fbcon_softback_size;
    ...
    727         fb_info->node = MKDEV(FB_MAJOR, i);
    728 printk("%s[%d]: register FB#%d max=%d [struct @ %p]\n",__FILE__,__LINE__,i,FB_MAX,&registered_fb[i]);
    729
    730         registered_fb[i] = fb_info;
    731
    732 printk("%s[%d]\n",__FILE__,__LINE__);
    ...

As you can see it crashes when trying to store the info pointer  into
registered_fb[0]  (line  #  730)  -  the debug messages and the crash
(with DAR pointing to C0188900 = address of registered_fb) are clean,
but I don't know (yet) WHY this happens.

In other cases (without frambuffer driver) the kernel boots,  but  is
not stable; for instance:

...
INIT: version 2.78 booting
Activating swap...
Checking all file systems...
Parallelizing fsck version 1.19 (13-Jul-2000)
Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: C01370CC XER: 00000000 LR: C004C22C SP: C0D05EF0 REGS: c0d05e40 TRAP: 1000    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0d04000[32] 'mount' Last syscall: 21
last math 00000000 last altivec 00000000
GPR00: 00000100 C0D05EF0 C0D04000 C0C9B000 10020FF4 00000000 C0C9BE8C 00000000
GPR08: 00000000 00000000 00000000 00000004 44000088 10026370 00000000 00000000
GPR16: 7FFFFC6C 7FFFFC68 10020000 00000000 00009032 00D05F40 00000000 C00026E8
GPR24: C0002460 10020110 7FFFFEB3 C0D05F18 C0C9B000 44000088 10020168 00001000
Call backtrace:
C004C1C8 C004C494 C00024BC FFFFFFFF 10002604 10003148 10003DD0
10004BA0 0FED9DBC 00000000
/etc/init.d/rcS: line 34:    32 Floating point exceptionmount -t devpts devpts /dev/pts -ogid=${TTYGRP},mode=${TTYMODE}
Mounting local filesystems...
not mounted anything
...
MontaVista Software's Hard Hat Linux 2.0

fast login: root
root@fast:~# mount -t devpts devpts /dev/pts
Oops: Kernel Mode Software FPU Emulation, sig: 8
NIP: C01370CC XER: 00000000 LR: C004C22C SP: C0AE3EF0 REGS: c0ae3e40 TRAP: 1000    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0ae2000[78] 'mount' Last syscall: 21
last math 00000000 last altivec 00000000
GPR00: 00000100 C0AE3EF0 C0AE2000 C0ABF000 10020FFC 00000000 C0ABFE7C 00000000
GPR08: 00000000 00000000 00000000 00000004 44000080 10026370 00000000 00000000
GPR16: 7FFFFC5C 7FFFFC58 10020000 00000000 00009032 00AE3F40 00000000 C00026E8
GPR24: C0002460 10020140 7FFFFE97 C0AE3F18 C0ABF000 44000080 10020180 00001000
Call backtrace:
C004C1C8 C004C494 C00024BC FFFFFFFF 10002604 10003148 10003DD0
10004BA0 0FED9DBC 00000000
Floating point exception

-> backtrace
Reading symbols from System.map
C004C1C8 C004C494 C00024BC
0xc004c1c8 -- 0xc004c190 + 0x0038   copy_mount_options
0xc004c494 -- 0xc004c468 + 0x002c   sys_mount
0xc00024bc -- 0xc00024bc + 0x0000   ret_from_syscall_1

C004C1C8 C004C494 C00024BC
0xc004c1c8 -- 0xc004c190 + 0x0038   copy_mount_options
0xc004c494 -- 0xc004c468 + 0x002c   sys_mount
0xc00024bc -- 0xc00024bc + 0x0000   ret_from_syscall_1



Also, I notice other strange things, for  instance  that  GDB  is  no
longer able to read the kernel images:

-> ppc_8xx-gdb vmlinux
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu --target=powerpc-hardhat-linux"...Segmentation fault (core dumped)

-> powerpc-linux-gdb vmlinux
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu --target=powerpc-linux"...Segmentation fault (core dumped)

-> powerpc-linux-gdb.OLD vmlinux
GNU gdb 4.17.0.11 with Linux support
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu --target=powerpc-linux"...Segmentation fault (core dumped)


Hope this helps.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Our management frequently gets lost in thought.   That's because it's
unfamiliar territory.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
