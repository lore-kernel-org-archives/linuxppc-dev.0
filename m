Return-Path: <tytso@mit.edu>
Received: from thunker.thunk.org (www.church-of-our-saviour.org [69.25.196.31])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EC12DDED8
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 14:10:55 +1100 (EST)
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: Export empty_zero_page
From: "Theodore Ts'o" <tytso@mit.edu>
Message-Id: <E1JZGwo-0000vf-2v@closure.thunk.org>
Date: Tue, 11 Mar 2008 22:44:06 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

Stephen Rothwell discovered this issue in the linux-next tree:

>Today's powerpc allmodconfig build of linux-next failed with:
>
>ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!
>
>This is because commit dde5f2130096f8469eb1aa1ad250cd2a39fee3f5 ("ext4:
>ENOSPC error handling for writing to an uninitialized extent") uses
>ZERO_PAGE() which on powerpc uses empty_zero_page which is not
>EXPORT_SYMBOLed on powerpc.  I have reverted that commit and a later
>one (1ae53f35fea49a9013353078e019469551d2ad74 "ext4: zero out
>small extents when writing to prealloc area.") which depended on it.

Any chance you could get this pushed to Linus ASAP?  It would be nice if
this could get pushed before the merge window, since it could be argued
that rationalizing whether or not empty_zero_page is exported is a bug
fix, and anyway this is pretty much a zero-risk patch.  Thanks!!

          	 	     	       	    - Ted

>From c3638c5a50de0d360210205625df2ab49508f6d3 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 11 Mar 2008 22:37:27 -0400
Subject: [PATCH] ppc: Export empty_zero_page

The empty_zero_page symbol is exported by most other architectures
(s390, ia64, x86, um), and an upcoming ext4 patch needs it because
ZERO_PAGE() references empty_zero_page, and we need it to zero out an
unitialized extents in ext4 files.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 arch/ppc/kernel/ppc_ksyms.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index c353502..418203e 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -60,6 +60,7 @@ long long __ashrdi3(long long, int);
 long long __ashldi3(long long, int);
 long long __lshrdi3(long long, int);
 
+EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(clear_user_page);
 EXPORT_SYMBOL(transfer_to_handler);
-- 
1.5.4.1.144.gdfee-dirty
