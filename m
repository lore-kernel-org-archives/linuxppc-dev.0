Return-Path: <tosettofabio83@libero.it>
Received: from polito.it (unknown [130.192.3.45])
	by ozlabs.org (Postfix) with ESMTP id CB1E1DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 01:11:00 +1000 (EST)
Message-ID: <482317E2.7000308@libero.it>
Date: Thu, 08 May 2008 17:10:26 +0200
From: Fabio Tosetto <tosettofabio83@libero.it>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: MPC5200b MMC over SPI into PSC6
References: <481F4DFD.1000702@libero.it>	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>	<4821A551.3060205@libero.it>
	<fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
In-Reply-To: <fa686aa40805070934t77f8b2b0y2799814b4f131bc8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, maybe it's better to start from the beginning.
Now I'm using a Lite5200b board, just to avoid problems with my 
hardware, and I'm trying to have a bootable kernel.

With kernel version 2.6.24.6 I do the following commands

$ make ARCH=powerpc lite5200_defconfig
$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- uImage

then I copy the arch/powerpc/boot/uImage and a rootfs.uimage on the 
board, but uBoot stops at the beginning:

============================================
U-Boot 1.3.0-g98e2867c-dirty (Feb  7 2008 - 
13:26:28)                          
                                                                                

CPU:   MPC5200B v2.2, Core v1.4 at 198 
MHz                                     
       Bus 132 MHz, IPB 132 MHz, PCI 33 
MHz                                    
Board: Freescale 
Lite5200B                                                     
I2C:   85 kHz, 
ready                                                           
DRAM:  256 
MB                                                                  
FLASH: 32 
MB                                                                   
PCI:   Bus Dev VenId DevId Class 
Int                                           
        00  1a  1057  5809  0680  
00                                           
In:    
serial                                                                  
Out:   
serial                                                                  
Err:   
serial                                                                  
Net:   FEC 
ETHERNET                                                            
IDE:   Bus 0: 
OK                                                               
  Device 0: not 
available                                                      
  Device 1: not 
available                                                      
                                                                                

Type "run flash_nfs" to mount root filesystem over 
NFS                         
                                                                                

Hit any key to stop autoboot:  
0                                               
=>

=> usb 
start                                                                   
(Re)start 
USB...                                                               
USB:   scanning bus for devices... 2 USB Device(s) 
found                       
       scanning bus for storage devices... 1 Storage Device(s) 
found           
=> usb 
scan                                                                    
  NOTE: this command is obsolete and will be phased 
out                        
  please use 'usb storage' for USB storage devices 
information                 
                                                                                

  Device 0: Vendor: USB 2.0  Prod.: Flash Disk       Rev: 
0.00                 
            Type: Removable Hard 
Disk                                          
            Capacity: 963.9 MB = 0.9 GB (1974271 x 
512)                        
=> fatload usb 0 0x03000000 
uImage                                             
reading 
uImage                                                                 
................................................................................
..........................                                                      

                                                                                

1091680 bytes 
read                                                             
=> fatload usb 0 0x04000000 
rootfs.uimage                                      
reading 
rootfs.uimage                                                          
................................................................................
.......... 
924722 bytes read
=> bootm 0x03000000 0x04000000

---------------------
## Booting image at 03000000 
...                                               
   Image Name:   
Linux-2.6.24.4                                                
   Created:      2008-05-08  14:21:24 
UTC                                      
   Image Type:   PowerPC Linux Kernel Image (gzip 
compressed)                  
   Data Size:    1091616 Bytes =  1 
MB                                         
   Load Address: 
00000000                                                      
   Entry Point:  
00000000                                                      
   Verifying Checksum ... 
OK                                                   
   Uncompressing Kernel Image ... 
OK                                           
## Loading RAMDisk Image at 04000000 
...                                       
   Image Name:   RamDisk Image 
RadioNav                                        
   Created:      2007-12-14  16:18:56 
UTC                                      
   Image Type:   PowerPC Linux RAMDisk Image (gzip 
compressed)                 
   Data Size:    924658 Bytes = 903 
kB                                         
   Load Address: 
00000000                                                      
   Entry Point:  
00000000                                                      
   Verifying Checksum ... 
OK                                                   
   Loading Ramdisk to 0fe68000, end 0ff49bf2 ... OK
============================================


So I tried using the deprecated ppc

$ make ARCH=ppc lite5200_defconfig
$ make ARCH=ppc CROSS_COMPILE=powerpc-linux-gnu- uImage

It still doesn't work, but it goes a little further:

=> bootm 0x03000000 
0x04000000                                                 
## Booting image at 03000000 
...                                               
   Image Name:   
Linux-2.6.24.6                                                
   Created:      2008-05-08  14:39:04 
UTC                                      
   Image Type:   PowerPC Linux Kernel Image (gzip 
compressed)                  
   Data Size:    776322 Bytes = 758.1 
kB                                       
   Load Address: 
00000000                                                      
   Entry Point:  
00000000                                                      
   Verifying Checksum ... 
OK                                                   
   Uncompressing Kernel Image ... 
OK                                           
## Loading RAMDisk Image at 04000000 
...                                       
   Image Name:   RamDisk Image 
RadioNav                                        
   Created:      2007-12-14  16:18:56 
UTC                                      
   Image Type:   PowerPC Linux RAMDisk Image (gzip 
compressed)                 
   Data Size:    924658 Bytes = 903 
