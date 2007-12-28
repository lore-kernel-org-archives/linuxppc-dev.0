Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E0902DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Dec 2007 14:03:26 +1100 (EST)
Message-ID: <4774677D.3060309@pikatech.com>
Date: Thu, 27 Dec 2007 22:03:25 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Problems with arch/powerpc
References: <47742519.8060502@pikatech.com>
	<20071227194753.56bc92f8@vader.jdub.homelinux.org>
In-Reply-To: <20071227194753.56bc92f8@vader.jdub.homelinux.org>
Content-Type: multipart/mixed; boundary="------------000501070706060801010406"
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000501070706060801010406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Josh Boyer wrote:
> Can you post the full boot messages (send privately if you'd like). One
> thing to make sure of is if all the properties in the DTS file that say
> "Filled in by zImage wrapper" are actually getting filled in.
>   
I have attached a boot log. The ethernet and IP addresses have been 
modified, but everything else is correct.

I checked all the dts entries marked by /* Filled in by zImage */ by 
checking /proc/device-tree and they all match what is printed after the 
log message "Uncompressing Kernel Image ... OK".

FYI: It is a 533MHz PPC but the HW guys read the spec wrong and are 
running the system clock at 66.0MHz rather than 66.6MHz, so the 528MHz 
value is correct.

Cheers,
    Sean

--------------000501070706060801010406
Content-Type: text/plain;
 name="boot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot"

U-Boot 1.3.0-gf92edbd8-dirty (Dec  7 2007 - 11:06:34)

CPU:   AMCC PowerPC 440EP Rev. C at 533.333 MHz (PLB=133, OPB=66, EBC=66 MHz)
       I2C boot EEPROM enabled
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
, PCI async ext clock used       32 kB I-Cache 32 kB D-Cache


   Board: PIKA Embedded Appliance
I2C:   ready
DRAM:  256 MB
FLASH: 64 MB
NAND:  64 MiB
In:    serial
Out:   serial
Err:   serial
Protected 2 sectors


FPGA download...complete.

FPGA code revision 1.2.2.0


Starting board diagnostics:


   1. RAM walking bit test, first bank...                       test complete.
   2. RAM walking bit test, second bank...                      test complete.
   3. FPGA walking bit test...                                  test complete.
   4. Skipping user test - start_test_addr or end_test_addr env. vars not set.

Board diagnostics complete.
Net:   ppc_4xx_eth0

Type "run flash_nfs" to mount root filesystem over NFS

Hit any key to stop autoboot:  0 
Waiting for PHY auto negotiation to complete. done
ENET Speed is 100 Mbps - FULL duplex connection (EMAC0)
Using ppc_4xx_eth0 device
TFTP from server 192.168.0.164; our IP address is 192.168.0.99
Filename 'uImage'.
Load address: 0x200000
Loading: #################################################################
         #################################################################
         #################################################################
         #############################################################
done
Bytes transferred = 1308159 (13f5ff hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.24-rc6-pika
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1308095 Bytes =  1.2 MB
   Load Address: 00400000
   Entry Point:  004003c8
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
CPU clock-frequency <- 0x1f78a400 (528MHz)
CPU timebase-frequency <- 0x1f78a400 (528MHz)
/plb: clock-frequency <- 7de2900 (132MHz)    
/plb/opb: clock-frequency <- 3ef1480 (66MHz)
/plb/opb/ebc: clock-frequency <- 3ef1480 (66MHz)
/plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
Memory <- <0x0 0x0 0x10000000> (256MB)                     
ENET0: local-mac-address <- <mac address>
                                             
zImage starting: loaded at 0x00400000 (sp: 0x0ff2a558)
Allocating 0x2b84a0 bytes for kernel ...              
gunzipping (0x00000000 <- 0x0040d000:0x006ba364)...done 0x297408 bytes
                                                                      
Linux/PowerPC load: root=/dev/nfs rw nfsroot=192.168.x.x:/usr/src/eldk/taco ip=192.168.x.x:192.168.x.x:192.168.x.x:255.255.252.0:tigger:eth0:off panic=1 console=ttyS0,1150
Finalizing device tree... flat tree at 0x6c7300                                                                                                                                
Using Taco machine description                 
Linux version 2.6.24-rc6-pika (seanm@lappy) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #14 Thu Dec 27 16:33:16 EST 2007
console [udbg0] enabled                                                                                               
setup_arch: bootmem    
arch: exit         
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges 
    0:        0 ->    65536        
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/nfs rw nfsroot=192.168.x.x:/usr/src/eldk/taco ip=192.168.x.x:192.168.x.x:192.168.x.x:255.255.252.0:tigger:eth0:off panic=1 console=ttyS0,110
UIC0 (32 IRQ sources) at DCR 0xc0                                                                                                                                              
UIC1 (32 IRQ sources) at DCR 0xd0
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[79364e] shift[22] registered
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)  
Memory: 256768k/262144k available (2516k kernel code, 5056k reserved, 116k data, 129k bss, 140k init)
Mount-cache hash table entries: 512                                                                  
net_namespace: 64 bytes            
NET: Registered protocol family 16
                                  
SCSI subsystem initialized
NET: Registered protocol family 2
Time: timebase clocksource has been installed.
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)       
TCP: Hash tables configured (established 8192 bind 8192) 
TCP reno registered                                     
JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
io scheduler noop registered                        
io scheduler anticipatory registered (default)
io scheduler deadline registered              
io scheduler cfq registered     
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xef600300 (irq = 16) is a 16550A           
                                                             console handover: boot [udbg0] -> real [ttyS0]
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize      
PPC 4xx OCP EMAC driver, version 3.54
MAL v1 /plb/mcmal, 4 TX channels, 2 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
/plb/opb/emac-zmii@ef600d00: bridge in RMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:1e:84:ff:n.n
eth0: found Generic MII PHY (0x01)
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
eth0: link is down
IP-Config: Complete:
      device=eth0, addr=192.168.x.x, mask=255.255.252.0, gw=192.168.x.x,
     host=tigger, domain=, nis-domain=(none),
     bootserver=192.168.x.x, rootserver=192.168.x.x, rootpath=
Looking up port of RPC 100003/2 on 192.168.x.x
eth0: link is up, 100 FDX, pause enabled
Looking up port of RPC 100005/1 on 192.168.x.x
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 140k init
init started: BusyBox v1.6.1 (2007-09-17 15:31:56 EDT) multi-call binary
starting pid 16, tty '': '/sbin/syslogd'
starting pid 19, tty '': '/etc/rc.S'
starting pid 28, tty '': '/sbin/getty'

tigger login: 

--------------000501070706060801010406--
