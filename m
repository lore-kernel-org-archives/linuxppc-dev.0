Return-Path: <alohanono@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.238])
	by ozlabs.org (Postfix) with ESMTP id 31DFBDDEF9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Feb 2008 01:52:55 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id 68so1984370wra.13
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 05 Feb 2008 06:52:54 -0800 (PST)
Message-ID: <47A8782E.4050402@gmail.com>
Date: Tue, 05 Feb 2008 15:52:30 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problems booting in ML403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

 I am having problems while trying to boot my linux kernel 2.6.24-rc3 ( 
secretlab git). After some days studying this list and other related 
documents/wikis about how to make work a linux kernel in my ML403, I 
managed to make it work partially.

 I am using ELDK 4.1 "uclibc" as a cross compiler. I have also used ELDK 
rootfs in my compactflash, when I boot it hangs at some point. This is 
my console output:

loaded at:     00400000 
005981A0                                               
board data at: 00596124 
005961A0                                               
relocated to:  004040DC 
00404158                                               
zimage at:     00404ECD 
00595EB8                                               
avail ram:     00599000 
04000000                                               
                                                                                

Linux/PPC load: console=ttyS0,9600 console=tty0,9600 console=ttyUL0,9600 
root=/d
ev/xsa2 rw 
init=/sbin/init                                                     
Uncompressing 
Linux...done.                                                    
Now booting the 
kernel                                                         
[    0.000000] Linux version 2.6.24-rc3-gd7ed933b-dirty (ios@xxx) (gcc vers
ion 4.0.0 (DENX ELDK 4.1 4.0.0)) #6 Mon Feb 4 14:06:43 CET 
2008                
[    0.000000] Xilinx ML403 Reference System (Virtex-4 
FX)                     
[    0.000000] Zone PFN 
ranges:                                                
[    0.000000]   DMA             0 ->    
16384                                 
[    0.000000]   Normal      16384 ->    
16384                                 
[    0.000000]   HighMem     16384 ->    
16384                                 
[    0.000000] Movable zone start PFN for each 
node                            
[    0.000000] early_node_map[1] active PFN 
ranges                             
[    0.000000]     0:        0 ->    
16384                                     
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pag
es: 
16256                                                                      
[    0.000000] Kernel command line: console=ttyS0,9600 console=tty0,9600 
console
=ttyUL0,9600 root=/dev/xsa2 rw 
init=/sbin/init                                 
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 
0xFDFFE000               
[    0.000000] PID hash table entries: 256 (order: 8, 1024 
bytes)              
[    0.000449] Console: colour dummy device 
80x25                              
[    0.000546] console [tty0] 
enabled                                          
[    0.002982] Dentry cache hash table entries: 8192 (order: 3, 32768 
bytes)   
[    0.004906] Inode-cache hash table entries: 4096 (order: 2, 16384 
bytes)    
[    0.038813] Memory: 61312k available (2740k kernel code, 784k data, 
112k init
, 0k 
highmem)                                                                  
[    0.039615] SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, 
CPUs=1, N
odes=1                                                                          

[    0.220715] Mount-cache hash table entries: 
512                             
[    0.231019] net_namespace: 64 
bytes                                         
[    0.244246] NET: Registered protocol family 
16                              
[    0.368073] NET: Registered protocol family 
2                               
[    0.461661] IP route cache hash table entries: 1024 (order: 0, 4096 
bytes)  
[    0.467834] TCP established hash table entries: 2048 (order: 2, 16384 
bytes)
[    0.468813] TCP bind hash table entries: 2048 (order: 1, 8192 
bytes)        
[    0.469483] TCP: Hash tables configured (established 2048 bind 
2048)        
[    0.469711] TCP reno 
registered                                             
[    0.493382] sysctl table check failed: /kernel/l2cr .1.31 Missing 
strategy  
[    0.493825] Call 
Trace:                                                     
[    0.493957] [c3c11e80] [c0008380] show_stack+0x4c/0x174 
(unreliable)        
[    0.494322] [c3c11eb0] [c0037170] 
set_fail+0x50/0x68                        
[    0.494637] [c3c11ed0] [c00377f8] 
sysctl_check_table+0x670/0x6bc            
[    0.494922] [c3c11f10] [c003780c] 
sysctl_check_table+0x684/0x6bc            
[    0.495203] [c3c11f50] [c0024e7c] 
register_sysctl_table+0x5c/0xac           
[    0.495533] [c3c11f70] [c034ab68] 
register_ppc_htab_sysctl+0x18/0x2c        
[    0.495864] [c3c11f80] [c034484c] 
kernel_init+0xc8/0x284                    
[    0.496130] [c3c11ff0] [c0004b18] 
kernel_thread+0x44/0x60                   
[    0.630804] Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).        
[    0.642747] JFS: nTxBlock = 479, nTxLock = 
3832                             
[    0.650497] SGI XFS with ACLs, large block numbers, no debug 
enabled        
[    0.687400] io scheduler noop 
registered                                    
[    0.687710] io scheduler anticipatory 
registered                            
[    0.687880] io scheduler deadline 
registered                                
[    0.689104] io scheduler cfq registered 
(default)                           
[    2.129848] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ 
sharing
disabled                                                                        

