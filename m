Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssSkg0y3BzDrWP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 03:04:43 +1100 (AEDT)
Date: Sun, 9 Oct 2016 08:21:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: ppc64 qemu test failure since commit f9aa67142 ("powerpc/64s:
 Consolidate Alignment 0x600 interrupt")
Message-ID: <20161009152121.GA13188@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas,

some of my qemu tests for ppc64 started failing on mainline (and -next).
You can find a test log at
http://kerneltests.org/builders/qemu-ppc64-master/builds/580/steps/qemubuildcommand/logs/stdio

The scripts to run the test are available at
https://github.com/groeck/linux-build-test/tree/master/rootfs/ppc64

Bisect points to commit f9aa67142ef26 ("powerpc/64s: Consolidate Alignment 0x600
interrupt"). Bisect log is attached.

Since I don't have the means to run the code on a real system, I have no idea
if the problem is caused by qemu or by the code. It is interesting, though, that
only the 'mac99' tests are affected.

Please let me know if there is anything I can do to help tracking down the
problem.

Thanks,
Guenter

---
# bad: [b66484cd74706fa8681d051840fe4b18a3da40ff] Merge branch 'akpm' (patches from Andrew)
# good: [87840a2b7e048018d18d60bdac5c09224de85370] Merge branch 'i2c/for-4.9' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect start 'HEAD' '87840a2'
# bad: [6afd563d4bbc1924b7de9e053324c007e0d36476] Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad 6afd563d4bbc1924b7de9e053324c007e0d36476
# bad: [07021b43597f506cc525d139ed1a94e79cf184f2] Merge tag 'powerpc-4.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect bad 07021b43597f506cc525d139ed1a94e79cf184f2
# bad: [e909fb83d39292679118761426d7784715ad79ad] powerpc: Never giveup a reclaimed thread when enabling kernel {fp, altivec, vsx}
git bisect bad e909fb83d39292679118761426d7784715ad79ad
# good: [313483dd72289ff0b7dff4207032d94dbce39cf6] powerpc/powernv: Unfreeze PE on allocation
git bisect good 313483dd72289ff0b7dff4207032d94dbce39cf6
# bad: [792cbddd628282027f99f5499f2899613e07f8f9] powerpc/64s: Consolidate VSX Unavailable 0xf40 interrupt
git bisect bad 792cbddd628282027f99f5499f2899613e07f8f9
# bad: [11e87346b9b885f3b088efb6afda604e91233026] powerpc/64s: Consolidate Program 0x700 interrupt
git bisect bad 11e87346b9b885f3b088efb6afda604e91233026
# good: [57f266497d81e16141bd2c9009e91dad34ea5f70] powerpc: Use gas sections for arranging exception vectors
git bisect good 57f266497d81e16141bd2c9009e91dad34ea5f70
# good: [2b9af6e40e477fbfe39777dda9a609ae359d3dd8] powerpc/64s: Consolidate Data Segment 0x380 interrupt
git bisect good 2b9af6e40e477fbfe39777dda9a609ae359d3dd8
# good: [8d04631ad7cbbe27d058ae79e3d41009a8e006d1] powerpc/64s: Consolidate Instruction Segment 0x480 interrupt
git bisect good 8d04631ad7cbbe27d058ae79e3d41009a8e006d1
# bad: [f9aa67142ef2697990d1f36aa3d59320820bcfae] powerpc/64s: Consolidate Alignment 0x600 interrupt
git bisect bad f9aa67142ef2697990d1f36aa3d59320820bcfae
# good: [c138e58890dd5128a5706ed30c5deab6736320d6] powerpc/64s: Consolidate External 0x500 interrupt
git bisect good c138e58890dd5128a5706ed30c5deab6736320d6
# first bad commit: [f9aa67142ef2697990d1f36aa3d59320820bcfae] powerpc/64s: Consolidate Alignment 0x600 interrupt
