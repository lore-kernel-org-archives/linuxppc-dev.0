Date: Fri, 27 Aug 2004 15:34:54 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Reply-To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <927068331.20040827153454@varma-el.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [RFC] Remove G2_LE core decl from CLASSIC_PPC part of arch/ppc/kernel/cputable.c
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

Since G2_LE is NOT a "classic" core ( in particular - true little-endian),
may be now is time to remove it from CLASSIC_PPC part of
arch/ppc/kernel/cputable.c, and move it to itself part.
I bear in mind next:

from arch/ppc/kernel/cputable.c:

#if CLASSIC_PPC
.....
    {   /* All G2_LE (603e core, plus some) have the same pvr */
        0x7fff0000, 0x00820000, "G2_LE",
        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
        CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
        COMMON_PPC,
        32, 32,
        __setup_cpu_603
    },
....
#endif /* CLASSIC_PPC */

May be better like this:

#if CONFIG_G2_LE
    {   /* All G2_LE (603e core, plus some) have the same pvr */
        0x7fff0000, 0x00820000, "G2_LE",
        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
        CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
        COMMON_PPC,
        32, 32,
        __setup_cpu_603
    },
#endif

With that move we'll conserve some memory of kernel,
but need some explanations which PPCs based on
it, for modify Kconfig ( I know MPC52xx and MPC82xx based on it).

--
Best regards,
 Andrey Volkov


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
