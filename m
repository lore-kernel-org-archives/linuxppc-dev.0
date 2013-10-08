Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 369FD2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 08:48:28 +1100 (EST)
Message-ID: <1381268850.7979.279.camel@snotra.buserror.net>
Subject: Re: Linux 2.6.32 PowerPC MTD partition mounted at boot
From: Scott Wood <scottwood@freescale.com>
To: Dorin D <dorin1234@outlook.com>
Date: Tue, 8 Oct 2013 16:47:30 -0500
In-Reply-To: <BAY176-W43D0B5AD1BD2454470D8AFA6210@phx.gbl>
References: <BAY176-W43D0B5AD1BD2454470D8AFA6210@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-18 at 22:43 -0400, Dorin D wrote:
> I am working on bringing up two Linux systems, both based on Freescale
> PowerPC devices, one is a MPC8349, the other a P1020. I was able to
> build, install and boot the kernel on both cards. The kernel is 2.6.32
> and the  toolchains  are coming from the LTIBs packages from
> Freescale. 
> 
> Both cards have a 32 MByte NOR flash memory (AMD) boot flash. I have
> Uboot, kernel, RAM disk image and DTB in the boot flash and I want to
> use the spare space (about 20 MBytes) as flash file system. 
> 
> I have the following problem : the P1020 board boots fine using the
> RAM disk with the flash in the device tree , shows the flash device
> partitions (JFFS2) and DOESN"T try to mount a flash partition as root.
> The MPC8349 boots fine from the RAM disk but, after identifying the
> flash partitions, the kernel panics because is looking for a flash
> partition to mount as root partition and none of them is usable (not
> formatted). If I remove the flash from the device tree, the card boots
> fine using the RAM disk.
> 
> 
> I am not too familiar with Linux boot scripts and I didn't figure out
> where I can disable this tentative of mounting the MTD partition. I
> want the boards to boot and mount the RAM disk, as the P1020 board
> does. The flash partition will be initialized and mounted at a later
> time, but not as root partition.

Compare the kernel command line and kernel config for the two boards;
there's probably a relevant difference there (especially with the
"root=" parameter).

-Scott
