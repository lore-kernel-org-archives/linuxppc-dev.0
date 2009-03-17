Return-Path: <edfuchs@uni-kassel.de>
From: Eduard Fuchs <edfuchs@uni-kassel.de>
To: Linuxppc-dev@ozlabs.org
Subject: Problem with radeonfb on PowerPC 7448&MV64560
Date: Tue, 17 Mar 2009 16:30:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903171630.25340.edfuchs@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

since several days I'm trying to run an ATI 9250 (PCI) graphic card under 
Linux Kernel 2.6.27.19. Nevertheless without success. The kernel shows the 
following message:

videoboot: Booting PCI video card bus 0, function 0, device 7
biosEmu: undefined interrupt 15h called!                     
biosEmu/bios.int42: unknown function AH=0x0, AL=0x7, BL=0x0  
radeonfb (0000:00:07.0): Cannot match card to OF node !      
RADEON: CHIP_FAMILY 10 (0xa)
RADEON: MMIO_BASE 0xf1058000
RADEON: MMIO_BASE_PHYS 0x88000000
radeonfb (0000:00:07.0): Found 0k of SDRAM 64 bits wide videoram
RADEON: Try map FB Phys 0x80000000, size 0, 16777216. 0
radeonfb (0000:00:07.0): cannot map FB
radeonfb: probe of 0000:00:07.0 failed with error -5

This is the PCI initialization :

PCI: Probing PCI hardware                                                                                
pci 0000:00:00.0: unknown header type 7f, ignoring device                                                
pci 0000:00:08.0: PME# supported from D0 D1 D2 D3hot                                                     
pci 0000:00:08.0: PME# disabled                                                                          
pci 0000:00:08.1: PME# supported from D0 D1 D2 D3hot                                                     
pci 0000:00:08.1: PME# disabled                                                                          
pci 0000:00:08.2: PME# supported from D0 D1 D2 D3hot                                                     
pci 0000:00:08.2: PME# disabled                                                                          
PCI: PHB (bus 0) bridge rsrc 0: 0000000000011000-0000000000020fff [0x100], 
parent c0439ce0 (PCI IO)      
PCI BUS: 0xc063e044:0xc0439ce0, 0xc063e060:0xc0439cc4                                                    
PCI: PHB (bus 0) bridge rsrc 1: 0000000080000000-00000000bfffffff [0x200], 
parent c0439cc4 (PCI mem)     
PCI: PHB (bus 0) bridge rsrc 0: 00000000d8080000-00000000d808ffff [0x100], 
parent c0439ce0 (PCI IO)      
PCI: PHB (bus 0) bridge rsrc 1: 0000000060000000-000000007fffffff [0x200], 
parent c0439cc4 (PCI mem)     
PCI: Allocating 0000:00:07.0: Resource 0: 0000000080000000..0000000087ffffff 
[21208]                     
PCI: Allocating 0000:00:07.0: Resource 1: 00000000d8011000..00000000d80110ff 
[20101]                     
PCI: Cannot allocate resource region 1 of device 0000:00:07.0, will remap                                
PCI: Allocating 0000:00:07.0: Resource 2: 0000000088000000..000000008800ffff 
[20200]                     
PCI: Allocating 0000:00:07.1: Resource 0: 0000000090000000..0000000097ffffff 
[21208]                     
PCI: Allocating 0000:00:07.1: Resource 1: 0000000098000000..000000009800ffff 
[20200]                     
PCI: Allocating 0000:00:08.0: Resource 0: 0000000098010000..0000000098010fff 
[20200]                     
PCI: Allocating 0000:00:08.1: Resource 0: 0000000098011000..0000000098011fff 
[20200]                     
PCI: Allocating 0000:00:08.2: Resource 0: 0000000098012000..00000000980120ff 
[20200]                     
PCI: Allocating 0000:00:09.0: Resource 0: 00000000d8011100..00000000d8011107 
[20101]                     
PCI: Cannot allocate resource region 0 of device 0000:00:09.0, will remap                                
PCI: Allocating 0000:00:09.0: Resource 1: 00000000d8011108..00000000d801110b 
[20101]                     
PCI: Cannot allocate resource region 1 of device 0000:00:09.0, will remap                                
PCI: Allocating 0000:00:09.0: Resource 2: 00000000d8011110..00000000d8011117 
[20101]
PCI: Cannot allocate resource region 2 of device 0000:00:09.0, will remap                                
PCI: Allocating 0000:00:09.0: Resource 3: 00000000d8011118..00000000d801111b 
[20101]                     
PCI: Cannot allocate resource region 3 of device 0000:00:09.0, will remap                                
PCI: Allocating 0000:00:09.0: Resource 4: 00000000d8011120..00000000d801112f 
[20101]                     
PCI: Cannot allocate resource region 4 of device 0000:00:09.0, will remap                                
PCI: Allocating 0000:00:09.0: Resource 5: 0000000098012400..00000000980127ff 
[20200]                     
PCI: Allocating 0000:00:0a.0: Resource 0: 000000009c000000..000000009fffffff 
[20200]                     
PCI: Assigning unassigned resouces...                                                                    
bus: 00 index 0 io port: [11000, 20fff]                                                                  
bus: 00 index 1 mmio: [80000000, bfffffff]                                                               
bus: 00 index 0 io port: [d8080000, d808ffff]                                                            
bus: 00 index 1 mmio: [60000000, 7fffffff]


At chipset's MV6450 init, I haven't found any errors. Otherwise an PCI SATA 
controller and an 3Com network card running very well. I have no more ideas, 
where can be the possible problem. Do you have any suggestions?

Best regards

Eduard Fuchs
