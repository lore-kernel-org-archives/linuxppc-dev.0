Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id ACEE1DDEE0
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 10:32:11 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Please pull powerpc.git merge branch
Date: Sat, 10 Mar 2007 00:31:53 +0100
References: <17903.35471.818872.293459@cargo.ozlabs.ibm.com>
	<17905.52447.829667.16759@cargo.ozlabs.ibm.com>
In-Reply-To: <17905.52447.829667.16759@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703100031.54128.arnd@arndb.de>
Cc: torvalds@linux-foundation.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 09 March 2007, Paul Mackerras wrote:
> > Please do:
> >=20
> > git pull \
> > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> >=20
> > There are 6 commits there. =A0Three of them fix compile warnings, one is
> > a bug fix, one works around a problem on rev 1.0 PPC970MP processors,
> > and one adds a missing newline in some help text.
>=20
> I have pulled 3 more commits from Kumar Gala and pushed them out, so
> when you do the pull you'll see the commits below in addition to the
> ones I listed previously.

I was late again and only today managed to go through my patch collection
to see what still needs to be merged in 2.6.21.

There are three fixes for run-time bugs, one is for making ps3 support not
break other platforms, and the final one is an updated defconfig for -rc3.

Please pull these from

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6.git cell-merge

=2D--

 arch/powerpc/configs/cell_defconfig        |  151 ++++++++++++++++++++++++=
=2D----
 arch/powerpc/mm/hash_utils_64.c            |    6 +
 arch/powerpc/mm/hugetlbpage.c              |    4
 arch/powerpc/platforms/cell/spu_base.c     |   81 +++++++++++++--
 arch/powerpc/platforms/cell/spufs/file.c   |   24 ++--
 arch/powerpc/platforms/cell/spufs/run.c    |    4
 arch/powerpc/platforms/cell/spufs/sched.c  |   20 ---
 arch/powerpc/platforms/cell/spufs/spufs.h  |    6 -
 arch/powerpc/platforms/cell/spufs/switch.c |   62 -----------
 arch/powerpc/platforms/ps3/mm.c            |    2
 arch/powerpc/platforms/ps3/system-bus.c    |    2
 drivers/ps3/ps3av.c                        |    9 +
 drivers/ps3/sys-manager.c                  |    6 +
 drivers/ps3/vuart.c                        |    2
 include/asm-powerpc/spu.h                  |    7 +
 include/asm-powerpc/spu_csa.h              |    4
 16 files changed, 258 insertions(+), 132 deletions(-)

=2D--

commit c886c2bf804c029499694adcc0decfdd32a0cd8b
Author: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Date:   Sat Mar 10 00:05:39 2007 +0100

    [POWERPC] update cell_defconfig
   =20
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit ef596c697a4d80048eccf50530153d7e3330c127
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Sat Mar 10 00:05:38 2007 +0100

    [POWERPC] ps3: always make sure were running on a PS3
   =20
    Add missing checks to PS3 specific drivers ps3av and sys-manager to ver=
ify that
    we are actually running on a PS3 (pointed out by Arnd).
   =20
    Correct existing checks in other subsystems/drivers to return -ENODEV i=
nstead
    of zero.
   =20
    Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 94b2a4393c500a620de90c3266d595926302e26b
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sat Mar 10 00:05:37 2007 +0100

    [POWERPC] Fix spu SLB invalidations
   =20
    The SPU code doesn't properly invalidate SPUs SLBs when necessary,
    for example when changing a segment size from the hugetlbfs code. In
    addition, it saves and restores the SLB content on context switches
    which makes it harder to properly handle those invalidations.
   =20
    This patch removes the saving & restoring for now, something more
    efficient might be found later on. It also adds a spu_flush_all_slbs(mm)
    that can be used by the core mm code to flush the SLBs of all SPEs that
    are running a given mm at the time of the flush.
   =20
    In order to do that, it adds a spinlock to the list of all SPEs and move
    some bits & pieces from spufs to spu_base.c
   =20
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 50b520d4efbce45281f58112789470ec7965fd33
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Mar 10 00:05:36 2007 +0100

    [POWERPC] avoid SPU_ACTIVATE_NOWAKE optimization
   =20
    This optimization was added recently but is still buggy,
    so back it out for now.
   =20
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit aa0ed2bdb663608d5e409faecff3e1e81a3d413a
Author: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Date:   Sat Mar 10 00:05:35 2007 +0100

    [POWERPC] spufs: fix possible memory corruption is spufs_mem_write
   =20
    Due to a buggy unsigned comparison, it was possible to write
    beyond the end of the local store file in spufs under some
    circumstances.
   =20
    This rewrites the buggy function to look more like
    simple_copy_from_buffer.
   =20
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
