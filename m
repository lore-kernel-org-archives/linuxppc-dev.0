Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36ADEDDEED
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Feb 2008 01:11:45 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JNTx7-0005VW-SA
	for linuxppc-embedded@ozlabs.org; Fri, 08 Feb 2008 06:11:41 -0800
Message-ID: <15355858.post@talk.nabble.com>
Date: Fri, 8 Feb 2008 06:11:41 -0800 (PST)
From: IngoM <ingo.maindorfer@ipm.fraunhofer.de>
To: linuxppc-embedded@ozlabs.org
Subject: [Virtex 4 PPC] Problem mountin rootfs via NFS
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

in the meantime, I get up my toolchain and an linux-kernel from xilinx
git-repository.
Hardware is an FX12 Mini-Module form AVNET, standard design with LL-TEMAC,
EDK 9.2.
Kernel boots fine till he try to mount his rootfs via NFS. NFS is working
correctly, probed with some other maschines. Some times kernel can mount
NFS, somtimes kernel panics trying this.
I already try some additional parameters found here on the list like
"tcp,no_lock" but didn't help. Also probed direct connection, connection via
a 100 MBit switch. No success.
Another thing I tried is set ip=dhcp, the device find our DHCP-Server and
gets an address. So I think network should ok, but where comes the NFS
trouble from?

Best Regards,

Ingo Maindorfer


The boot messages from console:

loaded at:     00400000 0052E19C                                
board data at: 0052C120 0052C19C                                
relocated to:  0040409C 00404118                                
zimage at:     00404F13 0052BDE3                                
avail ram:     0052F000 02000000                                

