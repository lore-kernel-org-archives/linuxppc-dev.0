Return-Path: <schmitzmic@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cxlX0CvczF0dl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 17:09:08 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 6-v6so3240917plb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 00:09:08 -0700 (PDT)
Subject: Re: [PATCH v4 00/11] macintosh: Resolve various PMU driver problems
To: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <155756b2-d3cf-e47d-2ea1-58115a4cadc5@gmail.com>
Date: Sat, 28 Jul 2018 19:08:53 +1200
MIME-Version: 1.0
In-Reply-To: <cover.1530519301.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No regressions on my PowerBook G4, so for this series:

Tested-by: Michael Schmitz <schmitzmic@gmail.com>

Am 02.07.2018 um 20:21 schrieb Finn Thain:
> This series of patches has the following aims.
>
> 1) Eliminate duplicated code. Linux presently has two drivers for
>    the 68HC05-based PMU devices found in Macs: via-pmu and via-pmu68k.
>    There's no value in having separate PMU drivers for each architecture.
>
> 2) Avoid further work on via-pmu68k that's not needed for via-pmu.
>
> 3) Fix some bugs in the via-pmu driver.
>
> 4) Enable the /dev/pmu and /proc/pmu/* userspace APIs on m68k Macs
>    by adopting via-pmu.
>
> 5) Improve stability on early 100-series PowerBooks by loading no PMU
>    driver at all. Neither via-pmu nor via-pmu68k supports the early
>    M50753-based PMU device found in these models.
>
> 6) Assist the out-of-tree NuBus PowerMac port to support PMU designs
>    shared with the m68k Mac port (e.g. PowerBooks 190 and 5300).
>
> This patch series has been regression tested on various PowerBooks
> (190, 520, 3400, Pismo G3) and PowerMacs (Beige G3, G5). These patches
> did not affect userland utilities. (Note that there is a userland-
> visible change to the contents of /proc/pmu/interrupts.)
>
> Changed since v1:
> 1) Added blank lines after 'break' statements in patch 10.
> 2) Improved patch description for patch 3.
> 3) Added reviewed-by tags.
> 4) Split patch 8 to make code review easier.
>
> Changed since v2:
> 1) Added reviewed-by tag.
> 2) Retained PMU_68K_V1 and PMU_68K_V2 symbols.
>
> Changed since v3:
> 1) Rebased on v4.18-rc2.
> 2) Omitted patch 10/12, since these RTC changes now conflict with mainline.
>    It will be reworked once the mainline m68k/powerpc RTC code stabilizes.
>
>
> Finn Thain (11):
>   macintosh/via-pmu: Fix section mismatch warning
>   macintosh/via-pmu: Add missing mmio accessors
>   macintosh/via-pmu: Don't clear shift register interrupt flag twice
>   macintosh/via-pmu: Enhance state machine with new 'uninitialized'
>     state
>   macintosh/via-pmu: Replace via pointer with via1 and via2 pointers
>   macintosh/via-pmu: Add support for m68k PowerBooks
>   macintosh/via-pmu: Explicitly specify CONFIG_PPC_PMAC dependencies
>   macintosh/via-pmu68k: Don't load driver on unsupported hardware
>   macintosh/via-pmu: Replace via-pmu68k driver with via-pmu driver
>   macintosh/via-pmu: Clean up interrupt statistics
>   macintosh/via-pmu: Disambiguate interrupt statistics
>
>  arch/m68k/configs/mac_defconfig   |   2 +-
>  arch/m68k/configs/multi_defconfig |   2 +-
>  arch/m68k/mac/config.c            |   2 +-
>  arch/m68k/mac/misc.c              |  54 +--
>  drivers/macintosh/Kconfig         |  19 +-
>  drivers/macintosh/Makefile        |   1 -
>  drivers/macintosh/adb.c           |   2 +-
>  drivers/macintosh/via-pmu.c       | 346 ++++++++++------
>  drivers/macintosh/via-pmu68k.c    | 850 --------------------------------------
>  include/uapi/linux/pmu.h          |   4 +-
>  10 files changed, 235 insertions(+), 1047 deletions(-)
>  delete mode 100644 drivers/macintosh/via-pmu68k.c
>
