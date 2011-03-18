Return-Path: <prasadjoshi124@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CFA84B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 06:41:04 +1100 (EST)
Received: by wyj26 with SMTP id 26so3827961wyj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Mar 2011 12:41:00 -0700 (PDT)
Date: Fri, 18 Mar 2011 19:41:35 +0000
From: Prasad Joshi <prasadjoshi124@gmail.com>
To: akpm@linux-foundation.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	prasadjoshi124@gmail.com, mitra@kqinfotech.com
Subject: [RFC][PATCH v3 00/22] __vmalloc: Propagating GFP allocation flag
	inside __vmalloc()
Message-ID: <20110318194135.GA4746@prasad-kvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	linux-sh@vger.kernel.org, heiko.carstens@de.ibm.com,
	dhowells@redhat.com, liqin.chen@sunplusct.com, paulus@samba.org,
	lennox.wu@gmail.com, jesper.nilsson@axis.com,
	linux-am33-list@redhat.com, linux@arm.linux.org.uk,
	deller@gmx.de, x86@kernel.org, jejb@parisc-linux.org,
	geert@linux-m68k.org, sammy@sammy.net, fenghua.yu@intel.com,
	microblaze-uclinux@itee.uq.edu.au, jdike@addtoit.com,
	cmetcalf@tilera.com, starvik@axis.com, schwidefsky@de.ibm.com,
	linux-m68k@lists.linux-m68k.org, tony.luck@intel.com,
	rth@twiddle.net, chris@zankel.net, monstr@monstr.eu,
	linux-m32r@ml.linux-m32r.org, linux-cris-kernel@axis.com,
	linux-parisc@vger.kernel.org, ralf@linux-mips.org,
	hans-christian.egtvedt@atmel.com, kyle@mcmartin.ca,
	linux-alpha@vger.kernel.org, tj@kernel.org, linux390@de.ibm.com,
	yasutake.koichi@jp.panasonic.com, linuxppc-dev@lists.ozlabs.org,
	takata@linux-m32r.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A filesystem might run into a problem while calling __vmalloc(GFP_NOFS)
inside a lock.

It is expected than __vmalloc when called with GFP_NOFS should not
callback the filesystem code even incase of the increased memory
pressure. But the problem is that even if we pass this flag, __vmalloc
itself allocates memory with GFP_KERNEL.

Using GFP_KERNEL allocations may go into the memory reclaim path and try
to free memory by calling file system evict_inode function. Which might
lead into deadlock.

For further details
http://marc.info/?l=linux-mm&m=128942194520631&w=4
https://bugzilla.kernel.org/show_bug.cgi?id=30702

The patch passes the gfp allocation flag all the way down to those
allocating functions.

 arch/arm/include/asm/pgalloc.h           |   11 +++++-
 arch/avr32/include/asm/pgalloc.h         |    8 ++++-
 arch/cris/include/asm/pgalloc.h          |   10 ++++-
 arch/frv/include/asm/pgalloc.h           |    3 ++
 arch/frv/include/asm/pgtable.h           |    1 +
 arch/frv/mm/pgalloc.c                    |    9 ++++-
 arch/ia64/include/asm/pgalloc.h          |   24 +++++++++++--
 arch/m32r/include/asm/pgalloc.h          |   11 ++++--
 arch/m68k/include/asm/motorola_pgalloc.h |   20 +++++++++--
 arch/m68k/include/asm/sun3_pgalloc.h     |   14 ++++++--
 arch/m68k/mm/memory.c                    |    9 ++++-
 arch/microblaze/include/asm/pgalloc.h    |    3 ++
 arch/microblaze/mm/pgtable.c             |   13 +++++--
 arch/mips/include/asm/pgalloc.h          |   22 ++++++++----
 arch/mn10300/include/asm/pgalloc.h       |    2 +
 arch/mn10300/mm/pgtable.c                |   10 ++++-
 arch/parisc/include/asm/pgalloc.h        |   21 ++++++++---
 arch/powerpc/include/asm/pgalloc-32.h    |    2 +
 arch/powerpc/include/asm/pgalloc-64.h    |   27 +++++++++++---
 arch/powerpc/mm/pgtable_32.c             |   10 ++++-
 arch/s390/include/asm/pgalloc.h          |   30 +++++++++++++---
 arch/s390/mm/pgtable.c                   |   22 +++++++++---
 arch/score/include/asm/pgalloc.h         |   13 ++++---
 arch/sh/include/asm/pgalloc.h            |    8 ++++-
 arch/sh/mm/pgtable.c                     |    8 ++++-
 arch/sparc/include/asm/pgalloc_32.h      |    5 +++
 arch/sparc/include/asm/pgalloc_64.h      |   17 ++++++++-
 arch/tile/include/asm/pgalloc.h          |   13 ++++++-
 arch/tile/mm/pgtable.c                   |   10 ++++-
 arch/um/include/asm/pgalloc.h            |    1 +
 arch/um/kernel/mem.c                     |   21 ++++++++---
 arch/x86/include/asm/pgalloc.h           |   17 ++++++++-
 arch/x86/mm/pgtable.c                    |    8 ++++-
 arch/xtensa/include/asm/pgalloc.h        |    9 ++++-
 arch/xtensa/mm/pgtable.c                 |   11 +++++-
 include/asm-generic/4level-fixup.h       |    8 +++-
 include/asm-generic/pgtable-nopmd.h      |    3 +-
 include/asm-generic/pgtable-nopud.h      |    1 +
 include/linux/mm.h                       |   40 ++++++++++++++++-----
 mm/memory.c                              |   14 ++++---
 mm/vmalloc.c                             |   57 ++++++++++++++++++++----------
 41 files changed, 427 insertions(+), 119 deletions(-)
