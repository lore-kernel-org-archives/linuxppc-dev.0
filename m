Message-ID: <3AD35C40.D36960C6@fynu.ucl.ac.be>
Date: Tue, 10 Apr 2001 21:17:21 +0200
From: Alain NINANE <Alain.Ninane@fynu.ucl.ac.be>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, grant@lcse.umn.edu
Subject: set_context issue when porting linux to PLX IOP 480
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm currently trying to port the linux kernel to some home-made board based on
the PLX IOP 480 chip.  The boot and the setup of the basic components of the
board and the kernel are quite succesfully working (except the on board ethernet
controller but I don't care for now) until I try to start a shell from my initrd
ram disk.

Before continuing, let me describe my software setup.  I have the 2.2.14 kernel
with the 4xx patch 4xx-patch-2.2.14-20000112.gz (from Grant Erickson ?).  I have
modified treeboot files to fit my boot process and I have modified mm/init.c to
take into account my hardware configuration (32 MB RAM, serial line controller
at address ....).

The problem I have is the following.  As you can see at the console output at
the end of this message, the TLB is configured during the initial boot process.
Things are being configured smoothly but when I try to execute /bin/sh from the
ramdisk, the software (fs/exec.c + fs/binfmt_elf.c) at some point calls
set_context which resolves eventually in kernel/head_4xx.S in call to tlbia to
invalidate the TLB.  At this point, the system freeze completely.

I'm not an expert in this field but this is not so astonishing for me because
that means that no address translation could be performed anymore.  My question
are the following ?  Who is in charge of setting the TLB again ?  Does the TLB
has to be updated at each contexct switch ?  I guess that a TLB fault should
generates some exception but the 4xx_tlb.c has the tlbMiss instructions
commented and I do not see any code to link them to the exception handler.  What
am I doing wrong ?

Can you help me to fix those points ?

Thank you very much in advance,

Alain NINANE

<----------------- Console output
------------------------------------------------------>
Initial RAM disk at 0x01f00000 (1048576 bytes)
PPC4xx_tlb_pin: c0000000 -> 00000000 in entry 0...
PPC4xx_tlb_pin: c1000000 -> 01000000 in entry 1...
PPC4xx_tlb_pin: 80000000 -> 10000000 in entry 2...
PPC4xx_tlb_pin: 81000000 -> 50000000 in entry 3...
PPC4xx_tlb_pin: 8e000000 -> fe000000 in entry 4...
PPC4xx_tlb_pin: 8d000000 -> fd000000 in entry 5...
Linux version 2.2.14 (nina@fynulap1) (gcc version 2.95.2 19991024 (release)) #95
Calibrating delay loop... 9.83 BogoMIPS
Memory: 30396k available (676k kernel code, 636k data, 36k init)
[c0000000,c2000000]
Dentry hash table entries: 4096 (order 3, 32k)
Buffer cache hash table entries: 32768 (order 5, 128k)
Page cache hash table entries: 8192 (order 3, 32k)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
pci_scan_bus for bus 0
PCI: 00:30 [1011/0019]
PCI: pci_scan_bus returning with max=00
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 32768 bhash 32768)
Starting kswapd v 1.1.1.1
Shoulda called rs_init...
Serial driver version 4.27 with no serial options enabled
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
IP-Config: Entered.
IP-Config: No network devices available.
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 1024 blocks [1 disk] into ram disk... done.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 36k init
arch/ppc/kernel/process.c: do_execve (/bin/sh)
fs/exec.c: do_execve - open_name (/bin/sh) ok
fs/exec.c: exec_mmap - get_mmu_context
fs/exec.c: exec_mmap - set_context(1794)

--
Dr Alain H. Ninane  - University of Louvain - Nuclear Physics Department
Ch. du cyclotron, 2 - 1348 Louvain-la-Neuve - BELGIUM - +32-10-47.32.73
http://www.fynu.ucl.ac.be - http://fynulap1.fynu.ucl.ac.be (when up!)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
