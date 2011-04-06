Return-Path: <carlos.moratelli@digitel.com.br>
Received: from atena.digitel.com.br (ares.digitel.com.br [200.198.105.40])
	by ozlabs.org (Postfix) with ESMTP id 77CB11007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 07:57:32 +1000 (EST)
Subject: Re: sdhc/mpc8536 - SDCard always detected like read-only - SOLVED.
From: Carlos Roberto Moratelli <carlos.moratelli@digitel.com.br>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <1302110338.2647.21.camel@moratelli-host.digitel.com.br>
References: <1302028796.10112.59.camel@moratelli-host.digitel.com.br>
	<20110405190204.GB12723@pengutronix.de>
	<1302031171.10112.66.camel@moratelli-host.digitel.com.br>
	<20110405234824.GB5611@pengutronix.de>
	<1302110338.2647.21.camel@moratelli-host.digitel.com.br>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Apr 2011 18:57:45 -0300
Message-ID: <1302127065.2647.60.camel@moratelli-host.digitel.com.br>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram,

Reading the MPC8536E Chip Errata I saw the SDHC_WP signal polarity is 
reversed to the silicon revision 1.0.

Unfortunately my prototype board  is using revision 1.0. So, I asked to
my hardware team workaround putting an extra inverter for the SDHC_WP
signal.

Now its working fine!

Thanks,

Moratelli



Em Qua, 2011-04-06 às 14:18 -0300, Carlos Roberto Moratelli escreveu:
> I will try address the issue in details.
> 
> When I insert the SDCard, the same is detect like read-only:
> 
> mmcblk0: mmc0:b368 NCard 966 MiB (ro)
> mmcblk0:
> mmc0: starting CMD18 arg 00000000 flags 000000b5
> mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
> mmc0:     CMD12 arg 00000000 flags 0000049d
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> mmc0:     4096 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> p1
> 
> So, I just can mount the filesystem read-only. I can read the fat32
> without problems.
> 
> I tested your sugestion. I used sdhci,wp-inverted in my dtb. This
> changed the behavior. Now the SDCard is detected without the read-only
> flag:
> 
> mmcblk0: mmc0:b368 NCard 966 MiB 
> mmcblk0:
> mmc0: starting CMD18 arg 00000000 flags 000000b5
> mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
> mmc0:     CMD12 arg 00000000 flags 0000049d
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x0000000a
> sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> mmc0:     4096 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> p1
> 
> And, I can mount a rw filesystem:
> 
> #mount  /dev/mmcblock1 /mnt
> #cat /proc/mounts
> ...
> /dev/mmcblock1 /mnt vfat
> rw,relatime,fmask=0000,dmask=0000,allow_utime=0022,codepage=cp437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro 0 0
> ...
> 
> So, I can copy files to the mounted SDCard. But, When I try to umount I
> see the following error mensagens:
> 
> #cp /etc/shadow /mnt
> #ls /mnt
> shadow
> #umount /mnt
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 5944, nr 1, card status
> 0x900
> end_request: I/O error, dev mmcblk0, sector 5944
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 5936, nr 1, card status
> 0x900
> end_request: I/O error, dev mmcblk0, sector 5936
> Buffer I/O error on device mmcblk0p1, logical block 3888
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 2049, nr 1, card status
> 0x900
> end_request: I/O error, dev mmcblk0, sector 2049
> Buffer I/O error on device mmcblk0p1, logical block 1
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 2080, nr 1, card status
> 0x900
> end_request: I/O error, dev mmcblk0, sector 2080
> ...
> 
> I think I need the sdhci,wp-inverted in my dtb. But, it appears that
> more something is necessary.
> 
> Has someone faced this situation?
> 
> Thanks by the help until here.
> 
> Regards,
> 
> Moratelli
> 
> 
> 
> Em Qua, 2011-04-06 às 01:48 +0200, Wolfram Sang escreveu:
> > > 		sdhci@2e000 {
> > > 			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
> > > 			reg = <0x2e000 0x1000>;
> > > 			interrupts = <72 0x2>;
> > > 			interrupt-parent = <&mpic>;
> > > 			/* Filled in by U-Boot */
> > > 			clock-frequency = <0>;
> > > 		};
> > 
> > Hmm, I am not too familiar with those SoCs, yet some 83xx needed
> > 
> > 	sdhci,wp-inverted;
> > 
> > here. Maybe yours, too? Would fit the symptoms.
> > 
> > Regards,
> > 
> >    Wolfram
> > 
> 
