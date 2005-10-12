Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.35])
	by ozlabs.org (Postfix) with ESMTP id CBFAC684E4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 20:35:13 +1000 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 062D225C052
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 12:02:01 +0200 (CEST)
Message-ID: <434CDF76.3080705@cpe.fr>
Date: Wed, 12 Oct 2005 12:03:34 +0200
From: Nathael PAJANI <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: init process not running
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm porting the kernel (tried a 2.6.9 and 2.6.13) to an ACTIS Computer 
board (MPC8560, e500 core), and I have a strange problem.

Everything seems all right, but the init process does not start.

I have an echo from the tty (cpm2 SCC1), so the kernel is not crashed.
I even got the ticker.

I first thought I had a problem with the console but if I use another 
init process (using another process from the ramdisk, mke2fs), nothing 
happens either.
I tried to replace the init process by another process which simply 
returns (eventually after a printf("Hello world") ), so the kernel would 
panic, but still nothing.
Tried to create a syscall which reboots the board, and call it from the 
hello_world, nothing.
Tried to use an "init=/unexisting/process", and this skips to the next 
possibility (/sbin/init), so the ramfs seem good, tried another ramfs, 
which is running correctly on annother ppc board, but still the same 
problem.

anyhow the "do_execve" is successfull.

The scheduler seems to be scheduling pid 3 and 8, it tries to wake up 
pid 1, but its "old_state" is 0.
changing the state to 1 in "start_thread" does not fix this.

when a task is created, usualy "wake_up_new_task" is called, but not 
here (but this is the first task using execve).

Does anyone have a clue about what I did wrong, or where and what to 
look at?

Thanks a lot for your help.
Following two traces of the boot process, one with the 2.6.9, one with 
the 2.6.13.2



Here is a trace of the boot process with the 2.6.9 kernel
(# represent the second):

Loading ELF headers...done

Loading segment #0 at
0x00800000....................................................................................e
Loading extra data at 0x00a33000....done

Lowest address:  0x00800000
Entry address:   0x00800000
Highest address: 0x00a3474e
Bytes loaded:    2312014

loaded at:     00800000 00A353CC
board data at: 00A3312C 00A3334C
relocated to:  00805090 008052B0
zimage at:     00805A21 00892EB8
initrd at:     00893000 00A32F88
avail ram:     00A36000 20000000

Linux/PPC load: rw console=ttyS0 root=/dev/ram0 init=/sbin/nath

Uncompressing Linux...done

Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.9-3 #174 Thu Oct 6 11:34:23 CEST 2005
cpm2_immr address (0xfff80000) remapped to 0xfdfc0000
Built 1 zonelists
Kernel command line: rw console=ttyS0 root=/dev/ram0 init=/sbin/nath
OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fdb7d000
PID hash table entries: 4096 (order: 12, 65536 bytes)
###Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
#Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
#Memory: 516096k available (888k kernel code, 340k data, 68k init, 0k 
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NATH: rest_init: going to kernel_thread
checking if image is initramfs...##########it isn't (no cpio magic); 
looks like an initrd
Freeing initrd memory: 1663k freed
Linux NoNET1.0 for Linux 2.6
#<6>PCI: Probing PCI hardware
Serial: CPM driver $Revision: 0.01b $
ttyS0 at MMIO 0xfdfd1a00  (irq = 40) is a CPM UART
#RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
###########VFS: NATH: fs_names = ext2, name = /dev/root
VFS: Mounted root /dev/root (ext2 filesystem).
NATH: init: run_init_process, /sbin/nath
NATH: init: run_init_process, /sbin/init
#####################################################################




Here is a trace of the boot process with the 2.6.13 kernel:

Loading ELF headers...done

Loading segment #0 at 
0x00800000...........................................................................e
Loading extra data at 0x00a41000........................done

Lowest address:  0x00800000
Entry address:   0x00800000
Highest address: 0x00a6ad8e
Bytes loaded:    2534798

loaded at:     00800000 00A433CC
board data at: 00A4112C 00A4134C
relocated to:  00805090 008052B0
zimage at:     00805A71 008A020B
initrd at:     008A1000 00A40F88
avail ram:     00A44000 20000000

Linux/PPC load: rw console=ttyS0 root=/dev/ram
Uncompressing Linux...done.
Now booting the kernel
Memory CAM mapping: CAM0=256Mb, CAM1=256Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.13-3 (nathael@linux-bbe) (gcc version 3.3.3) #62 Wed 
Oct 12 10:43:49 CEST 2005
cpm2_immr address (0xfff80000) remapped to 0xfdfc0000
Built 1 zonelistchecking if image is initramfs...it isn't (no cpio 
magic); looks like an initrd
Freeing initrd memory: 1663k freed
s
Kernel command line: rw console=ttyS0 root=/dev/ram
OpenPIC Version 1.2 (1 CPUs and 44 IRQ sources) at fdb7d000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515968k available (952k kernel code, 484k data, 88k init, 0k 
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 1663k freed
Linux NoNET1.0 for Linux 2.6
PCI: Probing PCI hardware
Macintosh non-volatile memory driver v1.1
Serial: CPM driver $Revision: 0.01b $
ttyS0 at MMIO 0xfdfd1a00 (irq = 40) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 88k init
NATH: init: run_init_process, /sbin/init
NATH: sys_execve called.
NATH: do_execve: prepare_binprm done

NIP: 10000100 LR: 00000000 SP: 7F9ECF10 REGS: c089ff00 TRAP: 0c01    Not 
tainted
MSR: 0002d002 EE: 1 PR: 1 FP: 0 ME: 1 IR/DR: 00
TASK = c0a4eb70[1] 'init' THREAD: c089e000
State: 0
Last syscall: 11
GPR00: 00000000 7F9ECF10 00000000 00000000 00000000 00000000 00000000 
00000000
GPR08: 00000000 00000000 00000000 00000000 00000000
NIP [10000100] 0x10000100
LR [00000000] 0x0

NATH: load_elf_binary: OK
NATH: do_execve: success.
NATH: sys_execve: end.
NATH: try_to_wake_up, pid: 1, old_state: 0, state_mask: 1
NATH: try_to_wake_up, pid: 1, old_state: 0, state_mask: 1
NATH: try_to_wake_up, pid: 1, old_state: 0, state_mask: 1
NATH: try_to_wake_up, pid: 1, old_state: 0, state_mask: 1
NATH: try_to_wake_up, pid: 1, old_state: 0, state_mask: 1
NATH: try_to_wake_up, pid: 8, old_state: 1, state_mask: 15
NATH: activate_task, pid: 8, state: 1
NATH: try_to_wake_up, pid: 3, old_state: 1, state_mask: 3
NATH: activate_task, pid: 3, state: 1
.......



Nathaël PAJANI
CPE Lyon
