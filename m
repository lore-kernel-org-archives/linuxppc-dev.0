Message-ID: <37B8ACB1.66F12EE@natinst.com>
Date: Mon, 16 Aug 1999 19:28:34 -0500
From: "Brian K. Neidig" <brian.neidig@natinst.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Questions regarding LinuxPPC and Mot 860TFADS
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I am trying to get the 2.2.5 (retrieved from the Linux embedded ftp
site) version of the kernel working with an 860T processor and the FADS
board.  After reading much discussion on this list, I have the following
problems/questions.

I am compiling on a native LinuxPPC Mac. It is running 2.2.10.  After a
few compiler problems early on, it compiles fine.

1) I've seen people being successful with an 823FADS board.  Has ANYONE
ever gotten an 860TFADS running?!?  If you have, what version of the
kernel are you using?

2)  I am trying to mount an nfs root partition.  I ran into the same
problems <tharvan@ellemedia.com> and <helmut.buchsbaum@siemens.at> did.
I put in the code for Helmut's fix.  Then I encountered another
problem.  (Helmut, you mention that you replaced the 'tlbia' instruction
with the tlbia macro.  I assume that you did this in ALL places in the
code that uses tlbia?  I tried it both ways (only in head.S and then
everywhere), but either way, I don't go any further.

3) I have tried in the init function SASH (as originally done in the
code), /bin/sh, and a couple of VERY simple (but not shell!) programs,
just to see if things would change.  I continue to get a
bad_page_fault.  I'll include a MASSIVE log of printks that I am trying
to use to find my problem, in case anybody can get any insight into this
problem.

4)  I have been reading about CACHE LINE problems with Libc.  Will these
problems be affecting me now at this stage (trying to get a shell
running)?  It seems that others did NOT have this problem, or they would
have mentioned it.

Thanks for any suggestions and SORRY FOR THE HUGE LETTER!


I've included below my .config and printk dump.

********************************
.CONFIG:
********************************
#
# Platform support
#
CONFIG_PPC=y
# CONFIG_6xx is not set
CONFIG_8xx=y
# CONFIG_MPC821 is not set
# CONFIG_MPC823 is not set
# CONFIG_MPC850 is not set
# CONFIG_MPC860 is not set
CONFIG_MPC860T=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_PMAC is not set
# CONFIG_PREP is not set
# CONFIG_CHRP is not set
# CONFIG_ALL_PPC is not set
# CONFIG_APUS is not set
# CONFIG_MBX is not set
# CONFIG_RPXLITE is not set
# CONFIG_RPXCLASSIC is not set
CONFIG_FADS=y
# CONFIG_BSEIP is not set
# CONFIG_SMP is not set
CONFIG_MACH_SPECIFIC=y

#
# General setup
#
CONFIG_EXPERIMENTAL=y
# CONFIG_MODULES is not set
# CONFIG_PCI is not set
# CONFIG_PCI_QUIRKS is not set
CONFIG_NET=y
# CONFIG_SYSCTL is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_BINFMT_JAVA is not set
# CONFIG_PARPORT is not set
# CONFIG_VGA_CONSOLE is not set
# CONFIG_FB is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_IDE is not set

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_ONLY is not set

#
# Additional Block Devices
#
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
# CONFIG_BLK_DEV_XD is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
# CONFIG_PACKET is not set
# CONFIG_NETLINK is not set
# CONFIG_FIREWALL is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_SYN_COOKIES is not set

#
# (it is safe to leave these untouched)
#
CONFIG_INET_RARP=y
# CONFIG_SKB_LARGE is not set
# CONFIG_IPV6 is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_BRIDGE is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
# CONFIG_CPU_IS_SLOW is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_ETHERNET=y
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_RTL8139 is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_EISA is not set
# CONFIG_NET_POCKET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_DLCI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set
# CONFIG_TR is not set
# CONFIG_SHAPER is not set
# CONFIG_RCPCI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Console drivers
#

#
# Character devices
#
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_UNIX98_PTYS is not set
# CONFIG_MOUSE is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set

