Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id D6D6DDDDA9
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 21:59:27 +1000 (EST)
Date: Mon, 4 May 2009 14:01:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: [PATCH 3/3] kbuild,
	modpost: fix unexpected non-allocatable warning with mips
Message-ID: <20090504120106.GC7239@uranus.ravnborg.org>
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

>From 4391ed6aa9a38cdfb48addd7a9b24a2ff099b1a7 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 4 May 2009 13:05:26 +0200
Subject: [PATCH 3/3] kbuild, modpost: fix unexpected non-allocatable warning with mips

mips emit the following debug sections:
.mdebug* and .pdr

They were included in the check for non-allocatable section
and caused modpost to warn.

Manuel Lauss suggested to fix this by adding the relevant
sections to the list of sections we do not check.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 scripts/mod/modpost.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 268d457..161b784 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -727,7 +727,17 @@ int match(const char *sym, const char * const pat[])
 
 /* sections that we do not want to do full section mismatch check on */
 static const char *section_white_list[] =
-	{ ".comment*", ".debug*", ".stab*", ".note*", ".got*", ".toc*", NULL };
+{
+	".comment*",
+	".debug*",
+	".mdebug*",        /* alpha, score, mips etc. */
+	".pdr",            /* alpha, score, mips etc. */
+	".stab*",
+	".note*",
+	".got*",
+	".toc*",
+	NULL
+};
 
 /*
  * This is used to find sections missing the SHF_ALLOC flag.
-- 
1.6.3.rc3.40.g75b44
