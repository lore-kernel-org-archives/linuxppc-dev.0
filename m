Date: Fri, 14 Jan 2000 20:59:01 +0000
From: "Robin O'Leary" <robin@equiinet.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can't start init.
Message-ID: <20000114205901.A21602@mail.ro.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Now we have resolved various hardware mistakes, our 860T board is booting
a lightly modified 2.3.18 kernel all the way up to init.  It succeeds
in doing bootp, mounting a remote NFS drive, opening /dev/console and
trying to load /sbin/init.  At this point, it gets stuck in an infinite
loop handling page faults.

Tracing exactly how it fails points at the first write access to
user space.  The kernel has read the first page of init (which is a
tiny little ``hello world'' program) and is just about to set up the
process' stack.  Enabling the various existing debug printks and a liberal
sprinkling of new ones shows the problem starts with create_elf_tables()
in fs/binfmt_elf.c doing
	NEW_AUX_ENT(0, AT_NULL, 0);
to write the 4-byte value 0 at address 0x7fffffb4.  This understandably
causes a TLB miss which invokes do_page_fault() in arch/ppc/mm/fault.c .
When I enable the debug in do_page_fault(), it says that the error code
it got is 0x000009ff or 0x00000a1f, neither of which look like they
could have come from a page fault.  Apart from this, do_page_fault()
seems to do sensible things, calling handle_mm_fault() and returning OK.
Then exactly the same page fault happens again and again...

Have a got the above sequence right?

I'm stuck.  Any ideas?

Robin O'Leary.
-- 
email: robin@equiinet.com  Equiinet Ltd., Innovation Centre, Singleton Park,
Tel.:  +44 1792 540008     Swansea  SA2 8PP, Wales, U.K.  51.6101N 3.9831W
--
Netpilot Rom 0.7-9600
ram clear
rmon> load vmlinux
rmon> go 0
bdinfo: 003f0000
memory: 00000000 +02000000
initrd: none
command: 003f0010
Starting 00000000
Before lock
After lock
Linux version 2.3.18 (robin@weeble.i2it.co.uk) (gcc version egcs-2.91.66 1999031
4 (egcs-1.1.2 release)) #88 Fri Jan 14 19:49:39 GMT 2000
Boot arguments:  console=ttyS0
time_init: decrementer frequency = 176250000/60
Calibrating delay loop... 46.28 BogoMIPS
Memory: 31116k available (740k kernel code, 872k data, 40k init) [c0000000,c2000
000]
Buffer-cache hash table entries: 2048 (order: 1, 8192 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (established 2048 bind 4096)
Starting kswapd v1.6
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: registered device at major 7
Initialising FEC with the IMAP at 0xFF000000
FEC ENET Version 0.1, 08:00:3e:26:15:59
fec: Isolated status
fec BMCR: 100Mbit, autoneg, full duplex,
fec BMSR: extended, link down, can autoneg, amble suppress.
fec auto detect:
fec BMCR: autoneg,
fec BMSR: extended, link up, can autoneg, auto complete, amble suppress.
fec auto detect: 10baseT
PPP generic driver version 2.4.0
RTNL: assertion failed at devinet.c(784):inetdev_event
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 212.250.92.2, my address is 212.250.92.149
Looking up port of RPC 100003/2 on 212.250.92.2
Looking up port of RPC 100005/1 on 212.250.92.2
VFS: Mounted root (NFS filesystem) readonly.
Freeing unused kernel memory: 40k init
execute_command=null
exec /sbin/init
load_elf_binary: read header, consistecy, setup args, flush, personality, load_b
ias, mmap0, do_mmap, mmap1, do_mmap, set_fs, load interpreter, kfree, compute_cr
eds, create_elf_tables,

create_elf_tables: hwcap=0x0 k_platform=0x0, force align, interpret to stack, AT
_NULL
before NEW_AUX_ENT: sp=7fffffb4
before __put_user_size(x=00000000 ptr=7fffffb4 size=4 retval=0)

do_page_fault: address: 7fffffb4 nip:c003c2bc code: 000009ff data trap:00000300
mm=c00f1040 vma=c00ef020 address=7fffffb4
good area
a write
handle mm fault
handle_mm_fault: tsk=c011a000 vma=c00ef020  address=7fffffb4 write_access=200000
0
pgd_offset=c00f07fc
pmd_alloc=c00f07fc
pte_alloc=c00eeffc
handle_pte_fault: spin_unlock
finished.

do_page_fault: address: 7fffffb4 nip:c003c2bc code: 000009ff data trap:00000300
mm=c00f1040 vma=c00ef020 address=7fffffb4
good area
a write
handle mm fault
handle_mm_fault: tsk=c011a000 vma=c00ef020  address=7fffffb4 write_access=200000
0
pgd_offset=c00f07fc
pmd_alloc=c00f07fc
pte_alloc=c00eeffc
handle_pte_fault: spin_unlock
finished.
...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
