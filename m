Return-Path: <pawel.moll@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id B835D1007D5
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 03:09:17 +1100 (EST)
From: Pawel Moll <pawel.moll@arm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] params: Fix parse_args() use in PowerPC's
 reserve_hugetlb_gpages()
Date: Fri, 17 Feb 2012 16:08:36 +0000
Message-Id: <1329494916-20575-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <20120216111513.918494b07a5331eabe3d32ac@canb.auug.org.au>
References: <20120216111513.918494b07a5331eabe3d32ac@canb.auug.org.au>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, Pawel Moll <pawel.moll@arm.com>,
 linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
 McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b8076966e8e1 ("params: <level>_initcall-like kernel parameters")
changed the parse_args() API without fixing all the callers. Done now.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/powerpc/mm/hugetlbpage.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 57c7465..a3e6287 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -310,7 +310,8 @@ void __init reserve_hugetlb_gpages(void)
 =09int i;
=20
 =09strlcpy(cmdline, boot_command_line, COMMAND_LINE_SIZE);
-=09parse_args("hugetlb gpages", cmdline, NULL, 0, &do_gpage_early_setup);
+=09parse_args("hugetlb gpages", cmdline, NULL, 0, 0, 0,
+=09=09=09&do_gpage_early_setup);
=20
 =09/*
 =09 * Walk gpage list in reverse, allocating larger page sizes first.
--=20
1.7.5.4
