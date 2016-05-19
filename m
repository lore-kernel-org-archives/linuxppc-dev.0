Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9QFV5xsPzDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 19:07:41 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: kernel-build-reports@lists.linaro.org
Cc: Olof's autobuilder <build@lixom.net>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ross Lagerwall <ross.lagerwall@citrix.com>, Dave Chinner <david@fromorbit.com>,
 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
 Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: next build: 37 warnings 2 failures (next/next-20160519)
Date: Thu, 19 May 2016 11:07:09 +0200
Message-ID: <3211556.r7N0gQRgk6@wuerfel>
In-Reply-To: <573d6f0c.8664620a.24f8e.ffff931b@mx.google.com>
References: <573d6f0c.8664620a.24f8e.ffff931b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 May 2016 00:45:16 Olof's autobuilder wrote:
> Errors:
> 
>         arm64.allmodconfig:
> samples/seccomp/bpf-fancy.c:13:27: fatal error: linux/seccomp.h: No such file or directory
> samples/seccomp/dropper.c:20:27: fatal error: linux/seccomp.h: No such file or directory
> samples/seccomp/bpf-helper.h:20:50: fatal error: linux/seccomp.h: No such file or directory
> samples/seccomp/bpf-direct.c:21:27: fatal error: linux/seccomp.h: No such file or directory

This one is interesting: the same header dependency seems to be present for samples/bpf,
but only samples/seccomp fails. Can you check if both are attempted to be built?

samples/bpf/README.rst says about this:

|Kernel headers
|--------------
|
|There are usually dependencies to header files of the current kernel.
|To avoid installing devel kernel headers system wide, as a normal
|user, simply call::
|
| make headers_install
|
|This will creates a local "usr/include" directory in the git/build top
|level directory, that the make system automatically pickup first.

which I assume would fix the problem, but it would be better if Kbuild was smart enough
to do this implicitly when building these samples.

>         powerpc.pasemi_defconfig:
> arch/powerpc/kernel/ptrace.c:380:24: error: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Werror=array-bounds]
> arch/powerpc/kernel/ptrace.c:408:24: error: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Werror=array-bounds]

I don't see a good way to avoid the warning other than dropping the

       BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
                    offsetof(struct thread_fp_state, fpr[32][0]));

statements in the powerpc ptrace implementation. It doesn't seem too
important to check for though.


> Warnings:

>       2 drivers/net/wireless/intel/iwlegacy/3945.c:1022:5: warning: suggest explicit braces to avoid ambiguous 'else' [-Wparentheses]

I had not seen this before, sent a patch now.

>       3 drivers/pinctrl/stm32/pinctrl-stm32.c:797:17: warning: too many arguments for format [-Wformat-extra-args]

sent a fix yesterday, got an ack but it wasn't applied yet. I'm sure Linus Walleij
will take care of it soon.

>       6 mm/page_alloc.c:3651:6: warning: 'compact_result' may be used uninitialized in this function [-Wmaybe-uninitialized]

I'm surprised this one is still there, I sent a patch but Michal Hocko came up with
a better fix on May 12, which was not applied yet.

Michael, can you resend this one to Andrew? I suspect he missed it as it was
sent as a reply to mine.

>       2 drivers/xen/balloon.c:154:13: warning: 'release_memory_resource' declared 'static' but never defined [-Wunused-function]

I sent a patch on May 11, subject "xen: remove incorrect forward declaration" and
Stefano Stabellini reviewed it. Ross Lagerwall did the same patch a day earlier,
but neither of them has made it into linux-next so far. According to Ross, this
one should be backported to v4.4.

>       3 fs/xfs/xfs_aops.c:97:16: warning: unused variable 'blockmask' [-Wunused-variable]

I sent a patch on April 16, but got no reply. Resending it now.

>       2 arch/arm/mach-lpc32xx/include/mach/irqs.h:115:0: warning: "NR_IRQS" redefined

I missed this one, as I have some other patches for lp32xx in my randconfig
fixup tree that hides it.

I've created a fix now and applied it to the arm-soc fixes branch.

>       1 drivers/soc/mediatek/mtk-pmic-wrap.c:1062:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>       1 drivers/soc/mediatek/mtk-pmic-wrap.c:1074:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>       1 drivers/soc/mediatek/mtk-pmic-wrap.c:1086:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]

I sent out a patch on May 12 for this, got no reply. I've applied my own patch
now on the arm-soc fixes branch.

>       1 drivers/phy/phy-exynos-mipi-video.c:238:13: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

I sent a patch on May 11, it was reviewed by Krzysztof Kozlowski, but not yet
applied.

>       1 include/soc/nps/common.h:148:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>       1 include/soc/nps/common.h:162:9: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

I sent a patch on May 12, but it hasn't appeared in linux-next yet.

>       1 drivers/infiniband/core/cma.c:1253:12: warning: 'src_addr_storage.sin_addr.s_addr' may be used uninitialized in this function [-Wmaybe-uninitialized]

This seems to only happen on powerpc. What compiler version are you using there? If it's
an older compiler, we might not necessarily care about the warnings but you may want to
upgrade.

I've confirmed that this is a false positive, but I see how older gcc versions would
get confused about this.

>       1 include/sound/control.h:219:9: warning: 'master_vol' may be used uninitialized in this function [-Wmaybe-uninitialized]
> sound/ppc/awacs.c:886:23: note: 'master_vol' was declared here
>  struct snd_kcontrol *master_vol, *speaker_vol;

This seemed to be a valid bug at first sight, but it probably falls in the same
category as the infiniband one, it's really a false positive. This is the Power
Macintosh sound driver.

>       7 include/linux/kernel.h:748:17: warning: comparison of distinct pointer types lacks a cast

This is also powerpc specific it seems, the full message is

/home/build/work/batch/mm/cma.c: In function 'cma_declare_contiguous':
/home/build/work/batch/include/linux/kernel.h:748:17: warning: comparison of distinct pointer types lacks a cast
  (void) (&_max1 == &_max2);  \
                 ^
/home/build/work/batch/include/linux/kernel.h:747:9: note: in definition of macro 'max'
  typeof(y) _max2 = (y);   \
         ^
/home/build/work/batch/mm/cma.c:270:29: note: in expansion of macro 'max'
   (phys_addr_t)PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order));
                             ^~~

Probably straightforward to fix, but I haven't looked closely.

>       1 drivers/staging/iio/adc/ad7606_spi.c:24:18: warning: 'data' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       1 fs/gfs2/dir.c:1021:8: warning: 'leaf_no' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       1 fs/gfs2/dir.c:802:9: warning: 'leaf_no' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       1 fs/reiserfs/ibalance.c:1156:2: warning: 'new_insert_key' may be used uninitialized in this function [-Wmaybe-uninitialized]

These are all warnings that we only get for arm64, and I think they are all false
positives on older gcc versions.

	Arnd
