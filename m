Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D3111A0920
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 06:33:13 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 17:33:09 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id D6F3A1DC0027
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 16:33:06 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s77KXPa94837544
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 17:33:26 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s77KX5nr021451
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 16:33:06 -0400
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: mmarek@suse.cz
Subject: [PATCH] deb-pkg: support ppc64 and ppc64el Debian archs
Date: Thu,  7 Aug 2014 17:32:53 -0300
Message-Id: <1407443573-21522-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: brenohl@br.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
---
 scripts/package/builddeb |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 35d5a58..c26c28b 100644
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -36,6 +36,8 @@ create_package() {
 		debarch=sparc ;;
 	s390*)
 		debarch=s390$(grep -q CONFIG_64BIT=y $KCONFIG_CONFIG && echo x || true) ;;
+	ppc64*)
+		debarch=ppc64$(grep -q CPU_LITTLE_ENDIAN=y $KCONFIG_CONFIG && echo el || true) ;;
 	ppc*)
 		debarch=powerpc ;;
 	parisc*)
-- 
1.7.1
