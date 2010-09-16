Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1409B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 17:23:40 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	o8G7NZcw019689
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2010 09:23:35 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Generating elf kernel ?
Date: Thu, 16 Sep 2010 09:25:49 +0200
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<201009151651.06816.dargaud@lpsc.in2p3.fr>
	<4C9188DC.2040300@windriver.com>
In-Reply-To: <4C9188DC.2040300@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201009160925.50082.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> Please use simpleImage.<your target dts name>.elf.
> > 
> > Great, that seems to be it...
> > Except that nothing happens when I jump to 0x40000, no message from the
> 
> 0x40000? I recalled the entry point should be 0x400000 for
> simepleImage.*.elf. So you have to change this on the file,
> arch/powerpc/boot/wrapper.

Correct, I skipped a zero, the address is indeed 0x400000

> And also you should confirm if the upstream kernel support your board.

Our board is a custom derivative from a ML405.
My previous project uses ARCH=PPC and has been working fine for 2 years.
I'm currently trying to go to ARCH=PowerPC and understand dts files in order to 
boot my first kernel.
I assume I shouldn't have to change anything in my bootloader.
After I jump to the kernel address, I don't even get the usual:
loaded at:     00400000 004F559C
board data at: 004F3520 004F359C
relocated to:  0040505C 004050D8
zimage at:     00405E48 004F211C
avail ram:     004F6000 08000000
Linux/PPC load: console=ttyUL0,115200 rw root=/dev/nfs ip=bootp
Uncompressing Linux...done.
Now booting the kernel

Something wrong with my serial console ?

> Additionally let's assume your bootloader create the map between the
> virtual address and the physical address as 1:1. If so you want to execute
> from 0x40000. But the actual PC address should be the loader address +
> offset. You can get this by readelf. Here if your loader address is zero,
> the offset will be pc address, not 0x40000. You can dump your memory to
> check this.

The bootloader has no concept of virtual address, right ?

-- 
Guillaume Dargaud
http://www.gdargaud.net/
