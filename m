Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Y7XP1M4vzF25m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 21:16:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alexandre.belloni@bootlin.com, alistair@popple.id.au, arbab@linux.ibm.com,
 bsingharora@gmail.com, laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com, npiggin@gmail.com,
 shilpa.bhat@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 viresh.kumar@linaro.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.17-4 tag
Date: Sat, 28 Apr 2018 21:16:01 +1000
Message-ID: <87po2jtwcu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 4.17. The RTC and cpufreq
changes are both acked by a relevant maintainer.

cheers

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.17-4

for you to fetch changes up to b2d7ecbe355698010a6b7a15eb179e09eb3d6a34:

  powerpc/kvm/booke: Fix altivec related build break (2018-04-27 16:36:03 +1000)

- ----------------------------------------------------------------
powerpc fixes for 4.17 #4

A bunch of fixes, mostly for existing code and going to stable.

Our memory hot-unplug path wasn't flushing the cache before removing memory.
That is a problem now that we are doing memory hotplug on bare metal.

Three fixes for the NPU code that supports devices connected via NVLink (ie.
GPUs). The main one tweaks the TLB flush algorithm to avoid soft lockups for
large flushes.

A fix for our memory error handling where we would loop infinitely, returning
back to the bad access and hard lockup the CPU.

Fixes for the OPAL RTC driver, which wasn't handling some error cases correctly.

A fix for a hardlockup in the powernv cpufreq driver.

And finally two fixes to our smp_send_stop(), required due to a recent change to
use it on shutdown.

Thanks to:
  Alistair Popple, Balbir Singh, Laurentiu Tudor, Mahesh Salgaonkar, Mark
  Hairgrove, Nicholas Piggin, Rashmica Gupta, Shilpasri G Bhat.

- ----------------------------------------------------------------
Alistair Popple (3):
      powerpc/powernv/npu: Add lock to prevent race in concurrent context init/destroy
      powerpc/powernv/npu: Prevent overwriting of pnv_npu2_init_contex() callback parameters
      powerpc/powernv/npu: Do a PID GPU TLB flush when invalidating a large address range

Balbir Singh (2):
      powerpc/mm: Flush cache on memory hot(un)plug
      powerpc/powernv/memtrace: Let the arch hotunplug code flush cache

Laurentiu Tudor (1):
      powerpc/kvm/booke: Fix altivec related build break

Mahesh Salgaonkar (1):
      powerpc/mce: Fix a bug where mce loops on memory UE.

Nicholas Piggin (3):
      rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops
      powerpc: Fix smp_send_stop NMI IPI handling
      powerpc: Fix deadlock with multiple calls to smp_send_stop

Shilpasri G Bhat (1):
      cpufreq: powernv: Fix hardlockup due to synchronous smp_call in timer interrupt

 arch/powerpc/include/asm/powernv.h        |  2 +-
 arch/powerpc/kernel/mce_power.c           |  7 +--
 arch/powerpc/kernel/smp.c                 | 49 ++++++++++++++---
 arch/powerpc/kvm/booke.c                  |  7 +++
 arch/powerpc/mm/mem.c                     |  2 +
 arch/powerpc/platforms/powernv/memtrace.c | 17 ------
 arch/powerpc/platforms/powernv/npu-dma.c  | 88 +++++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/opal-rtc.c |  8 +--
 drivers/cpufreq/powernv-cpufreq.c         | 14 +++--
 drivers/rtc/rtc-opal.c                    | 37 ++++++++-----
 10 files changed, 166 insertions(+), 65 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJa5FfxAAoJEFHr6jzI4aWAe54P/RSoKFn7Bfuhkp3vdeD6Q6fU
Mlbm/VIzamrZ+4X4jrXbizwQgrphrqA84FTWprQet04V+VjYFKtdoIUsng+1rmZ+
CiiajXTsDz9YRYoG8mKiEBis8doBLvAIelN5lT0nx0e9BTeg/Q0gDGaLlSl6Cw2r
yusEthM3MmAYrqPlsEaZ2Ex5F2zxEW26nVjr1/SVmKJm5+zxRMIm2WCMjHDaEXBx
K5FEyT2FgCrcSitc2NQKVJ/OKyv3iAbk4/2sZrCu8h6hlJ3qVX2SCuzQvbey0rKK
jLsnZ+51uqx5TwivCQDHUM6Fzwa3moreNpHl6CtSSFp5WlHSfbOttf3i+9mSHhTP
pnORQDPw2la/DD6XKhJmSYTIBiu5/cDeAcwtYgG6WKbgOGKCVhJ5Mfne0DxxnLLc
lKeFRwQBdKQYB3qqFdjiubLpJbDW9CyqKMyIQMivqkoGwEoya04cazhaVmYartSD
cOYueG4zbJmCoeXDdCfKH2duxkAKnQVKJDj29N5IOuuNGua2dozMG/SvNQmwYX4S
Z4ZItxJAdSxGXyhzh2GNYPnd8Hp1mnMLC+bn5TRYOAy7tO3zd4Vt4Q434SyJOOsL
G6wcyT8J2ARrNEssE6m/32nskIPAOIRQaVcHjO5HKCR8fnscMSDPxYlZHPbnPT46
6ZgczHdxre4oUTAqrq9O
=D9Tc
-----END PGP SIGNATURE-----
