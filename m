Date: Mon, 27 Dec 1999 09:42:39 +0100
From: Raphael Bossek <raphael.bossek@solutions4linux.de>
To: dony <dony.he@huawei.com.cn>
Cc: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
Message-ID: <19991227094239.B1025@raphael.bossek.home>
References: <386C150F.22B1A3D0@huawei.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <386C150F.22B1A3D0@huawei.com.cn>; from dony.he@huawei.com.cn on Fri, Dec 31, 1999 at 10:29:35AM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi dony,

> Do you know why? How can I programme to make it run?
i thing you have download it into wrong address! i would recompile
the kernel with debugging information and single step your code...
the decompressor and some of the first lines of code of the kernel
are initialisation and possible to debug... check where the
decompressor jump to and compare where the decompressor reads from!
use binutils to get mixed code on your host and compare the lines
with your debuger
let take me a look... the 8xxrom load the kernel elf image to phy
address 0x00200000

> Since the kernel is a compressed image (zvmlinux), need I make
> some codes to decompress it and then run it? if so, how to do it?
the decompressor is part of the image but it expects the real image
at a special address which you have to consider before downloading
into ram. this will be done by the 8xxrom from Magnus Damm and some
patches for the 823 avilable at http://www.s4l.de/powerpc.html of
course :-) the 8xxrom resists in flash and load the linux kernel from
a pcmcia ide hd or from flash using a rom-fs but this is an another
solution that can be used in a ready product with little modifications
in image selection...

-- 
Raphael Bossek <raphael.bossek@solutions4linux.de> [ICQ #40047651]
PGP fingerprint: DF 6F 2C 76 46 1E B4 1C  5B A5 2E 1B FC E0 D3 F6
PGP public key: http://www.solutions4linux.de/private/pgpkey.asc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
