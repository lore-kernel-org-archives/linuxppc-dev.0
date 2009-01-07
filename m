Return-Path: <pczanik@fang.fa.gau.hu>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id A1AEE474FC
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 18:23:41 +1100 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	0F8FB31A9D7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 08:23:38 +0100 (CET)
Received: from [192.168.2.179] ([82.131.202.188])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KD300JU7B7BRV70@invitel.hu> for
	linuxppc-dev@ozlabs.org; Wed, 07 Jan 2009 08:23:38 +0100 (CET)
Date: Wed, 07 Jan 2009 08:23:27 +0100
From: Peter Czanik <pczanik@fang.fa.gau.hu>
Subject: mpc5200 ATA DMA
To: linuxppc-dev@ozlabs.org
Message-id: <4964586F.5090408@fang.fa.gau.hu>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I did a few tests this morning with the new DMA code on the EFIKA and
got the following results:

- ﻿libata.force=udma2

SCSI subsystem
initialized                                                                         

ata: MPC52xx IDE/ATA libata
driver                                                                 
scsi0 :
mpc52xx_ata                                                                                

ata1: PATA max PIO4 ata_regs 0xf0003a00 irq
135                                                    
ata1.00: ATA-6: ST980815A, 3.ALD, max
UDMA/100                                                     
ata1.00: 156301488 sectors, multi 0:
LBA48                                                         
ata1.00: FORCE: xfer_mask set to
udma2                                                             
ata1.00: configured for
UDMA/33                                                                    
scsi 0:0:0:0: Direct-Access     ATA      ST980815A        3.AL PQ: 0
ANSI: 5                       
Creating device nodes with
udev                                                                    
udevd version 128
started                                                                          

ppc-of-ohci f0001000.usb: OF
OHCI                                                                  
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number
1                            
ppc-of-ohci f0001000.usb: irq 134, io mem
0xf0001000                                               
usb usb1: configuration #1 chosen from 1
choice                                                    
hub 1-0:1.0: USB hub
found                                                                         

hub 1-0:1.0: 2 ports
detected                                                                      

usb usb1: New USB device found, idVendor=1d6b,
idProduct=0001                                      
usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1                                 
usb usb1: Product: OF
OHCI                                                                         

usb usb1: Manufacturer: Linux 2.6.27.7-99.1-genesi
ohci_hcd                                        
usb usb1: SerialNumber: PPC-OF
USB                                                                 
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
 sda:                                                                                              

                                                                                                   

After the udevadm settle timeout, the events queue
contains:                                       
                                                                                                   

304:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0                              

305:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/bsg/0:0:0:0                  

306:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/scsi_device/0:0:0:0          

427:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/scsi_disk/0:0:0:0            

                                                                                                   

                                                                                                   

Boot logging started on /dev/ttyPSC0(/dev/console) at Wed Jan  7
06:58:13 2009                     
<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen                                
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096
in                                 
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)                               
ata1.00: status: { DRDY
}                                                                          
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1.00:
disabled                                                                                  

ata1: soft resetting
link                                                                          

ata1: EH
complete                                                                                  

sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
ldm_validate_partition_table(): Disk read
failed.                                                  
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
Dev sda: unable to read RDB block
0                                                                
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 24
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 24
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
Waiting for device /dev/sda11 to appear:
..............................Could not find /dev/sda11.
Want me to fall back to /dev/sda11? (Y/n)

- libata.force=mwdma2 is just about the same:

scsi0 :
mpc52xx_ata                                                                                

ata1: PATA max PIO4 ata_regs 0xf0003a00 irq
135                                                    
ata1.00: ATA-6: ST980815A, 3.ALD, max
UDMA/100                                                     
ata1.00: 156301488 sectors, multi 0:
LBA48                                                         
ata1.00: FORCE: xfer_mask set to
mwdma2                                                            
ata1.00: configured for
MWDMA2                                                                     
scsi 0:0:0:0: Direct-Access     ATA      ST980815A        3.AL PQ: 0
ANSI: 5                       
Creating device nodes with
udev                                                                    
udevd version 128
started                                                                          

ppc-of-ohci f0001000.usb: OF
OHCI                                                                  
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number
1                            
ppc-of-ohci f0001000.usb: irq 134, io mem
0xf0001000                                               
usb usb1: configuration #1 chosen from 1
choice                                                    
hub 1-0:1.0: USB hub
found                                                                         

hub 1-0:1.0: 2 ports
detected                                                                      

usb usb1: New USB device found, idVendor=1d6b,
idProduct=0001                                      
usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1                                 
usb usb1: Product: OF
OHCI                                                                         

usb usb1: Manufacturer: Linux 2.6.27.7-99.1-genesi
ohci_hcd                                        
usb usb1: SerialNumber: PPC-OF
USB                                                                 
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
 sda:                                                                                              

                                                                                                   

After the udevadm settle timeout, the events queue
contains:                                       
                                                                                                   

304:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0                              

305:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/bsg/0:0:0:0                  

306:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/scsi_device/0:0:0:0          

427:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/scsi_disk/0:0:0:0            

                                                                                                   

                                                                                                   

Boot logging started on /dev/ttyPSC0(/dev/console) at Wed Jan  7
07:05:50 2009                     
<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen                                
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096
in                                 
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)                               
ata1.00: status: { DRDY
}                                                                          
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1.00:
disabled                                                                                  

ata1: soft resetting
link                                                                          

ata1: EH
complete                                                                                  

sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
ldm_validate_partition_table(): Disk read
failed.                                                  
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
Dev sda: unable to read RDB block
0                                                                
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 24
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 24
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
Waiting for device /dev/sda11 to appear:
..............................Could not find /dev/sda11.
Want me to fall back to /dev/sda11? (Y/n)

- just as libata.force=mwdma1

SCSI subsystem
initialized                                                                         

ata: MPC52xx IDE/ATA libata
driver                                                                 
scsi0 :
mpc52xx_ata                                                                                

ata1: PATA max PIO4 ata_regs 0xf0003a00 irq
135                                                    
ata1.00: ATA-6: ST980815A, 3.ALD, max
UDMA/100                                                     
ata1.00: 156301488 sectors, multi 0:
LBA48                                                         
ata1.00: FORCE: xfer_mask set to
mwdma1                                                            
ata1.00: configured for
MWDMA1                                                                     
scsi 0:0:0:0: Direct-Access     ATA      ST980815A        3.AL PQ: 0
ANSI: 5                       
Creating device nodes with
udev                                                                    
udevd version 128
started                                                                          

ppc-of-ohci f0001000.usb: OF
OHCI                                                                  
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number
1                            
ppc-of-ohci f0001000.usb: irq 134, io mem
0xf0001000                                               
usb usb1: configuration #1 chosen from 1
choice                                                    
hub 1-0:1.0: USB hub
found                                                                         

hub 1-0:1.0: 2 ports
detected                                                                      

usb usb1: New USB device found, idVendor=1d6b,
idProduct=0001                                      
usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1                                 
usb usb1: Product: OF
OHCI                                                                         

usb usb1: Manufacturer: Linux 2.6.27.7-99.1-genesi
ohci_hcd                                        
usb usb1: SerialNumber: PPC-OF
USB                                                                 
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
 sda:                                                                                              

                                                                                                   

After the udevadm settle timeout, the events queue
contains:                                       
                                                                                                   

304:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0                              

305:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/bsg/0:0:0:0                  

306:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/scsi_device/0:0:0:0          

427:
/devices/f0000000.builtin/f0003a00.ata/host0/target0:0:0/0:0:0:0/scsi_disk/0:0:0:0            

                                                                                                   

                                                                                                   

Boot logging started on /dev/ttyPSC0(/dev/console) at Wed Jan  7
07:09:38 2009                     
<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
frozen                                
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096
in                                 
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4
(timeout)                               
ata1.00: status: { DRDY
}                                                                          
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1: soft resetting
link                                                                          

ata1.00: revalidation failed
(errno=-2)                                                            
ata1.00:
disabled                                                                                  

ata1: soft resetting
link                                                                          

ata1: EH
complete                                                                                  

sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
ldm_validate_partition_table(): Disk read
failed.                                                  
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block
0                                                    
Dev sda: unable to read RDB block
0                                                                
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK                  
end_request: I/O error, dev sda, sector
0                                                          
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 24
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 24
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
end_request: I/O error, dev sda, sector 0
Waiting for device /dev/sda11 to appear:
..............................Could not find /dev/sda11.
Want me to fall back to /dev/sda11? (Y/n)

- no kernel parameters: no trouble at all

SCSI subsystem
initialized                                                                         

ata: MPC52xx IDE/ATA libata
driver                                                                 
scsi0 :
mpc52xx_ata                                                                                

ata1: PATA max PIO4 ata_regs 0xf0003a00 irq
135                                                    
ata1.00: ATA-6: ST980815A, 3.ALD, max
UDMA/100                                                     
ata1.00: 156301488 sectors, multi 0:
LBA48                                                         
ata1.00: configured for
PIO4                                                                       
scsi 0:0:0:0: Direct-Access     ATA      ST980815A        3.AL PQ: 0
ANSI: 5                       
Creating device nodes with
udev                                                                    
udevd version 128
started                                                                          

ppc-of-ohci f0001000.usb: OF
OHCI                                                                  
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number
1                            
ppc-of-ohci f0001000.usb: irq 134, io mem
0xf0001000                                               
usb usb1: configuration #1 chosen from 1
choice                                                    
hub 1-0:1.0: USB hub
found                                                                         

hub 1-0:1.0: 2 ports
detected                                                                      

usb usb1: New USB device found, idVendor=1d6b,
idProduct=0001                                      
usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1                                 
usb usb1: Product: OF
OHCI                                                                         

usb usb1: Manufacturer: Linux 2.6.27.7-99.1-genesi
ohci_hcd                                        
usb usb1: SerialNumber: PPC-OF
USB                                                                 
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors:
(80.0GB/74.5GiB)                            
sd 0:0:0:0: [sda] Write Protect is
off                                                             
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA            
 sda: RDSK (512) sda1 (LNX^@)(res 2 spb 1) sda2 (SWP^@)(res 2 spb 1)
sda3 (EXT^C)(res 2 spb 1) sda4)
sd 0:0:0:0: [sda] Attached SCSI
disk                                                               
Boot logging started on /dev/ttyPSC0(/dev/console) at Wed Jan  7
07:19:21 2009                     
Waiting for device /dev/sda11 to appear: 
ok                                                       
fsck 1.41.1
(01-Sep-2008)                                                                          

[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a
/dev/sda11                                                 
/dev/sda11: clean, 100696/429088 files, 569041/1714938
blocks                                      
fsck succeeded. Mounting root device
read-write.                                                   
Mounting root
/dev/sda11                                                                           


Bye,
CzP
