From: Ruedi.Hofer@ascom.ch
Date: Mon, 17 Jan 2000 15:17:32 +0100 (CET)
Subject: bootp
To: damm@kieraypc01.p.y.ki.era.ericsson.se
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FOH00752H2RGL@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_tszMerbrbW01FmkDjiulgA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_tszMerbrbW01FmkDjiulgA)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Magnus

Up to now i failed getting the bootp (.. and NFS mount) stuff running.

Here some details from the linux configuration:

/etc/bootptab

.default:\
              :sm=255.255.255.0:\
              :gw=10.1.20.2:\
              :ht=ethernet:\
              :bf=null:\
              :sa=10.1.20.2:\
              :td=/tftpboot
ppc:hd=/:ha=08003e261559:tc=.default:ip=10.1.20.1:rp=.:


/etc/exports

/tftpboot       (insecure) 


Output from tcpdump

15:54:14.354341 arp who-has ppc tell rac26090-2
15:54:14.781249 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xbb4be989
secs:5 [|bootp] (DF)
15:54:14.781672 rac26090-2.bootps > ppc.bootpc: xid:0xbb4be989 secs:5
Y:ppc S:rac26090-2 [|bootp]
15:54:19.774334 arp who-has ppc tell rac26090-2
15:54:20.774334 arp who-has ppc tell rac26090-2
15:54:21.561059 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xbb4be989
secs:12 [|bootp] (DF)
15:54:21.561475 rac26090-2.bootps > ppc.bootpc: xid:0xbb4be989 secs:12
Y:ppc S:rac26090-2 [|bootp]
15:54:26.554328 arp who-has ppc tell rac26090-2
15:54:27.554337 arp who-has ppc tell rac26090-2
15:54:28.554343 arp who-has ppc tell rac26090-2
15:54:29.554334 arp who-has ppc tell rac26090-2
15:54:30.030840 0.0.0.0.bootpc > 255.255.255.255.bootps: xid:0xbb4be989
secs:20 [|bootp] (DF)
15:54:30.031282 rac26090-2.bootps > ppc.bootpc: xid:0xbb4be989 secs:20
Y:ppc S:rac26090-2 [|bootp]
15:54:35.024346 arp who-has ppc tell rac26090-2
15:54:36.024357 arp who-has ppc tell rac26090-2



PPC output on terminal:

8xxROM 0.3.0

compiletime options:
board: ADS DRAM_25MHZ
disk: DISK_ATA PCMCIABUG

cpu: XPC860xxZPnnA3 at 25 MHz: 4Kbyte icache 4Kbyte dcache

<warning: cpu core has silicon bugs, check the errata>

board: ADS rev A - warning, read errata
flash: 2 Mbytes, delay 90 ns
dram: 8 Mbyte, 70 ns, OK
pcmcia: 5V and 3V
pcsr = 0x0070fe70

ATA disk: 'SunDisk SDP'.

Boot device list:
 ata: SunDisk SDP3B-40
  MSDOS partition table
  Part    Start     Size Name
    1:       32    81760 FAT16

Found FAT filesystem

ata:1:/> bootz zimage

entry 0x100000, phoff 0x34, shoff 0x72920
phnum 0x1, shnum 0x9
p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
p_filesz 0x532c, p_memsz 0xb1bc
Loading at 0x10c000
Starting 0x11c000
loaded at:     0011C000 001271BC
relocated to:  00100000 0010B1BC
board data at: 007F0000 007F001C
relocated to:  00200100 0020011C
zimage at:     00122000 0017E8E6
avail ram:     0017F000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (nhofru@rac26090) (gcc version egcs-2.91.60 19981201 (egcs-
1.1.1 release)) #67 Mon Jan 17 15:49:49 CET 2000
Boot arguments: root=/dev/nfs rw
time_init: decrementer frequency = 93750000/60
Calibrating delay loop... 24.83 BogoMIPS
Memory: 7140k available (664k kernel code, 356k data, 32k init) [c0000000,c08000
00]
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 8192 bhash 8192)
Starting kswapd v 1.5
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
pty: 256 Unix98 ptys configured
eth0: CPM ENET Version 0.2, 08:00:3e:26:15:59
Sending BOOTP requests............. timed out!
IP-Config: Auto-configuration of network failed.
dev_close: bug eth0 still running
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device 02:00
NIP: C00A4298 XER: E0007B7F LR: C001068C REGS: c0109c30 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0108000[1] 'swapper' mm->pgd c00bb000 Last syscall: 120
last math 00000000
GPR00: C001068C C0109CE0 C0108000 C00D46BF 801AEEB4 C0109D90 FFFFFFFF FFFFFFFF
GPR08: 801AEEB4 801AEEB4 C00A45BC C0109DE8 FFFFFFFF 00000000 FE010000 FE010000
GPR16: FE010000 FE010000 FE010000 FE010000 FE010000 007F0000 00009032 00002C6F
GPR24: 00000000 C00D0000 C00A9338 801AEEB4 C00D0000 C0109D28 C0160000 FFFFFFED
Call backtrace:
C0016ACC C001068C C0010010 C00CEA48 C00CC74C C0002970 C0006D04
NIP: C00A4298 XER: E0007B7F LR: C001068C REGS: c01099a0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0108000[1] 'swapper' mm->pgd c00bb000 Last syscall: 120
last math 00000000
GPR00: C001068C C0109A50 C0108000 C00D46BF 801AEEB4 C0109B00 FFFFFFFB 00000000
GPR08: 801AEEB4 801AEEB4 C0109AA9 C0109B58 FFFFFFFF 00000000 FE010000 FE010000
GPR16: FE010000 FE010000 FE010000 FE010000 00001032 00109C20 00001032 C0002544
GPR24: C0008FD4 C00D0000 C00A675C 801AEEB4 C00D0000 C0109A98 801AEEB4 C0109C30
Call backtrace:
00000000 C001068C C0010010 C0009288 C00091F8 C0002544 C0016ACC
C001068C C0010010 C00CEA48 C00CC74C C0002970 C0006D04
NIP: C00A4298 XER: E0007B7F LR: C001068C REGS: c0109710 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0108000[1] 'swapper' mm->pgd c00bb000 Last syscall: 120
last math 00000000


In directory /tftpboot i put all the stuff from mbxroot.min.gz from http://www.ppc.kernel.org/embedded.html.


Any ideas why it doesn't start???

TIA, Ruedi





--Boundary_(ID_tszMerbrbW01FmkDjiulgA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
