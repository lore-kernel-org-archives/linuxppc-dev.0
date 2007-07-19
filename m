Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.226])
	by ozlabs.org (Postfix) with ESMTP id 0911BDDF6C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 05:49:27 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so581043nzf
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 12:49:26 -0700 (PDT)
Message-ID: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
Date: Thu, 19 Jul 2007 13:49:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Geoff Levand" <geoffrey.levand@am.sony.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, "Arnd Bergmann" <arnd@arndb.de>,
	"Scott Wood" <scottwood@freescale.com>
Subject: BUG: compile failure on ps3-head.S
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit id bafdb645779c63300763acb383f7b9dd2d427228 (on Linus' tree)
causes breakage on my mpc8349 build (see below).  I've worked around
it by removing ps3* from arch/powerpc/boot/Makefile, but I have not
dug into what the 'proper' solution should be.

Cheers,
g.

Toolchain: gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)
Build command: make mpc834x_itxgp_defconfig; make zImage

make ARCH=ppc64 -f scripts/Makefile.build obj=arch/powerpc/boot
arch/powerpc/boot/zImage
  ppc_6xx-gcc -m32 -Wp,-MD,arch/powerpc/boot/.ps3-head.o.d
-D__ASSEMBLY__ -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -Os -msoft-float -pipe -fomit-frame-pointer
-fno-builtin -fPIC -nostdinc -isystem
/home/opt/eldk-4.0/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include
-traditional -nostdinc -c -o arch/powerpc/boot/ps3-head.o
arch/powerpc/boot/ps3-head.S
arch/powerpc/boot/ps3-head.S: Assembler messages:
arch/powerpc/boot/ps3-head.S:40: Error: Unrecognized opcode: `clrldi'
arch/powerpc/boot/ps3-head.S:41: Error: Unrecognized opcode: `mtmsrd'
make[1]: *** [arch/powerpc/boot/ps3-head.o] Error 1
make: *** [zImage] Error 2


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
