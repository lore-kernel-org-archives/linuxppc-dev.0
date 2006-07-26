Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 49161679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jul 2006 00:48:29 +1000 (EST)
Date: Wed, 26 Jul 2006 09:06:25 -0500
From: Milton Miller <miltonm@bga.com>
To: cthomas@Soneticom.com, linuxppc-embedded@ozlabs.org,
Subject: Re: Booting Linux Kernel without bootloader
Message-Id: <11153922785140e0f761.861021530.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue Jul 25 2006 05:30:39 PM CDT,  Clint Thomas  wrote:

> Basically, the system I want linux running on does not require the
> initialization of hardware that U-boot provides, or at least it does not
> need it to boot the linux kernel. I want to load an uncompressed linux
> kernel into memory and start the execution of the kernel, without using
> any kind of bootloader. Is this possible? Or does linux need some kind
> of firmware or other software to tell it to start executing? Thanks for
> any info you might have.
 
To run a powerpc (not ppc, which will be removed) kernel, in addition to the uncompressed kernel you will need to supply a device tree structure, point r3 to it, zero r5, and set r4 to the load address (zero as you have described).  See Documentation/powerpc/booting-without-of.txt for details.  Then arrange for you processor to start executing at address 0.  Note that /vmlinux has an elf header, you can use objcopy to remove it or adjust r4 and your start point; the kernel will copy itself to 0, clear bss and set up the stack. The device tree structure must be placed above the bss space in memory, not just the initialized data.  

milton
