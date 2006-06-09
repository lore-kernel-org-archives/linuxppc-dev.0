Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D4B8A67C2A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 08:41:21 +1000 (EST)
To: "Scott Coulter" <scott.coulter@cyclone.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: booting Linux 2.6.15 using a ramdisk and greater than 512MB of
	DRAM
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Jun 2006 15:28:50 EDT."
	<43EB80E07C42E1408726E4905FB96B0466C6C0@CYBORG3.cyclone.com>
Date: Sat, 10 Jun 2006 00:41:18 +0200
Sender: wd@denx.de
Message-Id: <20060609224118.AE6643535E0@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Scott,

in message <43EB80E07C42E1408726E4905FB96B0466C6C0@CYBORG3.cyclone.com> you wrote:
> 
> I am not sure if this is a linux question or a u-boot question.  I have
> a custom MPC8540 board running U-boot 1.1.4.  With a NFS root
> configuration, I have booted and run 2.6.15 with memory from 256MB to
> 2GB.  If I build a ramdisk image (or even if I use the ramdisk image
> with the 85xx version of ELDK 4.0) and then combine it with the kernel
> image (vmlinux.gz) using "mkimage", the linux boot blows out with an
> oops if I boot the board with more that 512MB of DRAM.  From the U-boot

Do you see something like

	mem_pieces_remove: [3fe32000,3ff93ec7) not in any region

in your boot messages?

> output, it looks like the ramdisk image is getting copied to the upper
> portion of DRAM.  Is it possible that the kernel doesn't map enough DRAM
> to allow the image to be read?
> 
> I haven't spent a lot of time debugging this once I saw that the 512MB
> configuration worked OK.  Has anyone run into this?

Yes. Normally you can use only use 0x30000000 (768MB)  RAM  (lowmem);
if  you  need  more  you  have  to  change your kernel configuration,
including shifting the kernel start address.

For example, on on a 1 GB system something like this could work:

	CONFIG_ADVANCED_OPTIONS=y
	CONFIG_LOWMEM_SIZE_BOOL=y
	CONFIG_LOWMEM_SIZE=0x40000000
	CONFIG_KERNEL_START_BOOL=y
	CONFIG_KERNEL_START=0xa0000000
	# CONFIG_CONSISTENT_START_BOOL is not set
	# CONFIG_CONSISTENT_SIZE_BOOL is not set
	# CONFIG_BOOT_LOAD_BOOL is not set


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Disobedience:  The silver lining to the cloud of servitude.
- Ambrose Bierce
