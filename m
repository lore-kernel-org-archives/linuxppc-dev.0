Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7dDZ3bd1zDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 12:15:58 +1000 (AEST)
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Build and qemu test results for v4.8-rc1
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@arm.linux.org.uk>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Vineet Gupta <vgupta@synopsys.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thorsten Leemhuis <fedora@leemhuis.info>
Message-ID: <a8f84377-a3f6-109e-99c3-a5f2fc798178@roeck-us.net>
Date: Mon, 8 Aug 2016 19:15:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build results:
	total: 148 pass: 142 fail: 6
Failed builds:
	h8300:allnoconfig
	h8300:edosk2674_defconfig
	h8300:h8300h-sim_defconfig
	h8300:h8s-sim_defconfig
	unicore32:defconfig
	unicore32:allnoconfig

Qemu test results:
	total: 107 pass: 104 fail: 3
Failed tests:
	arm:kzm:imx_v6_v7_defconfig
	powerpc:nosmp:ppc64_e5500_defconfig
	powerpc:smp:ppc64_e5500_defconfig

===
h8300:

arch/h8300/include/asm/io.h:9:15: error: unknown type name ‘u8’
arch/h8300/include/asm/io.h:9:58: error: expected ‘;’, ‘,’ or ‘)’ before ‘*’ token
[and many more similar errors]

Fixed with [1]

---
unicore32:

mm/gup.c: In function ‘check_vma_flags’:
mm/gup.c:458: error: too many arguments to function ‘arch_vma_access_permitted’
mm/gup.c: In function ‘vma_permits_fault’:
gup.c:642: error: too many arguments to function ‘arch_vma_access_permitted’

Fixed with [2]

---
qemu arm:kzm:imx_v6_v7_defconfig:

Failed to create /dev/root: -14
...
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

See [3]

---
qemu powerpc:nosmp:qemu_ppc64_e5500_defconfig:
qemu powerpc:smp:qemu_ppc64_e5500_defconfig:

./arch/powerpc/include/asm/cputhreads.h: In function 'get_tensr':
./arch/powerpc/include/asm/cputhreads.h:101:2: error: implicit declaration of function 'cpu_has_feature'

Fixed with [4]


---
[1] https://patchwork.kernel.org/patch/9166177/
[2] https://patchwork.kernel.org/patch/8631791/
[3] https://lkml.org/lkml/2016/8/2/2085
[4] https://patchwork.kernel.org/patch/9266131/