Linux/PPC load: console=ttyUL0,19200
ip=10.82.2.234:10.82.2.103:10.82.2.4:255.255.255.0
nfsroot=10.82.2.103:/tftpboot                                                                                                                     
Uncompressing Linux...done.                           
Now booting the kernel                      
Linux version 2.6.24-rc8-xlnx-g8a6d0b1a-dirty (ingo@messstrecke) (gcc
version 3.4.5) #24 PREEMPT Fri Feb 8 14:21:06 CET 2008                                                                                                                            
Xilinx Generic PowerPC board support package (Xilinx ML40                                                       
Zone PFN ranges:ilinx_lltemac.0:
  DMA             0 ->     8192                               
  Normal       8192 ->     8192lTemac: Dma base address: phy: 
  HighMem      8192 ->     81927c                             
Movable zone start PFN for each node 
et  
XLlTemac: buffer descriptor s
early_node_map[1] active PFN ranges_table+0x64/0xe44 (order: 0, 40    
    0:        0 ->     8192                           
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
with kmalloc<6>XLlTemac: (buffer_descriptor                             
Kernel command line: console=ttyUL0,19200
ip=10.82.2.234:10.82.2.103:10.82.2.4:255.255.255.0
nfsroot=10.82.2.103:/tftpboot     
_init) phy: 0x1c98000, virt: 0xc1c98000, size: 0x8000                                                     
TCP estab
Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFF000     
XTemac: PHY detected at address 4.         
PID hash table entries: 128 (order: 7, 512 bytes)    
eth0: Dropping NETIF_F_SG sin               
Memory: 29820k available (1940k kernel code, 600k data, 104k init, 0k
highmem)                                     
eth0: XLlTemac: allocating interrupt 1 f
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1,
Nodes=1LlTemac:         
eth0: XLlTemac: Not able to set the speed to 1000 (st
Mount-cache hash table entries: 512                                   
net_namespace: 64 bytesLlTemac: We renegotiate
NET: Registered protocol family 16                                 

Registering device uartlite:0ltemac.0: eth0:              
Registering device xilinx_lltemac:0mac: speed set to 100Mb/s 0xC3Send 
NET: Registered protocol family 2                                 
TCP reno registeredmac: allocating int
sysctl table check failed: /kernel/l2cr .1.31 Missing strategy4k init                                       
eth0: XLlTemac:
Call Trace:o          
[c1c0fe60] [c0008e68] show_stack+0x40/0x194 (unreliable)sole.                                           

IP-Con
[c1c0fe90] [c0036414] set_fail+0x68/0x80nk carrier restored.                    
[c1c0feb0] [c0036a2c] sysctl_check_table+0x600/0x77c  
-- Entering main() --ask=255.255.255.0, gw       
[c1c0fef0] [c0036a14] sysctl_c    
                        
[c1c0fff0] [c0004e78] kernel_thread+0x44/0x60ver=1                                        
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).rnel memory: 104k i                                     
io scheduler noop registeredLinux/PPC load: console=ttyU
io scheduler cfq registered (default).82.2.4:255.25e to open an initial co
uartlite.0: ttyUL0 at MMIO 0x84000003 (irq = 3) is a uartlite                                                     
Lookin 
console [ttyUL0] enabled82.2.75:/tftpboot82.    
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize                              
  DMA             0 ->     819210.82.2
Built 1
XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac:
(buffer_descriptor_init) phy: 0x1c90000, virt: 0xc1c90000, size: 0x800                               
55.255.255.0 nfsroot=10.82.2.75:/tftpboot######################                                     
0 
XTemac: PHY detected at address 4. #0 at 0x81800000 mapped to 0xFDFF
eth0: Dropping NETIF_F_SG since no checksum feature.                                                
PID
xilinx_lltemac xilinx_lltemac.0: eth0: Xilinx TEMAC a                                                    
RPC: Registered udp transport module.AC                                   
RPC: Registered tcp transport module.s: 2048 (order: 1, 8192 bytes)8192   
eth0: XLlTemac: allocating interrupt 0 for dma mode tx.
eth0: XLlTemac: allocating interrupt 1 for dma mode rx.
eth0: XLlTemac: We renegotiated the speed to: 1000
eth0: XLlTemac: speed set to 1000Mb/s
eth0: XLlTemac: Send Threshold = 24, Receive Threshold = 4
eth0: XLlTemac: Send Wait bound = 254, Receive Wait bound = 254
IP-Config: Complete:
      device=eth0, addr=10.82.2.234, mask=255.255.255.0, gw=10.82.2.4,
     host=10.82.2.234, domain=, nis-domain=(none),
     bootserver=10.82.2.103, rootserver=10.82.2.103, rootpath=
Looking up port of RPC 100003/2 on 10.82.2.103
Looking up port of RPC 100005/1 on 10.82.2.103
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 104k init
Warning: unable to open an initial console.
nfs: server 10.82.2.103 not responding, still trying
nfs: server 10.82.2.103 OK
nfs: server 10.82.2.103 not responding, still trying
nfs: server 10.82.2.103 not responding, still trying
nfs: server 10.82.2.103 OK
nfs: server 10.82.2.103 not responding, still trying
nfs: server 10.82.2.103 OK
nfs: server 10.82.2.103 OK


wireshark spite out this (.103 NFS-Server, .234 Xilinx):

"22","7.482314000","10.82.2.234","10.82.2.103","NFS","V2 READ Call (Reply In
25), FH:0xb29d0d7b Offset:16384 Count:4096 TotalCount:4096"
"23","7.482411000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #25]"
"24","7.482416000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #25]"
"25","7.482418000","10.82.2.103","10.82.2.234","NFS","V2 READ Reply (Call In
22)"
"26","8.581527000","10.82.2.234","10.82.2.103","NFS","V2 READ Call (Reply In
29), FH:0xb29d0d7b Offset:8192 Count:4096 TotalCount:4096"
"27","8.581608000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #29]"
"28","8.581612000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #29]"
"29","8.581615000","10.82.2.103","10.82.2.234","NFS","V2 READ Reply (Call In
26)"
"30","8.585120000","10.82.2.234","10.82.2.103","NFS","V2 READ Call (Reply In
33), FH:0xb29d0d7b Offset:12288 Count:4096 TotalCount:4096"
"31","8.585160000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #33]"
"32","8.585164000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #33]"
"33","8.585166000","10.82.2.103","10.82.2.234","NFS","V2 READ Reply (Call In
30)"
"34","8.593065000","10.82.2.234","10.82.2.103","NFS","[RPC retransmission of
#22]V2 READ Call (Reply In 25), FH:0xb29d0d7b Offset:16384 Count:4096
TotalCount:4096"
"35","8.593109000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #37]"
"36","8.593113000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #37]"
"37","8.593115000","10.82.2.103","10.82.2.234","NFS","[RPC duplicate of
#25]V2 READ Reply (Call In 22)"
"38","8.607327000","10.82.2.234","10.82.2.103","NFS","V2 READ Call (Reply In
39), FH:0xb29d0d7b Offset:20480 Count:896 TotalCount:896"
"39","8.607363000","10.82.2.103","10.82.2.234","NFS","V2 READ Reply (Call In
38)"
"54","10.807186000","10.82.2.234","10.82.2.103","NFS","[RPC retransmission
of #38]V2 READ Call (Reply In 39), FH:0xb29d0d7b Offset:20480 Count:896
TotalCount:896"
"55","10.807248000","10.82.2.103","10.82.2.234","NFS","[RPC duplicate of
#39]V2 READ Reply (Call In 38)"
"60","13.012339000","10.82.2.234","10.82.2.103","NFS","[RPC retransmission
of #22]V2 READ Call (Reply In 25), FH:0xb29d0d7b Offset:16384 Count:4096
TotalCount:4096"
"61","13.012483000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #63]"
"62","13.012489000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #63]"
"63","13.012492000","10.82.2.103","10.82.2.234","NFS","[RPC duplicate of
#25]V2 READ Reply (Call In 22)"
"65","14.111614000","10.82.2.234","10.82.2.103","NFS","[RPC retransmission
of #22]V2 READ Call (Reply In 25), FH:0xb29d0d7b Offset:16384 Count:4096
TotalCount:4096"
"66","14.111699000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #68]"
"67","14.111705000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #68]"
"68","14.111707000","10.82.2.103","10.82.2.234","NFS","[RPC duplicate of
#25]V2 READ Reply (Call In 22)"
"71","16.311259000","10.82.2.234","10.82.2.103","NFS","[RPC retransmission
of #22]V2 READ Call (Reply In 25), FH:0xb29d0d7b Offset:16384 Count:4096
TotalCount:4096"
"72","16.311360000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #74]"
"73","16.311366000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #74]"
"74","16.311368000","10.82.2.103","10.82.2.234","NFS","[RPC duplicate of
#25]V2 READ Reply (Call In 22)"
"75","16.322672000","10.82.2.234","10.82.2.103","NFS","V2 GETATTR Call
(Reply In 76), FH:0x00bdec42"
"76","16.322705000","10.82.2.103","10.82.2.234","NFS","V2 GETATTR Reply
(Call In 75)"
"77","16.326131000","10.82.2.234","10.82.2.103","NFS","V2 LOOKUP Call (Reply
In 78), DH:0x529ded7b/libc.so.6"
"78","16.326167000","10.82.2.103","10.82.2.234","NFS","V2 LOOKUP Reply (Call
In 77), FH:0x569de97b"
"79","16.329608000","10.82.2.234","10.82.2.103","NFS","V2 READLINK Call
(Reply In 80), FH:0x569de97b"
"80","16.329654000","10.82.2.103","10.82.2.234","NFS","V2 READLINK Reply
(Call In 79) Path:libc-2.3.6.so"
"81","16.332969000","10.82.2.234","10.82.2.103","NFS","V2 LOOKUP Call (Reply
In 82), DH:0x529ded7b/libc-2.3.6.so"
"82","16.332993000","10.82.2.103","10.82.2.234","NFS","V2 LOOKUP Reply (Call
In 81), FH:0x529ded7b"
"83","16.336586000","10.82.2.234","10.82.2.103","NFS","V2 READ Call (Reply
In 86), FH:0x529ded7b Offset:0 Count:4096 TotalCount:4096"
"84","16.336620000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #86]"
"85","16.336625000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #86]"
"86","16.336627000","10.82.2.103","10.82.2.234","NFS","V2 READ Reply (Call
In 83)"
"87","16.336815000","10.82.2.234","10.82.2.103","NFS","V2 READ Call (Reply
In 90), FH:0x529ded7b Offset:4096 Count:4096 TotalCount:4096"
"88","16.336845000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=0) [Reassembled in #90]"
"89","16.336850000","10.82.2.103","10.82.2.234","IP","Fragmented IP protocol
(proto=UDP 0x11, off=1480) [Reassembled in #90]"
"90","16.336852000","10.82.2.103","10.82.2.234","NFS","V2 READ Reply (Call
In 87)"
"168","31.034419000","10.82.2.234","10.82.2.103","NFS","[RPC retransmission
of #83]V2 READ Call (Reply In 86), FH:0x529ded7b Offset:0 Count:4096
TotalCount:4096"
"169","31.034530000","10.82.2.103","10.82.2.234","IP","Fragmented IP
protocol (proto=UDP 0x11, off=0) [Reassembled in #171]"
"170","31.034535000","10.82.2.103","10.82.2.234","IP","Fragmented IP
protocol (proto=UDP 0x11, off=1480) [Reassembled in #171]"
"171","31.034537000","10.82.2.103","10.82.2.234","NFS","[RPC duplicate of
#86]V2 READ Reply (Call In 83)"
"193","32.133681000","10.82.2.234","10.82.2.103","NFS","[RPC retransmission
of #87]V2 READ Call (Reply In 90), FH:0x529ded7b Offset:4096 Count:4096
TotalCount:4096"
"194","32.133823000","10.82.2.103","10.82.2.234","IP","Fragmented IP
protocol (proto=UDP 0x11, off=0) [Reassembled in #196]"
"195","32.133828000","10.82.2.103","10.82.2.234","IP","Fragmented IP
protocol (proto=UDP 0x11, off=1480) [Reassembled in #196]"

-- 
View this message in context: http://www.nabble.com/-Virtex-4-PPC--Problem-mountin-rootfs-via-NFS-tp15355858p15355858.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
