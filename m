Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 391E6DE1CA
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 21:58:28 +1000 (EST)
Date: Mon, 4 May 2009 14:00:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: [PATCH 2/3] kbuild,
	modpost: fix "unexpected non-allocatable" warning with SUSE gcc
Message-ID: <20090504120025.GB7239@uranus.ravnborg.org>
References: <20090504115704.GA7134@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090504115704.GA7134@uranus.ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfgang Denk <wd@denx.de>,
	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 028ecebdd83cc4a7f8c7e96e28a5537d2ac98dae Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 3 May 2009 22:17:37 +0200
Subject: [PATCH 2/3] kbuild, modpost: fix "unexpected non-allocatable" warning with SUSE gcc

Jean reported that he saw one warning for each module like the one below:
WARNING: arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.o (.comment.SUSE.OPTs): unexpected non-allocatable section.

The warning appeared with the improved version of the
check of the flags in the sections.

That check already ignored sections named ".comment" - but SUSE store
additional info in the comment section and has named it in a SUSE
specific way. Therefore modpost failed to ignore the section.

The fix is to extend the pattern so we ignore all sections
that start with the name ".comment.".

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: Jean Delvare <khali@linux-fr.org>
Tested-by: Jean Delvare <khali@linux-fr.org>
---
 scripts/mod/modpost.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a5c17db..268d457 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -727,7 +727,7 @@ int match(const char *sym, const char * const pat[])
 
 /* sections that we do not want to do full section mismatch check on */
 static const char *section_white_list[] =
-	{ ".comment", ".debug*", ".stab*", ".note*", ".got*", ".toc*", NULL };
+	{ ".comment*", ".debug*", ".stab*", ".note*", ".got*", ".toc*", NULL };
 
 /*
  * This is used to find sections missing the SHF_ALLOC flag.
-- 
1.6.3.rc3.40.g75b44