#
# Joystick support
#
# CONFIG_JOYSTICK is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_NLS is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set


**********************************
PRINTK:
**********************************
314 (egcs-1.1.2 release)) #359 Sat Aug 14 20:54:59 CDT 1999
Boot arguments: root=/dev/nfs nfsroot=/mnt/wince
nfsaddrs=130.164.54.46:130.164.
49.193:130.164.54.1:255.255.255.0:wince:fec
REQUEST IRQ: 5 at c0096678 for cpm
Installing handler c0096708 at vector 0
time_init: decrementer frequency = 180000000/60
REQUEST IRQ: f at c0008f28 for tbint
back from console_init! memory_start = c01273f0, memory_end = c1000000
start_kernel, sp = c00cab90
Calibrating delay loop... 0.00 BogoMIPS
Memory: 15200k available (624k kernel code, 528k data, 32k init)
[c0000000,c1000
000]
POSIX conformance testing by UNIFIX


Calling kernel_thread for init!

SYS_CLONE!


Copy thread: usp = c00cab90

Leaving copy_thread.  SP = c012bf40
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP


Calling kernel_thread for bdflush!

SYS_CLONE!


Copy thread: usp = c012bee0

Leaving copy_thread.  SP = c013df40
Starting kswapd v 1.5


Calling kernel thread for kpiod!

SYS_CLONE!


Copy thread: usp = c012bee0

Leaving copy_thread.  SP = c013bf40


Calling kernel thread for kswapd!

SYS_CLONE!


Copy thread: usp = c012bee0

Leaving copy_thread.  SP = c0139f40
In device_setup.
Calling chr_dev_init
Back from chr_dev_init, calling blk_dev_init.
RAM disk driver initialized:  16 RAM disks of 4096K size
Back from blk_dev_init. calling sti!
Back from STI!
Calling net_dev_init!
Allocated memory, fep = c0129260
fecp = 2200e00
PKT_MAXBLR_SIZE = 5f0, PKT_MAXBUF_SIZE = 5ee
RX_RING_SIZE = 8, TX_RING_SIZE = 8
Value written out is: 50460002
B4: fec_ievent = 0
fec_ievent = a00000, mask = 800000
ievent = a00000:    Read MII register 17:    result = 50460002
About to read MII register 17...
B4: fec_ievent = 0
fec_ievent = a00000, mask = 800000
ievent = a00000:    Read MII register 17:    result = 60460002
Back from ReadMii
REQUEST IRQ: 3 at c0099154 for fec
REQUEST IRQ: 4 at c0099a84 for mii
FEC ENET Version 0.1, 00:80:2f:ff:fe:01
fec: link up,auto complete
fec: 607e0000
In ip_auto_config: ic_myaddr = 82a4362e, root_server_addr = ffffffff,
ic_servadd
r = 82a431c1, INADDR_NONE = ffffffff
Back from net_dev_init!
setting up gendisk! 0
CONFIG_BLK_DEV_RAM is defined!
CONFIG_BLK_DEV_INITRD is defined, but we knew that!
Calling rd_load!
Back from rd_load!
CONFIG_ROOT_NFS
UNNAMED_MAJOR
Got an fs_type = c00cf328
Calling vfsmnt
__getname returns ÿÿÿÿÿÿ
calling do_getname.
in do_getname.
returning from getname.
__getname returns /dev/root
calling do_getname.
in do_getname.
returning from getname.
vfsmnt returns c0127000
Root-NFS: Mounting /mnt/wince on server 130.164.49.193 as root
Root-NFS:     rsize = 4096, wsize = 4096, timeo = 7, retrans = 3
Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
Looking up port of RPC 100003/2 on 130.164.49.193
Root-NFS: Portmapper on server returned 2049 as nfsd port
Looking up port of RPC 100005/1 on 130.164.49.193
Root-NFS: mountd port is 635
NFS:      nfs_mount(82a431c1:/mnt/wince)


Calling kernel_thread for rpciod

SYS_CLONE!