[    2.150840] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a 
16550A    
[    2.151248] console [ttyS0] 
enabled                                         
[    5.425398] RAMDISK driver initialized: 16 RAM disks of 4096K size 
1024 block
size                                                                            

[    5.532502] loop: module 
loaded                                             
[    5.572824] xsysace xsysace.0: Xilinx SystemACE revision 
1.0.12             
[    5.645558] xsysace xsysace.0: capacity: 1019088 
sectors                    
[    5.710732]  xsa: xsa1 xsa2 
xsa3                                            
[    5.763112] Xilinx SystemACE device driver, 
major=254                       
[    5.826421] nbd: registered device at major 
43                              
[    5.921820] XTemac: using sgDMA 
mode.                                       
[    5.966225] XTemac: using TxDRE 
mode                                        
[    6.009573] XTemac: using RxDRE 
mode                                        
[    6.052783] XTemac: buffer descriptor size: 32768 
(0x8000)                  
[    6.120289] XTemac: (buffer_descriptor_init) phy: 0x3d80000, virt: 
0xff100000
, size: 
0x8000                                                                 
[    6.231949] eth%d: XTemac: No PHY detected.  Assuming a PHY at 
address 0    
[    6.313017] eth0: Dropping NETIF_F_SG since no checksum 
feature.            
[    6.392778] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5060000, 
irq=0 
[    6.476905] eth0: XTemac id 1.0f, block id 5, type 
8                        
[    6.539381] NFTL driver: nftlcore.c $Revision: 1.98 $, nftlmount.c 
$Revision:
 1.41 
$                                                                        
[    6.633905] INFTL: inftlcore.c $Revision: 1.19 $, inftlmount.c 
$Revision: 1.1
8 
$                                                                             

[    6.725083] SSFDC read-only Flash Translation 
layer                         
[    6.791347] i8042.c: No controller 
found.                                   
[    6.843298] mice: PS/2 mouse device common for all 
mice                     
[    6.912775] i2c /dev entries 
driver                                         
[    6.958352] TCP cubic 
registered                                            
[    6.998344] NET: Registered protocol family 
1                               
[    7.051264] NET: Registered protocol family 
17                              
[    7.110285] RPC: Registered udp transport 
module.                           
[    7.167370] RPC: Registered tcp transport 
module.                           
[    9.302726] kjournald starting.  Commit interval 5 
seconds                  
[    9.408788] EXT3 FS on xsa2, internal 
journal                               
[    9.461599] EXT3-fs: recovery 
complete.                                     
[    9.547744] EXT3-fs: mounted filesystem with ordered data 
mode.             
[    9.619378] VFS: Mounted root (ext3 
filesystem).                            
[    9.675834] Freeing unused kernel memory: 112k 
init                         
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I actually had tried before with the original rootfs that comes with the 
given montavista demo, and I got this:

(...)

[ 12.906329] kjournald starting. Commit interval 5 seconds
[   12.972902] EXT3-fs warning: maximal mount count reached, running 
e2fsck is r
ecommended                                                                      

[   13.109355] EXT3 FS on xsa2, internal 
journal                               
[   13.162196] EXT3-fs: recovery 
complete.                                     
[   13.247717] EXT3-fs: mounted filesystem with ordered data 
mode.             
[   13.319357] VFS: Mounted root (ext3 
filesystem).                            
[   13.375883] Freeing unused kernel memory: 112k 
init                         
[   13.441190] Warning: unable to open an initial 
console.                     
[   19.728949] eth0: XTemac: Options: 
0xb8f2                                   
[   31.747487] eth0: XTemac: Not able to set the speed to 1000 (status: 
0x148) 
[   41.806572] eth0: XTemac: Not able to set the speed to 100 (status: 
0x148)  
[   51.864570] eth0: XTemac: Not able to set the speed to 10 (status: 
0x148)   
[   51.946095] eth0: XTemac: could not negotiate 
speed                         
[   52.004713] eth0: XTemac: Send Threshold = 16, Receive Threshold = 
2        
[   52.080998] eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 
1       
[   64.670479] eth0: XTemac: PHY Link carrier lost.                      
    
Stopping here. Any ideas? Is there a problem with my eldk rootfs? 
                                                                             


Thanks in advance!