kB                                         
   Load Address: 
00000000                                                      
   Entry Point:  
00000000                                                      
   Verifying Checksum ... 
OK                                                   
   Loading Ramdisk to 0fe68000, end 0ff49bf2 ... 
OK                            
id mach(): 
done                                                                
MMU:enter                                                                       

MMU:hw 
init                                                                    
MMU:mapin                                                                       

MMU:setio                                                                       

MMU:exit                                                                        

setup_arch: 
enter                                                              
setup_arch: 
bootmem                                                            
arch: exit

============================================

The only way I was able to get something working, even though it sounds 
a little strange to me, is loading the config from powerpc folder but 
compiling in ppc

$ make ARCH=powerpc lite5200_defconfig
$ make ARCH=ppc CROSS_COMPILE=powerpc-linux-gnu- uImage


=> bootm 0x03000000 
0x04000000                                                 
## Booting image at 03000000 
...                                               
   Image Name:   
Linux-2.6.24.4                                                
   Created:      2008-05-08  14:03:26 
UTC                                      
   Image Type:   PowerPC Linux Kernel Image (gzip 
compressed)                  
   Data Size:    1073349 Bytes =  1 
MB                                         
   Load Address: 
00000000                                                      
   Entry Point:  
00000000                                                      
   Verifying Checksum ... 
OK                                                   
   Uncompressing Kernel Image ... 
OK                                           
## Loading RAMDisk Image at 04000000 
...                                       
   Image Name:   RamDisk Image 
RadioNav                                        
   Created:      2007-12-14  16:18:56 
UTC                                      
   Image Type:   PowerPC Linux RAMDisk Image (gzip 
compressed)                 
   Data Size:    924658 Bytes = 903 
kB                                         
   Load Address: 
00000000                                                      
   Entry Point:  
00000000                                                      
   Verifying Checksum ... 
OK                                                   
   Loading Ramdisk to 0fe68000, end 0ff49bf2 ... 
OK                            
id mach(): 
done                                                                
MMU:enter                                                                       

MMU:hw 
init                                                                    
MMU:mapin                                                                       

MMU:setio                                                                       

MMU:exit                                                                        

setup_arch: 
enter                                                              
setup_arch: 
bootmem                                                            
arch: 
exit                                                                     
[    0.000000] Linux version 2.6.24.4 (ftosetto@osstlab-build1) (gcc 
version 4.1
.2 (Sourcery G++ Lite 4.1-51)) #3 Thu May 8 16:03:21 CEST 
2008                 
[    0.000000] Zone PFN 
ranges:                                                
[    0.000000]   DMA             0 ->    
65536                                 
[    0.000000]   Normal      65536 ->    
65536                                 
[    0.000000] Movable zone start PFN for each 
node                            
[    0.000000] early_node_map[1] active PFN 
ranges                             
[    0.000000]     0:        0 ->    
65536                                     
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pag
es: 
65024                                                                      
[    0.000000] Kernel command 
line:                                            
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 
bytes)            
[   91.768263] console [ttyPSC0] enabled  
...


Do you have any idea about how to make it working doing all the stuff 
with ARCH=powerpc?

Best regards,
Fabio



Grant Likely ha scritto:
> On Wed, May 7, 2008 at 6:49 AM, Fabio Tosetto <tosettofabio83@libero.it> wrote:
>   
>>  I've tried to port my exesting configurations to the powerpc tree but some
>> configurations files are missing.
>>     
>
> First, create a new .dts file for your board in arch/powerpc/boot/dts.
> (just copy the lite5200.dts file).  Modify the .dts to have your
> board's name (in the form "<vendor>,<boardname>") in the compatible
> and model properties.
>
> Next, add your boards name to the list of boards in
> arch/powerpc/platforms/52xx/mpc5200_simple.c.
>
>   
>>  I need to set PSC3 - PSC4 in uart mode:
>>  before in file *arch/ppc/platforms/lite5200.c* I added
>>
>>  struct mpc52xx_psc_func mpc52xx_psc_functions[] = {
>>          {       .id     = 3,
>>                  .func   = "uart",
>>          },
>>          {       .id     = 4,
>>                  .func   = "uart",
>>          },
>>          {       .id     = -1,   /* End entry */
>>                  .func   = NULL,
>>          }
>>  };
>>     
>
> Edit your boards .dts file and uncomment PSCs 3 and 4.  Comment out
> PSC1 if you aren't using it.
>
>   
>>  I need to set PSC4 as a low level debug: *
>>  *before in file  *arch/ppc/platforms/lite5200.h *I added
>>
>>  #define MPC52xx_PF_CONSOLE_PORT 4    /* PSC4 */
>>     
>
> I don't think we have any early debug enabled yet in arch/powerpc for
> the mpc5200.
>
>   
>>  Finally I need to set  the virtual memory translation on a range of 128 MB:
>>  before in file *arch/ppc/kernel/head.S *I added
>>
>>  /*ori    r11,r11,BL_128M<<2|0x2    set up BAT registers for 604 */
>>
>>  ori    r11,r11,BL_128M<<2|0x2    /* set up BAT registers for 604 */
>>
>>  could you please explain me how to do the same operations in powerpc tree??
>>     
>
> New file is arch/powerpc/kernel/head_32.S.  I don't think that is the
> cleanest way to do it though.  Why do you need to change the BAT
> mapping from 256 to 128?
>
> Cheers,
> g.
>
>   