Copy thread: usp = c012bd80

Leaving copy_thread.  SP = c0fd5f40
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 32k init


Calling kernel_thread for do_linux_sash!

SYS_CLONE!


Copy thread: usp = c012bf10

Leaving copy_thread.  SP = c00d7f40




Returned from do_linux_sash!





PID = 6
PID > 0.  Going in!
in sys_open: filename = /dev/ttyS0
__getname returns ?
calling do_getname.
in do_getname.
returning from getname.
getname returns c00d5000 (/dev/ttyS0)
PTR_ERR returns -1072869376
NOT IS_ERR(tmp) and continuing....
get_unused_fd returns 0
filp_open: filename = /dev/ttyS0, flags = 2, mode = 0
filp_open: get_empty_filp returns c0fd1060
Calling open_namei!
open_namei returns c0fd2160
May go to cleanup_file
didn't goto cleanup_file!
FMODE_WRITE is set!
May goto cleanup_dentry!
Didn't goto cleanup_dentry!
checking for op and open function!
Trying to open!
May goto cleanup_all!
In cleanup_all!
in cleanup_dentry!
in cleanup_file!
at out!
fd > 0= 0! Just called filp_open and it returns ffffffed
Got an erro1!
in out_error!
returning -19
Calling execve for /bin/sh!
In execve! program = /bin/sh, param1 = c00c7220, param2= c00c7248
__getname returns /dev/ttyS0
calling do_getname.
in do_getname.
returning from getname.
Just called getname.  filename is c00d5000 (/bin/sh)
Calling do_execve for /bin/sh!
Just inside do_execve! filename = /bin/sh
Just cleaned out the page-table.
return from PTR_ERR s c0fd2260
count(argv = 1
count(envp) = 2
Calling prepare_binprm!
read_exec A: offset = 0, addr = c00d7cd8, count = 80, to_kmem = 1
read_exec B read_exec C read_exec D read_exec E read_exec F result of
read is 80

addr = c00d7cd8, count = 80, pos = 0
read_exec H read_exec I Back from prepare_binprm! retval = 80
Just copied the strings!
About to call search_binary_handler!
search_binary_handler #0
function is c0035684
Calling the function c0035684
back from calling function c0035684, retval = fffffff8
function is c0033ab8
Calling the function c0033ab8
got elf_header!
checked for ELF!
correct exec type!
correct arch.
Correct d_inode stuff.
Just alloced c01294a0 of c0 bytes for header. Calling read exec of this
size.
read_exec A: offset = 34, addr = c01294a0, count = c0, to_kmem = 1
read_exec B read_exec C read_exec D read_exec E read_exec F result of
read is c0

addr = c01294a0, count = c0, pos = 0
read_exec H read_exec I Back from read_exec. Retval = c0
Opening dentry.
Back from opening dentry.  Retval = 0
file = c0fd1060
in for loop 0
in for loop 1
PT_interp
Will we goto?
Apparently not!
elf_interpreter = c01337e0
another read_exec!
  size = d, memory = c01337e0
read_exec A: offset = 114, addr = c01337e0, count = d, to_kmem = 1
read_exec B read_exec C read_exec D read_exec E read_exec F result of
read is d
addr = c01337e0, count = d, pos = 0
read_exec H read_exec I Back from read_exec, retval = 1
Elf_interpreter: /lib/ld.so.1
read_exec A: offset = 0, addr = c00d7cd8, count = 80, to_kmem = 1
read_exec B read_exec C read_exec D read_exec E read_exec F result of
read is 80

addr = c00d7cd8, count = 80, pos = 0
read_exec H read_exec I in for loop 2
in for loop 3
in for loop 4
in for loop 5
out of for loop!
interpreter is...
bprm->sh_bang = 0
Apparently, we go into here...
Calling flush_old_exec...
flush_old_exec: sp = c00d7b40!
FOE enter
Calling make_private_signals
returned from make_private_signals = 0
flush_old_exec: sp = c00d7b40!
Calling exec_mmap
atomic_read = 7, smp_processor_id() = 0
mm_alloc returns c0fcd060
 Calling copy_segments, nr = 6, current = c00d6000, mm = c0fcd060,
&task[0] = c0
0cb19c, current->tarray_ptr = c00cb1b4
new_page_tables returns 0
Back from exec_mmap, retval = 1
flush_old_exec: sp = c00d7b40!
Pt of no return!
flush_old_exec: sp = c00d7b40!
Back from PONR!
name = c00d5000
flush_old_exec: sp = c00d7b40!
calling flush_thread!
Back from flush_thread!
flush_old_exec: sp = c00d7b40!
flush_old_exec: sp = c00d7b40!
calling flush_signal_handlers
flush_old_exec: sp = c00d7b40!
Back from flush_signal_handlers. calling flush_old_files.
files->max_fds = 400, NFDBITS = 20
FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6
FOF 1 FOF3
 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3
FOF4, set
 = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set =
0 FOF5
FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5
FOF6 FOF 1
 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1
FOF3 FOF4
, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4,
set = 0
FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0
FOF5 FOF6
FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6
FOF 1 FOF3
 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3
FOF4, set
 = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set =
0 FOF5
FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5
FOF6 FOF 1
 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1
FOF3 FOF4
, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4,
set = 0
FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0 FOF5 FOF6 FOF 1 FOF3 FOF4, set = 0
FOF5 FOF6
FOF 1 FOF 2 FOF9 Back from flush_old_files.
Back from flush_old...  Retval = 0
The point of no return....
SET_PERSONALITY done
load_bias = 100
Setting up the mmap!
Setting up the mmap!
Setting up the mmap!
Setting up the mmap!
Setting up the mmap!
Setting up the mmap!
elf_entry = 180f214, elf_bss = 18c8730, elf_brk = 18cc944, start_code =
1800000,
 end_code = 18c8730, end_data = 18c8730
read_exec A: offset = 34, addr = c0fdc0c0, count = 60, to_kmem = 1
read_exec B read_exec C read_exec D read_exec E read_exec F result of
read is 60

addr = c0fdc0c0, count = 60, pos = 0
read_exec H read_exec I PF: address: 30056578 nip:c000a89c code:
000048a6 data
 GOOD_AREA!
PF: address: 30056578 nip:c000a89c code: 82000000 write I/O data
 GOOD_AREA!
Just freed the interpreter!
 freeing elfdata
more to do!
even more...
PF: address: 018c8730 nip:c000a89c code: 000048a6 data
 GOOD_AREA!
PF: address: 018c8730 nip:c000a89c code: 82000000 write I/O data
 GOOD_AREA!
(start_brk) 18cc944
(end_code) 18c8730
(start_code) 1800000
(end_data) 18c8730
(start_stack) 7fffff40
(brk) 18cc944
PF: address: 01800000 nip:c00345ac code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 01800000 nip:c00345ac code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
7f454c46
01020100
00000000
00000000
00020014
00000001
0180f214
00000034
0008a1bc
00000000
00340020
00060028
001d001c
00000006
00000034
01800034
01800034
000000c0
000000c0
00000005
Calling start_thread!
In start_thread: regs = c00d7e70, nip = 300106f8, sp = 7fffff40
Calling shove_aux_table
Back from shove_aux_table
back from calling function c0033ab8, retval = 0
Back from call to search_binary_handler, retval = 0!
returning retval!
PF: address: 300106f8 nip:300106f8 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 300106f8 nip:300106f8 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30002a60 nip:30002a60 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30055dc4 nip:30055dc4 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30055d70 nip:30002bdc code: 82000000 write I/O data
 GOOD_AREA!
PF: address: 30001508 nip:30002dac code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 30001508 nip:30002dac code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 30000362 nip:30002dd4 code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 30000362 nip:30002dd4 code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 300118f0 nip:300118f0 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 300118f0 nip:300118f0 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000a32c nip:3000a32c code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000df3c nip:3000df3c code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000e000 nip:3000e000 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000e000 nip:3000e000 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 300129ac nip:300129ac code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 300129ac nip:300129ac code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 300031c4 nip:300031c4 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 300031c4 nip:300031c4 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30004a84 nip:30004a84 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30004a84 nip:30004a84 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000f4d0 nip:3000f4d0 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000f4d0 nip:3000f4d0 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30053f08 nip:30010afc code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 30053f08 nip:30010afc code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 018c7db8 nip:30003690 code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 018c7e14 nip:3000375c code: 82000000 write I/O data
 GOOD_AREA!
PF: address: 30005c18 nip:30005c18 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30005c18 nip:30005c18 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3005466c nip:30005d64 code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 3005466c nip:30005d64 code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 300063e0 nip:300063e0 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 300063e0 nip:300063e0 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000c490 nip:3000c490 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000c490 nip:3000c490 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
in sys_open: filename = /etc/ld.so.preload
__getname returns ÿύπ
calling do_getname.
in do_getname.
returning from getname.
getname returns c0fa0000 (/etc/ld.so.preload)
PTR_ERR returns -1057357824
NOT IS_ERR(tmp) and continuing....
get_unused_fd returns 0
filp_open: filename = /etc/ld.so.preload, flags = 0, mode = 3
filp_open: get_empty_filp returns c0fd1160
Calling open_namei!
open_namei returns fffffffe
May go to cleanup_file
in cleanup_file!
at out!
fd > 0= 0! Just called filp_open and it returns fffffffe
Got an erro1!
in out_error!
returning -2
PF: address: 3000b000 nip:3000b000 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 3000b000 nip:3000b000 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 01808358 nip:30010944 code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 300079c8 nip:300079c8 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30008048 nip:30008048 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
PF: address: 30008048 nip:30008048 code: 4000d032 604 tlb&htab miss
instr
 GOOD_AREA!
in sys_open: filename = /etc/ld.so.cache
__getname returns nd
calling do_getname.
in do_getname.
returning from getname.
getname returns c0f98000 (/etc/ld.so.cache)
PTR_ERR returns -1057390592
NOT IS_ERR(tmp) and continuing....
get_unused_fd returns 0
filp_open: filename = /etc/ld.so.cache, flags = 0, mode = 1
filp_open: get_empty_filp returns c0fd1160
Calling open_namei!
open_namei returns c0fd2560
May go to cleanup_file
didn't goto cleanup_file!
checking for op and open function!
fd > 0= 0! Just called filp_open and it returns c0fd1160
Calling fd_install!
Back from fd_install!
returning 0
PF: address: 30014000 nip:30011310 code: c0000000 604 tlb&htab miss I/O
data
 GOOD_AREA!
PF: address: 66014008 nip:300081bc code: 0001800b data
Inside expand_stack:
address(66014008) &= PAGE_MASK(fffff000) = 66014000
vma = c0fcb020, vm_start = 7ffff000
grow = 19feb000
vma->vm_end = 80000000
current->rlim[RLIMIT_STACK(3)].rlim_cur = 800000
vma->vm_mm->total_vm = a8, PAGE_SHIFT = c, << = a8000
+ grow = 1a093000
current->rlim[RLIMIT_AS(9)].rlim_cur = 7fffffff
if (vma->vm_end - address >
(unsigned long) current->rlim[RLIMIT_STACK].rlim_cur ||
(vma->vm_mm->total_vm << PAGE_SHIFT) + grow >
(unsigned long) current->rlim[RLIMIT_AS].rlim_cur)
returning ENOMEM!
expand_stack returns non-zero!
 BAD_AREA!
in bad_page_fault!
calling force_sig
back from force_sig
wait returns and pid = 6, i = b


About to return from this stuff!

Leaving INIT!
Kernel panic: No init found.  Try passing init= option to kernel.
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<2>Kernel stack overflow in process c012a000,
r1=c012a
3c0
NIP: 00000004 XER: E000807F LR: 00000001 REGS: c012a310 TRAP: 1000
MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
PF: address: 0000103e nip:c0005044 code: 000000eb data






[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
