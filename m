Return-Path: <info@moreframe.com>
Received: from mxvip28.hichina.com (unknown [218.30.102.158])
	by ozlabs.org (Postfix) with ESMTP id 182F66868F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Nov 2005 02:15:09 +1100 (EST)
Received: from 203.88.32.9 (HELO sz?hw?swordz) (envelope-from
	info@moreframe.com)
	by mxvip28.hichina.com (quarkmail-1.2.1) with ESMTP id S5757227AbVKEPOu
	for linuxppc-embedded@ozlabs.org; Sat, 5 Nov 2005 23:14:50 +0800
Date: Sat, 5 Nov 2005 23:14:38 +0800
From: "info" <info@moreframe.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-ID: <1131203694$92719$17264408@info@moreframe.com>
Subject: Re: Re: Help needed Linux-2.6 - MPC8540
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy, Kumar

The problems is solved, the reason is not PHY driver but u-boot. I use u-boot-1.1.1 from GDAtech, I think it has some bugs on the PHY setup even if it is working OK with kernel-2.4.x. When I update to u-boot-1.1.3, every thing is OK.
 

>Andy, Kumar
>
>Thank you for your help!
>GDAtech only give me linux-2.4.27 binary file for RMC-G8500 card, I try to port 2.6.13 for that card myself.
>
>Today, I download linux-2.6.13.tar.bz2 and patch-2.6.14-rc5.bz2 from kernel.org. 
>I download http://lwn.net/Articles/146253/ "Patch: Gianfar PHY Layer Update".
>I download http://ozlabs.org/pipermail/linuxppc-embedded/2005-October/020593.html  "[PATCH] 85xx PHY Platform Update"
>I patch and build them together get a linux 2.6.14-rc5 for MPC8540, try it on RMC-G8500 card
>
>U-Boot 1.1.1 (Aug 10 2004 - 11:01:21)
>
>Motorola PowerPC ProcessorID=00000000 Rev. PVR=80200020
>Board: GDA Technologies RMC-G8500 [PowerQUICC III]
>        CPU: 825 MHz
>        CCB: 330 MHz
>        DDR: 165 MHz
>        LBC: 82 MHz
>L1 D-cache 32KB, L1 I-cache 32KB enabled.
>I2C:   ready
>DRAM:  256 MB
>8540 in PCI Host Mode.
>8540 is the PCI Arbiter.
>FLASH:  8 MB
>L2 cache enabled: 256KB
>In:    serial
>Out:   serial
>Err:   serial
>Net:   MOTO ETHERNET
>Hit any key to stop autoboot:  0 
>RMCG8500#>tftp 200000 uImage; tftp 400000 your.ramdisk.u-boot; bootm 200000 400000
>Using MOTO ETHERNET device
>TFTP from server 192.96.134.135; our IP address is 192.96.134.136
>Filename 'uImage'.
>Load address: 0x200000
>Loading: #################################################################
>         #################################################################
>         #################################################################
>         ################################
>done
>Bytes transferred = 1159376 (11b0d0 hex)
>Using MOTO ETHERNET device
>TFTP from server 192.96.134.135; our IP address is 192.96.134.136
>Filename 'your.ramdisk.u-boot'.
>Load address: 0x400000
>Loading: #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         ########################################
>done
>Bytes transferred = 3530818 (35e042 hex)
>## Booting image at 00200000 ...
>   Image Name:   Linux-2.6.14-rc5
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    1159312 Bytes =  1.1 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
>## Loading RAMDisk Image at 00400000 ...
>   Image Name:   zzz ppc ramdisk
>   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>   Data Size:    3530754 Bytes =  3.4 MB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Loading Ramdisk to 0fc54000, end 0ffb2002 ... OK
>Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
>Linux version 2.6.14-rc5 (root@ppclinux) (gcc version 3.3.3 (Yellow Dog Linux 3.3.3-16.ydl.4)) #1 Mon Oct 24 13:22:56 EDT 2005
>Built 1 zonelists
>Kernel command line: console=ttyS0,115200 root=/dev/ram rw doPci=1
>OpenPIC Version 1.2 (1 CPUs and 60 IRQ sources) at fcfbb000
>PID hash table entries: 2048 (order: 11, 32768 bytes)
>Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
>Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
>Memory: 253440k available (1904k kernel code, 516k data, 132k init, 0k highmem)
>Mount-cache hash table entries: 512
>checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
>softlockup thread 0 started up.
>Freeing initrd memory: 3448k freed
>NET: Registered protocol family 16
>PCI: Probing PCI hardware
>Generic PHY: Registered new driver
>SCSI subsystem initialized
>Generic RTC Driver v1.07
>i8042.c: i8042 controller self test timeout.
>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
>ttyS0 at MMIO 0xfdf04500 (irq = 26) is a 16550A
>ttyS1 at MMIO 0xfdf04600 (irq = 26) is a 16550A
>io scheduler noop registered
>io scheduler anticipatory registered
>io scheduler deadline registered
>io scheduler cfq registered
>RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
>loop: loaded (max 8 devices)
>Gianfar MII Bus: probed
>
>
>!!STOP HERE
>
>
>
>>
>>On Oct 23, 2005, at 10:39, info wrote:
>>
>>> Junita
>>>
>>> Sorry to disturbed you. I find your question in the http:// 
>>> ozlabs.org mail list.
>>> Have you fixed the bug in gianfar_phy.c?
>>> tempval = gfar_read(&priv-> regs-> dmactrl);
>>> tempval |= (DMACTRL_GRS | DMACTRL_GTS);
>>> gfar_write(&priv-> regs-> dmactrl, tempval);
>>>
>>> while (!(gfar_read(&priv-> regs-> ievent) & (IEVENT_GRSC |  
>>> IEVENT_GTSC)))
>>> cpu_relax();
>>>
>>> /* Reset MAC layer */
>>> gfar_write(&priv-> regs-> maccfg1, MACCFG1_SOFT_RESET);
>>
>>
>>I'm a bit confused by the statement above.  The code you present is  
>>from gianfar.c, and is certainly not a bug.  It is possible you are  
>>using an older version of the code, which has a bug, which is fixed  
>>by adding these lines above the code you show:
>>
>>         tempval = gfar_read(&priv->regs->dmactrl);
>>         tempval &= ~(DMACTRL_GRS | DMACTRL_GTS);
>>         gfar_write(&priv->regs->dmactrl, tempval);
>>
>>This fixes a problem where setting GRS and GTS when they're already  
>>set doesn't initiate the graceful stop.  But if you are using 2.6.13,  
>>you should have this fix.  I suspect that, like I told Junita, you  
>>need to make sure the platform code has the right CCSRBAR value set up.
>>
>>>
>>> I buy a RMC-G8500 card from GDAtech, I try to build linux-2.6.13.4  
>>> from kernel.org and meet the same problems as you had. I test the  
>>> same code on freescale 8540_ADS board, it is good.Can you share  
>>> some infomation of your progress?
>>
>>
>>I'm not familiar with this card.  Are you sure there's support for it  
>>in your source tree?
>>
>>
>>Andy Fleming
>>
>>.
>
>
>>You need the corresponding patches that are in the netdev tree for  
>>the PHY subsystem.
>
>>- kumar
>
>>On Oct 24, 2005, at 9:49 AM, info wrote:
>
>> Andy, Kumar
>>
>> I try this patch for RMC-G8500 from GDAtech, error message below:
>> ---------------------------------------------------------------------- 
>> -----------
>>  [root@ppclinux linux-2.6.13]# make uImage
>>   CHK     include/linux/version.h
>>   CHK     include/linux/compile.h
>>   CHK     usr/initramfs_list
>>   CC      drivers/net/gianfar.o
>> drivers/net/gianfar.c: In function `gfar_probe':
>> drivers/net/gianfar.c:217: error: structure has no member named  
>> `phy_reg_addr'
>> drivers/net/gianfar.c: In function `init_phy':
>> drivers/net/gianfar.c:452: error: structure has no member named  
>> `phyid'
>> drivers/net/gianfar.c: In function `stop_gfar':
>> drivers/net/gianfar.c:636: error: structure has no member named  
>> `interruptPHY'
>> drivers/net/gianfar.c: In function `gfar_phy_startup_timer':
>> drivers/net/gianfar.c:1818: error: structure has no member named  
>> `interruptPHY'
>> drivers/net/gianfar.c:1826: error: structure has no member named  
>> `interruptPHY'
>> make[2]: *** [drivers/net/gianfar.o] Error 1
>> make[1]: *** [drivers/net] Error 2
>> make: *** [drivers] Error 2
>>
>> ---------------------------------------------------------------------- 
>> -----------
>> because???
>>
>>  /* Internal interrupts are all Level Sensitive, and Positive  
>> Polarity */
>> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
>> --- a/include/linux/fsl_devices.h
>> +++ b/include/linux/fsl_devices.h
>> @@ -47,14 +47,19 @@
>>  struct gianfar_platform_data {
>>      /* device specific information */
>>      u32 device_flags;
>> -    u32 phy_reg_addr;
>>
>>      /* board specific information */
>>      u32 board_flags;
>> -    u32 phy_flags;
>> -    u32 phyid;
>> -    u32 interruptPHY;
>> +    const char *bus_id;
>>      u8 mac_addr[6];
>> +};
>> +
>>
>>
>> ---------------------------------------------------------------------- 
>> ---------------------
>> <This patch updates the 85xx platform code to support the new PHY  
>> Layer.
>> <
>> <Signed-off-by: Andy Fleming <afleming at freescale.com>
>> <Signed-off-by: Kumar Gala <Kumar.gala at freescale.com>
>> <
>> <
>> <diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/ 
>> platforms/85xx/mpc8540_ads.c
>> <--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
>> <+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
>> <@@ -53,6 +53,10 @@
>> <
>> < #include <syslib/ppc85xx_setup.h>
>> <
>> <+static const char *GFAR_PHY_0 = "phy0:0";
>> <+static const char *GFAR_PHY_1 = "phy0:1";
>> <+static const char *GFAR_PHY_3 = "phy0:3";
>> <+
>> < /*  
>> ********************************************************************** 
>> **
>> <  *
>> <  * Setup the architecture
>> <@@ -64,6 +68,7 @@ mpc8540ads_setup_arch(void)
>>
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
