Return-Path: <kishon@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9R1R4KVszDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 19:42:19 +1000 (AEST)
Subject: Re: next build: 37 warnings 2 failures (next/next-20160519)
To: Arnd Bergmann <arnd@arndb.de>, <kernel-build-reports@lists.linaro.org>
References: <573d6f0c.8664620a.24f8e.ffff931b@mx.google.com>
 <3211556.r7N0gQRgk6@wuerfel>
CC: "Olof's autobuilder" <build@lixom.net>, <olof@lixom.net>,
 <linuxppc-dev@lists.ozlabs.org>, Michal Hocko <mhocko@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Linus Walleij
 <linus.ml.walleij@gmail.com>, <linux-kernel@vger.kernel.org>, Stefano
 Stabellini <sstabellini@kernel.org>, Ross Lagerwall
 <ross.lagerwall@citrix.com>, Dave Chinner <david@fromorbit.com>, Krzysztof
 Kozlowski <k.kozlowski.k@gmail.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <573D886E.1050205@ti.com>
Date: Thu, 19 May 2016 15:03:34 +0530
MIME-Version: 1.0
In-Reply-To: <3211556.r7N0gQRgk6@wuerfel>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Thursday 19 May 2016 02:37 PM, Arnd Bergmann wrote:
> On Thursday 19 May 2016 00:45:16 Olof's autobuilder wrote:
>> Errors:
>>
>>         arm64.allmodconfig:
>> samples/seccomp/bpf-fancy.c:13:27: fatal error: linux/seccomp.h: No such file or directory
>> samples/seccomp/dropper.c:20:27: fatal error: linux/seccomp.h: No such file or directory
>> samples/seccomp/bpf-helper.h:20:50: fatal error: linux/seccomp.h: No such file or directory
>> samples/seccomp/bpf-direct.c:21:27: fatal error: linux/seccomp.h: No such file or directory
> 
> This one is interesting: the same header dependency seems to be present for samples/bpf,
> but only samples/seccomp fails. Can you check if both are attempted to be built?
> 
> samples/bpf/README.rst says about this:
> 
> |Kernel headers
> |--------------
> |
> |There are usually dependencies to header files of the current kernel.
> |To avoid installing devel kernel headers system wide, as a normal
> |user, simply call::
> |
> | make headers_install
> |
> |This will creates a local "usr/include" directory in the git/build top
> |level directory, that the make system automatically pickup first.
> 
> which I assume would fix the problem, but it would be better if Kbuild was smart enough
> to do this implicitly when building these samples.
> 
>>         powerpc.pasemi_defconfig:
>> arch/powerpc/kernel/ptrace.c:380:24: error: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Werror=array-bounds]
>> arch/powerpc/kernel/ptrace.c:408:24: error: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Werror=array-bounds]
> 
> I don't see a good way to avoid the warning other than dropping the
> 
>        BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
>                     offsetof(struct thread_fp_state, fpr[32][0]));
> 
> statements in the powerpc ptrace implementation. It doesn't seem too
> important to check for though.
> 
> 
>> Warnings:
> 
>>       2 drivers/net/wireless/intel/iwlegacy/3945.c:1022:5: warning: suggest explicit braces to avoid ambiguous 'else' [-Wparentheses]
> 
> I had not seen this before, sent a patch now.
> 
>>       3 drivers/pinctrl/stm32/pinctrl-stm32.c:797:17: warning: too many arguments for format [-Wformat-extra-args]
> 
> sent a fix yesterday, got an ack but it wasn't applied yet. I'm sure Linus Walleij
> will take care of it soon.
> 
>>       6 mm/page_alloc.c:3651:6: warning: 'compact_result' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> I'm surprised this one is still there, I sent a patch but Michal Hocko came up with
> a better fix on May 12, which was not applied yet.
> 
> Michael, can you resend this one to Andrew? I suspect he missed it as it was
> sent as a reply to mine.
> 
>>       2 drivers/xen/balloon.c:154:13: warning: 'release_memory_resource' declared 'static' but never defined [-Wunused-function]
> 
> I sent a patch on May 11, subject "xen: remove incorrect forward declaration" and
> Stefano Stabellini reviewed it. Ross Lagerwall did the same patch a day earlier,
> but neither of them has made it into linux-next so far. According to Ross, this
> one should be backported to v4.4.
> 
>>       3 fs/xfs/xfs_aops.c:97:16: warning: unused variable 'blockmask' [-Wunused-variable]
> 
> I sent a patch on April 16, but got no reply. Resending it now.
> 
>>       2 arch/arm/mach-lpc32xx/include/mach/irqs.h:115:0: warning: "NR_IRQS" redefined
> 
> I missed this one, as I have some other patches for lp32xx in my randconfig
> fixup tree that hides it.
> 
> I've created a fix now and applied it to the arm-soc fixes branch.
> 
>>       1 drivers/soc/mediatek/mtk-pmic-wrap.c:1062:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>       1 drivers/soc/mediatek/mtk-pmic-wrap.c:1074:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>>       1 drivers/soc/mediatek/mtk-pmic-wrap.c:1086:16: warning: large integer implicitly truncated to unsigned type [-Woverflow]
> 
> I sent out a patch on May 12 for this, got no reply. I've applied my own patch
> now on the arm-soc fixes branch.
> 
>>       1 drivers/phy/phy-exynos-mipi-video.c:238:13: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> I sent a patch on May 11, it was reviewed by Krzysztof Kozlowski, but not yet
> applied.

Is it okay if I send this during the -rc cycle?

Thanks
Kishon
