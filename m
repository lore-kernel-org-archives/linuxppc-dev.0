Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1FF31B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 17:50:04 +1000 (EST)
Message-ID: <4C91CC78.2020802@windriver.com>
Date: Thu, 16 Sep 2010 15:51:20 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Generating elf kernel ?
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>	<201009151651.06816.dargaud@lpsc.in2p3.fr>	<4C9188DC.2040300@windriver.com>
	<201009160925.50082.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201009160925.50082.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guillaume Dargaud wrote:
>>>> Please use simpleImage.<your target dts name>.elf.
>>> Great, that seems to be it...
>>> Except that nothing happens when I jump to 0x40000, no message from the
>> 0x40000? I recalled the entry point should be 0x400000 for
>> simepleImage.*.elf. So you have to change this on the file,
>> arch/powerpc/boot/wrapper.
> 
> Correct, I skipped a zero, the address is indeed 0x400000
> 
>> And also you should confirm if the upstream kernel support your board.
> 
> Our board is a custom derivative from a ML405.

Understood.

So I recommend you use the kernel tree from xilinx. You can refer to the
following website:

http://xilinx.wikidot.com/powerpc-linux

I hope you can skip many issues to accelerate your progress based on the xilinx
kernel.

> My previous project uses ARCH=PPC and has been working fine for 2 years.
> I'm currently trying to go to ARCH=PowerPC and understand dts files in order to 
> boot my first kernel.
> I assume I shouldn't have to change anything in my bootloader.
> After I jump to the kernel address, I don't even get the usual:
> loaded at:     00400000 004F559C
> board data at: 004F3520 004F359C
> relocated to:  0040505C 004050D8
> zimage at:     00405E48 004F211C
> avail ram:     004F6000 08000000
> Linux/PPC load: console=ttyUL0,115200 rw root=/dev/nfs ip=bootp
> Uncompressing Linux...done.
> Now booting the kernel
> 
> Something wrong with my serial console ?

You have to check if you go the correct PC address. Note please check the real
pc address according to the previous comments.

If yes you can check where your kernel stop. Certainly if you have some tools,
such as JTAG debug tools it's convenient to track this. But if no it will be
difficult to go no next.

But you still have ways to do, such as display LED, early printk, and dump
__log_buf.

> 
>> Additionally let's assume your bootloader create the map between the
>> virtual address and the physical address as 1:1. If so you want to execute
>> from 0x40000. But the actual PC address should be the loader address +
>> offset. You can get this by readelf. Here if your loader address is zero,
>> the offset will be pc address, not 0x40000. You can dump your memory to
>> check this.
> 
> The bootloader has no concept of virtual address, right ?

This should be depend on the given PPC core. For example, we cannot disable MMU
on e500. Bur for ML405 we can disable MMU to run real mode on 405.

Cheers
Tiejun

> 
