Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id 8A1F3684CB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 09:46:36 +1000 (EST)
To: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Oct 2005 09:05:01 +1000."
	<434AF39D.8050709@rftechnology.com.au>
Date: Tue, 11 Oct 2005 01:46:14 +0200
Sender: wd@denx.de
Message-Id: <20051010234614.1FE2A353D84@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <434AF39D.8050709@rftechnology.com.au> you wrote:
> I have 2.6.14 kernel and the following partitions (defined in U-Boot 1.1.4)
> mtdparts=0:1024k(Linux),4096k(root),2048k(Unused),512k(U-Boot),512()

Are you sure that your flash device name in Linux is just "0" ? Which
board is this?

> And I tried different bootargs
> bootargs=console=ttyCPM0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2
...
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(31,1)
> 
> I tried different minor numbers but result the same. Does anybody know 
> what type of root param I should use for 2.6.14 - mtdblock1 or 31:01?
> Can anybody suggest me what I missed? One of the reasons I see that I 
> may have a corrupted root.

The kernel boot messages  contain  a  section  about  MTD  partitions
found, something like this:


	...
	io scheduler noop registered
	io scheduler anticipatory registered
	io scheduler deadline registered
	io scheduler cfq registered
	RAMDISK driver initialized: 4 RAM disks of 4096K size 1024 blocksize
	loop: loaded (max 8 devices)
	PPC 4xx OCP EMAC driver, version 3.53
	mal0: initialized, 4 TX channels, 2 RX channels
	eth0: emac0, MAC 00:50:c2:1e:af:fe
	eth0: found Generic MII PHY (0x00)
	eth1: emac1, MAC 00:50:c2:1e:af:fd
	eth1: found Generic MII PHY (0x01)
	PPChameleon: Found 1 x16 devices at 0x0 in 16-bit bank
	 Amd/Fujitsu Extended Query Table at 0x0040
	PPChameleon: Swapping erase regions for broken CFI table.
	number of CFI chips: 1
	cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
===>	Creating 3 MTD partitions on "PPChameleon":
===>	0x00000000-0x00180000 : "linux"
===>	0x00180000-0x003c0000 : "user"
===>	0x003c0000-0x00400000 : "u-boot"
	...

Can you see these messages on your system? Is the flash  name  really
"0"? Are the partitions correct?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Technology is dominated by those who manage what they do  not  under-
stand.
