Return-Path: <lauraa@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BFBC2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Mar 2014 05:14:02 +1100 (EST)
From: Laura Abbott <lauraa@codeaurora.org>
To: Russell King <linux@arm.linux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Hirokazu Takata <takata@linux-m32r.org>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 David Howells <dhowells@redhat.com>, Michal Simek <monstr@monstr.eu>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>
Subject: [RESEND][PATCH 0/2] Cleanup asm/scatterlist.h
Date: Sat, 22 Mar 2014 11:13:50 -0700
Message-Id: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
Cc: linux-s390@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
 Laura Abbott <lauraa@codeaurora.org>, linux-cris-kernel@axis.com,
 linux-scsi@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-am33-list@redhat.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



I haven't gotten many responses so I'm going to try sending again
(this time with a cover letter which I probably should have done in
the first place...)

ARCH_HAS_SG_CHAIN is currently defined as needed in asm/scatterlist.h.
It was suggested[1] that this should probably be a proper Kconfig.
At the same time, we can clean up most of the asm/scatterlist.h files
to reduce redundancy. This makes parisc the only architecture that still
has an asm/scatterlist.h file due to the #define sg_virt_addr (which
could probably be cleaned up further still)

Andrew, once we get a few more Acked-bys can we take this through your tree
as suggested by Will?

Thanks,
Laura

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/240435.html

Laura Abbott (2):
  lib/scatterlist: Make ARCH_HAS_SG_CHAIN an actual Kconfig
  Cleanup useless architecture versions of scatterlist.h

 arch/alpha/include/asm/Kbuild             |  1 +
 arch/alpha/include/asm/scatterlist.h      |  6 ------
 arch/arm/Kconfig                          |  1 +
 arch/arm/include/asm/Kbuild               |  1 +
 arch/arm/include/asm/scatterlist.h        | 12 ------------
 arch/arm64/Kconfig                        |  1 +
 arch/cris/include/asm/Kbuild              |  1 +
 arch/cris/include/asm/scatterlist.h       |  6 ------
 arch/frv/include/asm/Kbuild               |  1 +
 arch/frv/include/asm/scatterlist.h        |  6 ------
 arch/ia64/Kconfig                         |  1 +
 arch/ia64/include/asm/Kbuild              |  1 +
 arch/ia64/include/asm/scatterlist.h       |  7 -------
 arch/m32r/include/asm/Kbuild              |  1 +
 arch/m32r/include/asm/scatterlist.h       |  6 ------
 arch/microblaze/include/asm/Kbuild        |  1 +
 arch/microblaze/include/asm/scatterlist.h |  1 -
 arch/mn10300/include/asm/Kbuild           |  1 +
 arch/mn10300/include/asm/scatterlist.h    | 16 ----------------
 arch/powerpc/Kconfig                      |  1 +
 arch/powerpc/include/asm/Kbuild           |  1 +
 arch/powerpc/include/asm/scatterlist.h    | 17 -----------------
 arch/s390/Kconfig                         |  1 +
 arch/s390/include/asm/Kbuild              |  1 +
 arch/s390/include/asm/scatterlist.h       |  3 ---
 arch/score/include/asm/Kbuild             |  2 +-
 arch/score/include/asm/scatterlist.h      |  6 ------
 arch/sparc/Kconfig                        |  1 +
 arch/sparc/include/asm/Kbuild             |  1 +
 arch/sparc/include/asm/scatterlist.h      |  8 --------
 arch/x86/Kconfig                          |  1 +
 arch/x86/include/asm/Kbuild               |  1 +
 arch/x86/include/asm/scatterlist.h        |  8 --------
 include/linux/scatterlist.h               |  2 +-
 include/scsi/scsi.h                       |  2 +-
 lib/Kconfig                               |  7 +++++++
 lib/scatterlist.c                         |  4 ++--
 37 files changed, 31 insertions(+), 107 deletions(-)
 delete mode 100644 arch/alpha/include/asm/scatterlist.h
 delete mode 100644 arch/arm/include/asm/scatterlist.h
 delete mode 100644 arch/cris/include/asm/scatterlist.h
 delete mode 100644 arch/frv/include/asm/scatterlist.h
 delete mode 100644 arch/ia64/include/asm/scatterlist.h
 delete mode 100644 arch/m32r/include/asm/scatterlist.h
 delete mode 100644 arch/microblaze/include/asm/scatterlist.h
 delete mode 100644 arch/mn10300/include/asm/scatterlist.h
 delete mode 100644 arch/powerpc/include/asm/scatterlist.h
 delete mode 100644 arch/s390/include/asm/scatterlist.h
 delete mode 100644 arch/score/include/asm/scatterlist.h
 delete mode 100644 arch/sparc/include/asm/scatterlist.h
 delete mode 100644 arch/x86/include/asm/scatterlist.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
