Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04455DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 13:18:11 +1100 (EST)
Date: Wed, 21 Mar 2007 20:18:04 -0600 (CST)
Message-Id: <200703220218.l2M2I4b9031923@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: <miltonm@realtime.net>
Subject: Re: O= compilation failure in 2.6.21-rc
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Mar 22 03:17:28 EST 2007, Christoph Hellwig wrote:
> looks like 2.6.21-rc4 doesn't compile anymore when using objdir !=
> srcdir.  The message is:
> 
> WRAP    arch/powerpc/boot/zImage.pseries
> powerpc64-linux-ld: cannot open linker script file
> arch/powerpc/boot/zImage.lds: No such file or directory
> arch/powerpc/boot/zImage.pseries: No such file or directory
> 
> works fine for either building in the source dir or just doing a make
> vmlinux instead of make so that the zImage wrapper isn't built.


Works for me.

unpack 2.6.24-rc4
mkdir obj_4k
make pseries_defconfig O=obj_4k/
make zImage O=obj_4k/

..
  BOOTCC  arch/powerpc/boot/of.o
  BOOTCC  arch/powerpc/boot/empty.o
  HOSTCC  arch/powerpc/boot/addnote
  HOSTCC  arch/powerpc/boot/hack-coff
  HOSTCC  arch/powerpc/boot/mktree
  WRAP    arch/powerpc/boot/zImage.pseries

[no complaints]

In additon, here is the dependency chain in arch/powerpc/boot/Makefile
from the wrapper invocation to the generation of zImage.lds:


$(obj)/zImage:          $(addprefix $(obj)/, $(image-y))

$(obj)/zImage.pseries:  vmlinux $(wrapperbits)
        $(call cmd,wrap,pseries)

wrapperbits     := $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree)

extra-y         := $(obj)/crt0.o $(obj)/wrapper.a $(obj-plat) $(obj)/empty.o \
                   $(obj)/zImage.lds $(obj)/zImage.coff.lds

$(obj)/zImage.lds $(obj)/zImage.coff.lds: $(obj)/%: $(srctree)/$(src)/%.S
        @cp $< $@



So either your tree is broken, cp is broken, or you need to provide more
information.

milton
