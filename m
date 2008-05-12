Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E072DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 06:14:19 +1000 (EST)
Received: from [10.52.0.27] (natec.xes-mad.com [10.52.0.27])
	by xes-mad.com (8.13.8/8.13.8) with ESMTP id m4CKEFMT021639
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 15:14:15 -0500
Subject: [PATCH] POWERPC: Fix uninitialized variable bug in copy_{to|from}_user
From: Nate Case <ncase@xes-inc.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 12 May 2008 15:14:14 -0500
Message-Id: <1210623254.13845.326.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Calls to copy_to_user() or copy_from_user() can fail
when copying N bytes, where N is a constant less than 8,
but not 1, 2, 4, or 8.

Signed-off-by: Dave Scidmore <dscidmore@xes-inc.com>
Signed-off-by: Nate Case <ncase@xes-inc.com>
---
 include/asm-powerpc/uaccess.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/uaccess.h b/include/asm-powerpc/uaccess.h
index 8e798e3..1a0736f 100644
--- a/include/asm-powerpc/uaccess.h
+++ b/include/asm-powerpc/uaccess.h
@@ -380,7 +380,7 @@ static inline unsigned long __copy_from_user_inatomic(void *to,
 		const void __user *from, unsigned long n)
 {
 	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret;
+		unsigned long ret = 1;
 
 		switch (n) {
 		case 1:
@@ -406,7 +406,7 @@ static inline unsigned long __copy_to_user_inatomic(void __user *to,
 		const void *from, unsigned long n)
 {
 	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret;
+		unsigned long ret = 1;
 
 		switch (n) {
 		case 1:
-- 
1.5.4.4
