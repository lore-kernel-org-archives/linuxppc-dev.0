Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn15vgTzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/46] Update powerpc defconfigs
Date: Wed, 23 Aug 2017 15:37:20 +1000
Message-Id: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Our defconfigs have gotten quite out of date.

This is the result of a semi-automated script to update the saved defconfigs,
and only drop options that are no longer necessary / removed etc. And reinstate
those that we still want but have been dropped due to Kconfig changes.

This gets us back to everything being clean vs savedefconfig as of v4.13-rc6.

I'm not sure yet if I'll put this in next soonish, or wait until later, but
here it is any way.

cheers

Michael Ellerman (46):
  powerpc/configs: Update for symbol movement only
  powerpc/configs: Drop unneeded CONFIG_CRYPTO_ANSI_CPRNG
  powerpc/configs: Explicitly drop CONFIG_INPUT_MOUSEDEV
  powerpc/configs: Drop no longer needed CONFIG_FHANDLE
  powerpc/configs: Drop no longer needed CONFIG_DEVKMEM
  powerpc/configs: Update for CONFIG_DEBUG_FS being selected via
    CONFIG_RCU_TRACE
  powerpc/configs: Update for CONFIG_FIXED_PHY being selected by
    CONFIG_OF_MDIO
  powerpc/configs: Update for CONFIG_NF_CT_PROTO_(SCTP|UDPLITE)=y
  powerpc/configs: Drop no longer needed CONFIG_CRYPTO_DEV_VMX_ENCRYPT
  powerpc/configs: Drop no longer needed CONFIG_CRYPTO_HMAC
  powerpc/configs: Drop no longer needed CONFIG_CRYPTO_ECB
  powerpc/configs: Drop no longer needed CONFIG_CRYPTO_SHA256
  powerpc/configs: Drop no longer needed CONFIG_CRYPTO_NULL
  powerpc/configs: Drop no longer needed CONFIG_CRYPTO_NULL in g5 / c2k
  powerpc/configs: Drop no longer needed CONFIG_CRYPTO_GCM
  powerpc/configs: Drop no longer needed
    CONFIG_DEVPTS_MULTIPLE_INSTANCES
  powerpc/configs: Drop unnecessary
    CONFIG_NUMA_BALANCING_DEFAULT_ENABLED
  powerpc/configs: Drop unnecessary CONFIG_UPROBE_EVENT
  powerpc/configs: Drop no longer needed CONFIG_SMP for
    pseries/ppc64/powernv
  powerpc/configs: Drop no longer needed PCI_MSI on powernv
  powerpc/configs: Drop unnecessary CONFIG_POWERNV_OP_PANEL
  powerpc/configs: Drop MEMORY_HOTREMOVE from ppc64/cell
  powerpc/configs: Drop CONFIG_SERIAL_TXX9_* from cell/ppc64
  powerpc/configs: Drop no longer needed CONFIG_AUDITSYSCALL
  powerpc/configs: Add CONFIG_RAS now required for CONFIG_EDAC
  powerpc/configs: Drop no longer needed CONFIG_IPV6
  powerpc/configs: Drop no longer needed CONFIG_SCSI
  powerpc/configs: Drop unnecessary CONFIG_EDAC from ppc64e
  powerpc/configs: Drop no longer needed CONFIG_LIBCRC32C
  powerpc/configs: Turn CONFIG_R128 back in pmac32_defconfig
  powerpc/configs: Drop removed CONFIG_LOGFS
  powerpc/configs: Update for CONFIG_INPUT_MOUSEDEV=n
  powerpc/configs: Update for CONFIG_SND changes
  powerpc/configs/mpc5200: Drop no longer needed CONFIG_FB
  powerpc/configs/6xx: Turn CONFIG_DRM_RADEON back on
  powerpc/configs/6xx: Drop no longer needed CONFIG_TIMER_STATS
  powerpc/configs/6xx: Clean up duplicate CONFIG_EXT4 values
  powerpc/configs/6xx: Drop removed CONFIG_BLK_DEV_HD
  powerpc/configs/6xx: Drop no longer needed
    CONFIG_NF_CONNTRACK_PROC_COMPAT
  powerpc/configs/6xx: Reinstate CONFIG_CPU_FREQ_STAT
  powerpc/configs/6xx: Drop no longer needed
    CONFIG_NETFILTER_XT_MATCH_SOCKET
  powerpc/configs/6xx: Drop no longer needed CONFIG_BT_HCIUART_H4
  powerpc/configs/6xx: Switch CONFIG_USB_EHCI_FSL to =m
  powerpc/configs/c2k: Switch CONFIG_GEN_RTC from =m to =y
  powerpc/configs/6xx: Drop no longer selectable CONFIG_BT_HCIUART_LL
  powerpc/configs/6xx: Drop removed CONFIG_USB_LED

 arch/powerpc/configs/40x/acadia_defconfig         |  1 -
 arch/powerpc/configs/40x/ep405_defconfig          |  1 -
 arch/powerpc/configs/40x/kilauea_defconfig        |  1 -
 arch/powerpc/configs/40x/klondike_defconfig       |  1 -
 arch/powerpc/configs/40x/makalu_defconfig         |  1 -
 arch/powerpc/configs/40x/obs600_defconfig         |  1 -
 arch/powerpc/configs/40x/virtex_defconfig         |  3 +-
 arch/powerpc/configs/40x/walnut_defconfig         |  1 -
 arch/powerpc/configs/44x/akebono_defconfig        |  2 -
 arch/powerpc/configs/44x/bamboo_defconfig         |  1 -
 arch/powerpc/configs/44x/currituck_defconfig      |  2 -
 arch/powerpc/configs/44x/ebony_defconfig          |  1 -
 arch/powerpc/configs/44x/eiger_defconfig          |  4 --
 arch/powerpc/configs/44x/fsp2_defconfig           |  1 -
 arch/powerpc/configs/44x/icon_defconfig           |  3 --
 arch/powerpc/configs/44x/iss476-smp_defconfig     |  2 -
 arch/powerpc/configs/44x/katmai_defconfig         |  1 -
 arch/powerpc/configs/44x/rainier_defconfig        |  1 -
 arch/powerpc/configs/44x/redwood_defconfig        |  4 --
 arch/powerpc/configs/44x/sequoia_defconfig        |  1 -
 arch/powerpc/configs/44x/taishan_defconfig        |  1 -
 arch/powerpc/configs/44x/virtex5_defconfig        |  3 +-
 arch/powerpc/configs/44x/warp_defconfig           |  1 -
 arch/powerpc/configs/52xx/cm5200_defconfig        |  1 -
 arch/powerpc/configs/52xx/lite5200b_defconfig     |  3 +-
 arch/powerpc/configs/52xx/motionpro_defconfig     | 15 +++----
 arch/powerpc/configs/52xx/tqm5200_defconfig       |  2 -
 arch/powerpc/configs/83xx/asp8347_defconfig       |  2 -
 arch/powerpc/configs/83xx/kmeter1_defconfig       |  1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  3 --
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  2 -
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  4 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  6 +--
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  2 -
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  1 -
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  2 -
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  4 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  5 +--
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  4 +-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  5 +--
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  4 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig      |  3 +-
 arch/powerpc/configs/85xx/ksi8560_defconfig       |  4 +-
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |  4 +-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |  6 +--
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |  4 +-
 arch/powerpc/configs/85xx/sbc8548_defconfig       |  4 +-
 arch/powerpc/configs/85xx/socrates_defconfig      |  3 --
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  3 --
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  4 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  4 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig       |  2 -
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  4 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  4 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   |  5 +--
 arch/powerpc/configs/adder875_defconfig           |  2 +-
 arch/powerpc/configs/amigaone_defconfig           |  2 -
 arch/powerpc/configs/c2k_defconfig                |  5 +--
 arch/powerpc/configs/cell_defconfig               |  9 +---
 arch/powerpc/configs/chrp32_defconfig             |  3 +-
 arch/powerpc/configs/ep8248e_defconfig            |  1 -
 arch/powerpc/configs/ep88xc_defconfig             |  2 +-
 arch/powerpc/configs/g5_defconfig                 | 16 +++----
 arch/powerpc/configs/gamecube_defconfig           |  7 ++-
 arch/powerpc/configs/holly_defconfig              |  3 +-
 arch/powerpc/configs/linkstation_defconfig        |  3 --
 arch/powerpc/configs/maple_defconfig              |  9 +---
 arch/powerpc/configs/mgcoge_defconfig             |  2 -
 arch/powerpc/configs/mpc512x_defconfig            | 28 +++++-------
 arch/powerpc/configs/mpc5200_defconfig            |  4 --
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |  4 +-
 arch/powerpc/configs/mpc8272_ads_defconfig        |  1 -
 arch/powerpc/configs/mpc83xx_defconfig            | 10 ++---
 arch/powerpc/configs/mpc866_ads_defconfig         |  4 +-
 arch/powerpc/configs/mpc86xx_basic_defconfig      | 12 ++---
 arch/powerpc/configs/mpc885_ads_defconfig         |  2 +-
 arch/powerpc/configs/mvme5100_defconfig           |  3 --
 arch/powerpc/configs/pasemi_defconfig             |  8 ++--
 arch/powerpc/configs/pmac32_defconfig             | 18 ++++----
 arch/powerpc/configs/powernv_defconfig            | 14 ++----
 arch/powerpc/configs/ppc40x_defconfig             |  3 +-
 arch/powerpc/configs/ppc44x_defconfig             |  4 +-
 arch/powerpc/configs/ppc64_defconfig              | 40 ++++++++---------
 arch/powerpc/configs/ppc64e_defconfig             | 17 +++-----
 arch/powerpc/configs/ppc6xx_defconfig             | 53 +++++++++--------------
 arch/powerpc/configs/pq2fads_defconfig            |  1 -
 arch/powerpc/configs/ps3_defconfig                |  3 --
 arch/powerpc/configs/pseries_defconfig            | 39 +++++++----------
 arch/powerpc/configs/tqm8xx_defconfig             |  3 +-
 arch/powerpc/configs/wii_defconfig                | 10 ++---
 90 files changed, 151 insertions(+), 352 deletions(-)

-- 
2.7.4
