Return-Path: <wangkefeng.wang@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [58.251.152.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7GvQ1b4pzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 22:29:53 +1000 (AEST)
Subject: Re: Problem booting Kernel 4.8-rc1 on Sam460ex ( Canyonlands)
To: Julian Margetson <runaway@candw.ms>, <linuxppc-dev@lists.ozlabs.org>
References: <ce142972-52a8-452f-8911-70af927ae425@candw.ms>
CC: <mpe@ellerman.id.au>, <imunsie@au1.ibm.com>, <benh@kernel.crashing.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <a9fe88f0-14ba-7ca6-66b4-69b84fa8a823@huawei.com>
Date: Mon, 8 Aug 2016 20:22:35 +0800
MIME-Version: 1.0
In-Reply-To: <ce142972-52a8-452f-8911-70af927ae425@candw.ms>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016/8/8 19:52, Julian Margetson wrote:
> Problem booting Kernel 4.8-rc1 on Sam460ex ( Canyonlands) machine .
> 
> This is what I get with the bisect.

Hi Julian

I have no Sam460ex machine, could you show the good and bad kernel bootlog?

Thanks,
Kefeng

> 
> Regards
> 
> Julian
> 
> 
> 44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7 is the first bad commit
> commit 44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7
> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
> Date:   Wed Jun 1 14:52:54 2016 +0800
> 
>     of/platform: Add common method to populate default bus
> 
>     The arch code calls of_platform_populate() with default match table
>     when it wants to populate default bus.
> 
>     This patch introduce a new of_platform_default_populate_init() and make it
>     arch_initcall_sync(it should be later than some iommu configration, eg,
>     of_iommu_init() and swiotlb_late_init in arm64), then we can finish above
>     job in common method.
> 
>     In order to avoid the default bus being populated twice, simply checking
>     the flag of bus node whether has be set OF_POPULATED_BUS or not.
> 
>     After that, we can safely remove the caller in arch code.
> 
>     Btw, add debug print in of_platform_populate(), and use __func__ to
>     print function's name of of_platform_bus_create().
> 
>     Cc: Rob Herring <robh+dt@kernel.org>
>     Cc: Frank Rowand <frowand.list@gmail.com>
>     Cc: Grant Likely <grant.likely@linaro.org>
>     Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>     Signed-off-by: Rob Herring <robh@kernel.org>
> 
> :040000 040000 2d2438c33110bd5d0cba9540357c7e81f74485dd 3ad033aad77298c3a6f50ed4c651d7336825d700 M    drivers
> root@julian-VirtualBox:/usr/src/linux-test#
> 
> 
> git bisect log
> git bisect start
> # good: [523d939ef98fd712632d93a5a2b588e477a7565e] Linux 4.7
> git bisect good 523d939ef98fd712632d93a5a2b588e477a7565e
> # bad: [29b4817d4018df78086157ea3a55c1d9424a7cfc] Linux 4.8-rc1
> git bisect bad 29b4817d4018df78086157ea3a55c1d9424a7cfc
> # good: [1c88e19b0f6a8471ee50d5062721ba30b8fd4ba9] Merge branch 'akpm' (patches from Andrew)
> git bisect good 1c88e19b0f6a8471ee50d5062721ba30b8fd4ba9
> # bad: [77a87824ed676ca8ff8482e4157d3adb284fd381] clocksource/drivers/clps_711x: fixup for "ARM: clps711x:
> git bisect bad 77a87824ed676ca8ff8482e4157d3adb284fd381
> # bad: [c9b95e5961c0294e0efffeaa847c1a1e6369204c] Merge tag 'sound-4.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> git bisect bad c9b95e5961c0294e0efffeaa847c1a1e6369204c
> # good: [1056c9bd2702ea1bb79abf9bd1e78c578589d247] Merge tag 'clk-for-linus-4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good 1056c9bd2702ea1bb79abf9bd1e78c578589d247
> # bad: [bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9] Merge tag 'powerpc-4.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect bad bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9
> # bad: [bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9] Merge tag 'powerpc-4.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect bad bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9
> # good: [f7b9ebb79e90b19bf6a2cb805a536258437fc3fa] powerpc: Re-order setup_panic()
> git bisect good f7b9ebb79e90b19bf6a2cb805a536258437fc3fa
> # good: [f7b9ebb79e90b19bf6a2cb805a536258437fc3fa] powerpc: Re-order setup_panic()
> git bisect good f7b9ebb79e90b19bf6a2cb805a536258437fc3fa
> # good: [944171cbf499d3445c749f7c13c46de0a564a905] pNFS: Actively set attributes as invalid if LAYOUTCOMMIT is outstanding
> git bisect good 944171cbf499d3445c749f7c13c46de0a564a905
> # bad: [b325e04ea21081439f0f3e7fe1117e883a9031d8] Merge branch 'x86-cpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad b325e04ea21081439f0f3e7fe1117e883a9031d8
> # bad: [b325e04ea21081439f0f3e7fe1117e883a9031d8] Merge branch 'x86-cpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad b325e04ea21081439f0f3e7fe1117e883a9031d8
> # bad: [0e13f99d3a4816a3996a69721388b4cf1a982cf8] Documentation: dt: i2c: use correct STMicroelectronics vendor prefix
> git bisect bad 0e13f99d3a4816a3996a69721388b4cf1a982cf8
> # bad: [1a1d2f9968660e016883b21c499158c08d9c87bf] mips: use of_platform_default_populate() to populate default bus
> git bisect bad 1a1d2f9968660e016883b21c499158c08d9c87bf
> # bad: [db41252cf8b58c8a57226204e113b9dffaebf693] cris: Remove unnecessary of_platform_populate with default match table
> git bisect bad db41252cf8b58c8a57226204e113b9dffaebf693
> # bad: [61c78644e7f1bd9445b3d7ddc3d35989a38985ee] arc: Remove unnecessary of_platform_populate with default match table
> git bisect bad 61c78644e7f1bd9445b3d7ddc3d35989a38985ee
> # bad: [44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7] of/platform: Add common method to populate default bus
> git bisect bad 44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7
> # good: [bb8e15d60462a84a25a3bf33e8bc29b46c6d470a] of: iommu: make of_iommu_init() postcore_initcall_sync
> git bisect good bb8e15d60462a84a25a3bf33e8bc29b46c6d470a
> # first bad commit: [44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7] of/platform: Add common method to populate default bus
> 
> 
> 
> 
> .
> 
