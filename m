Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D7EC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 05:37:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD5D60F9C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 05:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BD5D60F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HRDMf1Y5bz3cGl
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 16:37:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=valentin.schneider@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4HQmnl1VnZz2yYl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Oct 2021 22:54:32 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C00D6E;
 Fri,  8 Oct 2021 04:54:29 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com
 [10.1.196.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0B9C3F766;
 Fri,  8 Oct 2021 04:54:21 -0700 (PDT)
From: Valentin Schneider <valentin.schneider@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: [PATCH 0/2] sched: cleanup CONFIG_SCHED_MC & friends
Date: Fri,  8 Oct 2021 12:53:45 +0100
Message-Id: <20211008115347.425234-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 Oct 2021 16:36:15 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Juri Lelli <juri.lelli@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org,
 Michal Hocko <mhocko@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, YiFei Zhu <yifeifz2@illinois.edu>,
 Helge Deller <deller@gmx.de>, aubrey.li@linux.intel.com,
 Hugh Dickins <hughd@google.com>, Russell King <linux@armlinux.org.uk>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Kees Cook <keescook@chromium.org>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Vipin Sharma <vipinsh@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Nathan Chancellor <nathan@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Sergei Trofimovich <slyfox@gentoo.org>,
 jonathan.cameron@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 song.bao.hua@hisilicon.com, Ben Segall <bsegall@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Daniel Borkmann <daniel@iogearbox.net>, Chris Down <chris@chrisdown.name>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, tim.c.chen@linux.intel.com,
 "David S. Miller" <davem@davemloft.net>, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi folks,

This stems from Barry introducing a new CONFIG_SCHED_CLUSTER which highlighted
the current state of similar Kconfigs isn't great:
  http://lore.kernel.org/r/CAGsJ_4xZD0sG0Df666f0bvHOzuPMjnw0dN_mArER5k1pJ6LPLw@mail.gmail.com

The changes happen all in one big patch; the alternative would be to have one
patch per arch that adds the ARCH_SUPPORTS_SCHED_* selection, then a final patch
that adds the generic definitions and removes the arch ones (which I can do if
that's a preferred approach).

Briefly tested by setting ARCH=foo and playing around with menuconfig.

Based on top of Peter's queue:
  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git -b sched/next

Patches are also available at:
  https://git.gitlab.arm.com/linux-arm/linux-vs.git -b mainline/sched/topo_kconfig_cleanup

Cheers,
Valentin

Valentin Schneider (2):
  sched: Move Kconfig.preempt to sched/Kconfig
  sched: Centralize SCHED_{SMT, MC, CLUSTER} definitions

 arch/arm/Kconfig                          | 18 ++--------
 arch/arm64/Kconfig                        | 26 ++------------
 arch/ia64/Kconfig                         |  9 +----
 arch/mips/Kconfig                         | 10 +-----
 arch/parisc/Kconfig                       |  9 +----
 arch/powerpc/Kconfig                      |  9 +----
 arch/s390/Kconfig                         |  8 ++---
 arch/sh/Kconfig                           |  1 +
 arch/sh/mm/Kconfig                        |  9 -----
 arch/sparc/Kconfig                        | 20 ++---------
 arch/x86/Kconfig                          | 26 ++------------
 init/Kconfig                              |  2 +-
 kernel/{Kconfig.preempt => sched/Kconfig} | 41 +++++++++++++++++++++++
 13 files changed, 59 insertions(+), 129 deletions(-)
 rename kernel/{Kconfig.preempt => sched/Kconfig} (79%)

--
2.25.1

