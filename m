From: Ruedi.Hofer@ascom.ch
Date: Tue, 18 Jan 2000 14:34:09 +0100 (CET)
Subject: Antwort: Re: ATA flash disk ok, missing ip config
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FOJ00CF99QJAJ@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_L8oRVKzJJ4is4p3EWx5VrA)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_L8oRVKzJJ4is4p3EWx5VrA)
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi 

After I applied your boot params it puts the lines below on the terminal.

What means 'Root-NFS: Server returned error -5 while mounting /tftpboot/'  ??

Any ideas?

TIA, Ruedi


Linux/PPC load: root=/dev/nfs ip=10.1.20.1:10.1.20.2:10.1.20.2:255.255.255.0:ppc::bootp nfsroot=10.1.20.2:/tftpboot/ rw
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.13 (nhofru@rac26090) (gcc version egcs-2.91.60 19981201 (egcs-1.1.1 release)) #67 Mon Jan 17 15:49:49 CET 2000
Boot arguments: root=/dev/nfs ip=10.1.20.1:10.1.20.2:10.1.20.2:255.255.255.0:ppc::bootp nfsroot=10.1.20.2:/tftpboot/ rw
time_init: decrementer frequency = 93750000/60
Calibrating delay loop... 24.83 BogoMIPS
Memory: 7140k available (664k kernel code, 356k data, 32k init) [c0000000,c0800000]
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
Looking up port of RPC 100003/2 on 10.1.20.2
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
portmap: server 10.1.20.2 not responding, timed out
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 10.1.20.2
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
portmap: server 10.1.20.2 not responding, timed out
Root-NFS: Unable to get mountd port number from server, using default
neighbour table overflow
neighbour table overflow
neighbour table overflow
neighbour table overflow
mount: server 10.1.20.2 not responding, timed out
Root-NFS: Server returned error -5 while mounting /tftpboot/
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device 02:00
NIP: C00A4298 XER: E0005A7F LR: C001068C REGS: c0109c30 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0108000[1] 'swapper' mm->pgd c00bb000 Last syscall: 120
last math 00000000
GPR00: C001068C C0109CE0 C0108000 C00D46BF BE0B6EB4 C0109D90 FFFFFFFF FFFFFFFF
GPR08: BE0B6EB4 BE0B6EB4 C00A45BC C0109DE8 FFFFFFFF FFFFFFFF FE010000 FE010000
GPR16: FE010000 FE010000 FE010000 FE010000 FE010000 007F0000 00009032 00002C6F
GPR24: 00000000 C00D0000 C00A9338 BE0B6EB4 C00D0000 C0109D28 C0160000 FFFFFFED
Call backtrace:
C0016ACC C001068C C0010010 C00CEA48 C00CC74C C0002970 C0006D04
NIP: C00A4298 XER: E0005A7F LR: C001068C REGS: c01099a0 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0108000[1] 'swapper' mm->pgd c00bb000 Last syscall: 120
last math 00000000





amre.el-hoiydi@csem.ch on 19.01.2000 16:38:45
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie:  
Thema: Re: ATA flash disk ok, missing ip config

Hallo,

I had some "IP-Config: Incomplete network configuration information." when the
boot line was not correct. This line must be entered after the "Linux/PPC load:"
prompt. A default line can be programmed in arch/ppc/boot/misc.c.

char *root_string = "root=/dev/nfs nfsaddrs=10.10.10.1:10.10.10.2
nfsroot=10.10.10.2:/export/nfslinuxroot

where 10.10.10.1 is the IP address of the ethernet interface of the board and
10.10.10.2 is the IP address of the workstation from which the root directory is
exported via NFS.

Does that help ?

Regards,

Amre


Ruedi.Hofer@ascom.ch wrote:
> 
> Hi Magnus
> 
> It works now. I had to remove the line '__asm__ volatile("eieio");' (~line 205) in
> file pcmcia.c.
> 
> But unfortunately, it doesn't boot completely because of missing ip config.
> Where do I have to apply this data?
> 
> Cheers, Ruedi
> 
> _________________________________________
> 
> The printout looks now like this:
> 
> 8xxROM 0.3.0
> 
> compiletime options:
> board: ADS DRAM_25MHZ
> disk: DISK_ATA PCMCIABUG
> 
> cpu: XPC860xxZPnnA3 at 25 MHz: 4Kbyte icache 4Kbyte dcache
> 
> <warning: cpu core has silicon bugs, check the errata>
> 
> board: ADS rev A - warning, read errata
> flash: 2 Mbytes, delay 90 ns
> dram: EDO, 4 Mbyte, 70 ns, OK
> pcmcia: 5V and 3V
> pcsr = 0x0070fe70
> 
> ATA disk: 'SunDisk SDP'.
> 
> Boot device list:
>  ata: SunDisk SDP3B-40
>   MSDOS partition table
>   Part    Start     Size Name
>     1:       32    81760 FAT16
> 
> Found FAT filesystem
> 
> > ó
> 
>    Huh?  Try "help"
> 
> > ident
> 
> Boot device list:
>  ata: SunDisk SDP3B-40
>   MSDOS partition table
>   Part    Start     Size Name
>     1:       32    81760 FAT16
> 
> Found FAT filesystem
> 
> > ls
> 
>     zimage
> 
> 5 file(s), 0 dir(s)
> 
> > bootz zimage
> 
> entry 0x100000, phoff 0x34, shoff 0x6f470
> phnum 0x1, shnum 0x9
> p_offset 0x10000, p_vaddr 0x100000, p_paddr 0x100000
> p_filesz 0x532c, p_memsz 0xb1bc
> Loading at 0x10c000
> Starting 0x11c000
> loaded at:     0011C000 001271BC
> relocated to:  00100000 0010B1BC
> board data at: 003F0000 003F001C
> relocated to:  00200100 0020011C
> zimage at:     00122000 0017B434
> avail ram:     0017C000 00400000
> 
> Linux/PPC load:
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.2.13 (root@rac26090) (gcc version egcs-2.91.60 19981201 (egcs-1.
> 1.1 release)) #59 Wed Jan 5 11:23:37 CET 2000
> Boot arguments: root=/dev/nfs rw
> time_init: decrementer frequency = 93750000/60
> Calibrating delay loop... 24.83 BogoMIPS
> Memory: 3116k available (652k kernel code, 296k data, 32k init) [c0000000,c04000
> 00]
> DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
> Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Page-cache hash table entries: 1024 (order: 0, 4096 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> NET4: Unix domain sockets 1.0 for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> TCP: Hash tables configured (ehash 4096 bhash 4096)
> Starting kswapd v 1.5
> CPM UART driver version 0.02
> ttyS00 at 0x0280 is a SMC
> ttyS01 at 0x0100 is a SCC
> ttyS02 at 0x0200 is a SCC
> pty: 256 Unix98 ptys configured
> CPM interrupt c00a0a44 replacing c009e2d4
> eth0: CPM ENET Version 0.2, 08:00:3e:26:15:59
> IP-Config: Incomplete network configuration information.
> dev_close: bug eth0 still running
> Root-NFS: No NFS server available, giving up.
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device 02:00
> Kernel panic: VFS: Unable to mount root fs on 02:00
> Rebooting in 180 seconds..

-- 
Amre El-Hoiydi
R&D Engineer, Real-Time Software and Networking,
CSEM, Rue Jaquet-Droz 1, 2007 Neuchatel, Switzerland
Tel +41 327205188, Fax +41 327205720,
Email: amre.el-hoiydi@csem.ch



--Boundary_(ID_L8oRVKzJJ4is4p3EWx5VrA)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
