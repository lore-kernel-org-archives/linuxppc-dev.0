Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id F10F6DDE36
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 15:16:53 +1100 (EST)
Message-ID: <396049508.10992@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 26 Nov 2007 11:58:28 +0800
Subject: The question about the high memory support on MPC8360?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends, 
  I plug in 1GB DDR-1 on my MPC8360 board, the u-boot-1.2.0 found the DDR storage
is 1GB, but the linux just found  773504k. please see follow information.
   I think I need to config the kernel to support the high memory. but if I config
the kernel to select the "high memory support" under the "platform options" on
"linux kernel configuration" during compile, the kernel is not to boot. if I
cancel this options, the kernel is ok to run.
   why? how to deal with this problem? there are two DIMM-184 slots on my MPC8360
board, I want to support total 2GB DDR-1 storage. now I want to try 1GB on one of 
DIMM-184 slots firstly.
    please see follow information. Thanks.


~ # dmesg                                                                       
Linux version 2.6.11 (olivia@bamboo) (gcc version 3.4.3) #1 Thu Jul 12 14:29:297
On node 0 totalpages: 196608                                                    
  DMA zone: 196608 pages, LIFO batch:16                                         
  Normal zone: 0 pages, LIFO batch:1                                            
  HighMem zone: 0 pages, LIFO batch:1                                           
Built 1 zonelists                                                               
Kernel command line: console=ttyS0,115200 root=/dev/ram0                        
IPIC (128 IRQ sources, 8 External IRQs) at fe000700                             
QE IC (64 IRQ sources) at fe100080                                              
PID hash table entries: 4096 (order: 12, 65536 bytes)                           
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)                
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)                  
Memory: 773504k available (1724k kernel code, 432k data, 100k init, 0k highmem) 
Calibrating delay loop... 351.23 BogoMIPS (lpj=175616)                          
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)                      
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd 
Freeing initrd memory: 3120k freed                                              
NET: Registered protocol family 16                                              
Registering ipic with sysfs...                                                  
SCSI subsystem initialized                                                      
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.                                  
Generic RTC Driver v1.07                                                        
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled       
ttyS0 at MMIO 0xe0004500 (irq = 9) is a 16550A                                  
ttyS1 at MMIO 0xe0004600 (irq = 10) is a 16550A                                 
io scheduler noop registered                                                    
io scheduler anticipatory registered                                            
io scheduler deadline registered                                                
io scheduler cfq registered                                                     
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize          
loop: loaded (max 8 devices)                                                    
MPC8360E PB flash device: 2000000 at fe000000 Partition number 6                
MPC8360E PB Flash Map Info: Found 1 x16 devices at 0x0 in 16-bit bank           
MPC8360E PB Flash Map Info: Found an alias at 0x1000000 for the chip at 0x0     
Support for command set 0001 not present                                        
gen_probe: No supported Vendor Command Set found                                
i2c /dev entries driver                                                         
eth0: Running with NAPI disabled                                                
eth1: Running with NAPI disabled                                                
NET: Registered protocol family 2                                               
IP: routing cache hash table of 8192 buckets, 64Kbytes                          
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)            
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)                     
TCP: Hash tables configured (established 131072 bind 65536)                     
NET: Registered protocol family 1                                               
NET: Registered protocol family 17                                              
RAMDISK: Compressed image found at block 0                                      
VFS: Mounted root (ext2 filesystem) readonly.                                   
Freeing unused kernel memory: 100k init                                         
eth0: PHY is Marvell 88E11x1 (1410cc1)                                          
eth0: Full Duplex                                                               
eth0: Speed 1000BT                                                              
eth0: Link is up


U-Boot 1.2.0 (Nov 21 2007 - 16:05:15) MPC83XX                                   
                                                                                
CPU:   e300c1, MPC8360E, Rev: 20 at 528 MHz, CSB:  264 MHz                      
Board: Freescale MPC8360EMDS                                                    
I2C:   ready                                                                    
DRAM:                                                                           
DIMM type:                                                                      
SPD size:        128                                                            
EEPROM size:     256                                                            
Memory type:     7                                                              
Row addr:        13                                                             
Column addr:     11                                                             
# of rows:       2                                                              
Row density:     128                                                            
# of banks:      4                                                              
Data width:      64                                                             
Chip width:      8                                                              
Refresh rate:    82                                                             
CAS latencies:   1C                                                             
Write latencies: 02                                                             
tRP:             60                                                             
tRCD:            60                                                             
                                                                                
                                                                                
   DDR DIMM: data bus width is 64 bit without ECC                               
   DDRC ECC mode: OFF                                                           
                                                                                
   SDRAM on Local Bus: 64 MB                                                    
   DDR RAM: 1024 MB                                                             
FLASH: 16 MB                                                                    
PCI clock is 66MHz                                                              
PCI 32bit bus on PMC1 & PMC2 & PMC3                                             
In:    serial                                                                   
Out:   serial                                                                   
Err:   serial                                                                   
Net:   UEC: PHY is Marvell 88E11x1 (1410cc1)                                    
FSL UEC0: Full Duplex                                                           
FSL UEC0: Speed 1000BT                                                          
FSL UEC0: Link is up                                                            
FSL UEC0                                                                        
Hit any key to stop autoboot:  0                                                
=> bootm fed00000 fe900000                                                      
## Booting image at fed00000 ...                                                
   Image Name:   Linux-2.6.11                                                   
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)                   
   Data Size:    1054435 Bytes =  1 MB                                          
   Load Address: 00000000                                                       
   Entry Point:  00000000                                                       
   Verifying Checksum ... OK                                                    
   Uncompressing Kernel Image ... OK                                            
## Loading RAMDisk Image at fe900000 ...                                        
   Image Name:   uboot ext2 ramdisk rootfs                                      
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)                  
   Data Size:    3195657 Bytes =  3 MB                                          
   Load Address: 00000000                                                       
   Entry Point:  00000000                                                       
   Verifying Checksum ... OK                                                    
   Loading Ramdisk to 0fc9a000, end 0ffa6309 ... OK
