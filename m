Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id D2CD2DEF52
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 04:00:58 +1000 (EST)
In-Reply-To: <20080819021710.GK18960@genesis.frugalware.org>
References: <20080819021710.GK18960@genesis.frugalware.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0ef867ddd3feae1693e0ac6b8a66be3e@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: qemu platform patches
Date: Tue, 19 Aug 2008 12:51:44 -0500
To: Miklos Vajna <vmiklos@frugalware.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	
On Aug 18, 2008, at 9:17 PM, Miklos Vajna wrote:

> Hi!
>
> I recently started to search for a solution to boot a Linux-2.6-based
> kernel in qemu-system-ppc.
>
> Google found two of your interesting patches:
> http://patchwork.ozlabs.org/linuxppc/patchcontent?id=13689
> http://patchwork.ozlabs.org/linuxppc/patchcontent?id=13690
...
> Sadly the build fails at your qemu.c, with:
>
>   BOOTCC  arch/powerpc/boot/qemu.o
> arch/powerpc/boot/qemu.c: In function 'tree_fixups':
> arch/powerpc/boot/qemu.c:203: warning: implicit declaration of  
> function 'dt_find_initrd'
> arch/powerpc/boot/qemu.c: In function 'platform_init':
> arch/powerpc/boot/qemu.c:230: error: 'struct platform_ops' has no  
> member named 'find_vmlinuz'
> make[1]: *** [arch/powerpc/boot/qemu.o] Error 1
> make: *** [zImage] Error 2
>
> Two questions:
>
> 1) Do you remember what was the exact commit you worked with, where
> qemu.c compiled fine? (In case you have newer patches somewhere, I'm
> interested as well :) )

 From those messages, there were other patches posted about the same  
time that did some radical splits to the zImage infrastructure code,  
allowing it to become a helper instead of just a contained image.

And I do have later patches that were working (better).  I have even  
booted a linux-next kernel just before 2.6.27 opened, after doing some  
fixups.  However, I suffer from wanting to perferct the function of the  
patches and never get the base part out :-).  For instance, when  
working with 2.6.27, I got ISA memory working and some video output.   
Also, the ide-generic driver now has to be enabled on the command line  
to give the same function we previously had.  That, combined with  
kernel for ppc-qemu is my hobby and my work keeps interrupting me.

The current state is: Rob Landley's Firmware Linux has a ppc_rom.bin  
(and source) written by me that probes qemu nvram for the size of  
memory, location of a command line (-append) and initrd (-initrd),  
patching a device tree linked into it, then parses the kernel (or other  
elf file) loaded via -elf a kernel and jumps into it whereever it was  
loaded.  The kernel has a corresponding platform patch that only  
recognises qemu (based on the kernel patch you found).  The version Rob  
has works on 2.6.25.9 with serial, ide, and isa ne2000.  Since then I  
got isa memory to enable video (with hacks and you only see 1/4 of the  
screen).

http://landley.net/hg/firmware/raw-file/6f1e69d7e7f5/sources/toys/make- 
ppc_rom.tar.bz2
http://landley.net/hg/firmware/raw-file/59e22ea53e6a/sources/patches/ 
linux-ppcqemu.patch
http://landley.net/hg/firmware/raw-file/0d8e80202e94/sources/patches/ 
linux-2.6.23-ppcne2khack.patch

> 2) I'm not exactly sure about the build process in the case of qemu,
> using your patches.
>
> Am I right about I just have to compile the kernel, I'll be given a
> ppc_rom.bin and the usual vmlinux file, then I can boot these with  
> qemu?

The version that you have built a rom out of the code in  
arch/powerpc/boot after patching.  The new version builds the rom in a  
shell script.   Either way, it activated by calling it ppc_rom.bin and  
pointing QEMU's library drectory to it with the -L flag.  This code  
works for qemu -kernel when the kernel is patched to recogonise the  
qemu platform specified in the device-tree.

Going forward, it probably needs to become a dtbImage or a combination  
rom and optional image.

> Hopefully the rest is clear, currently I have 2.4.36.1 in qemu and it
> would be really time to upgrade to 2.6 :)

People were successfully able to get arch/ppc kernel to boot as last  
ase 2.6.26, at least until they got to userspace.  That doesn't provide  
a way forward, as ppc is now removed, but it may provide a temporary  
option.

I can't promise a timeframe, but I do want to get the patches updated  
and out.

milton
