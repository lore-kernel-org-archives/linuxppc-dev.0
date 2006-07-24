Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A235679A6
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 16:52:44 +1000 (EST)
Date: Mon, 24 Jul 2006 08:52:37 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] use gcc -O1 in fs/reiserfs only for ancient gcc versions
Message-ID: <20060724065237.GA32202@suse.de>
References: <20050426211019.GA11579@suse.de> <426F9646.3000407@namesys.com>
	<20051011190133.GA31348@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051011190133.GA31348@suse.de>
Cc: linuxppc-dev@ozlabs.org, reiserfs-dev@namesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


only compile with -O1 if the (very old) compiler is broken.
We use reiserfs alot since SLES9 on ppc64, and it was never seen
with gcc33.
Assume the broken gcc is gcc-3.4 or older.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/reiserfs/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc2/fs/reiserfs/Makefile
===================================================================
--- linux-2.6.18-rc2.orig/fs/reiserfs/Makefile
+++ linux-2.6.18-rc2/fs/reiserfs/Makefile
@@ -28,7 +28,7 @@ endif
 # will work around it. If any other architecture displays this behavior,
 # add it here.
 ifeq ($(CONFIG_PPC32),y)
-EXTRA_CFLAGS := -O1
+EXTRA_CFLAGS := $(call cc-ifversion, -lt, 0400, -O1)
 endif
 
 TAGS:
