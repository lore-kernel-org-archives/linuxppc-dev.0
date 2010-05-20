Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id AE9D9B7D2E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 19:43:00 +1000 (EST)
Received: from int-mx05.intmail.prod.int.phx2.redhat.com
	(int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o4K9grJT010647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 05:42:53 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] PPC: Fix zero length strncmp() on powerpc
To: srostedt@redhat.com
Date: Thu, 20 May 2010 10:42:48 +0100
Message-ID: <20100520094248.30540.89543.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When strncmp() on powerpc is given a length of zero, it detects this and
returns early to make the comparison loop simpler.  When it does this, however,
it fails to set a return value, and thus returns the address of the first
string as the number of the character match.  It should return 0 instead in
this case.

This can be tested by compiling and attempting to load the following module:

	#include <linux/init.h>
	#include <linux/module.h>

	char string1[1], string2[1];

	size_t count_global = 0;

	static int __init strncmp_init(void)
	{
		string1[0] = string2[0] = 0;

		if (strncmp(string1, string2, count_global)) {
			printk("Strncmp Bug!\n");
			return -EIO;
		}
		return -ENOANO;
	}

	module_init(strncmp_init);
	MODULE_LICENSE("GPL");
	MODULE_DESCRIPTION("Probe strncmp() bug");

It should return error "No anode" on success and "I/O error" on failure.  The
module will not be retained.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/powerpc/lib/string.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 64e2e49..46fe390 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -71,7 +71,7 @@ _GLOBAL(strcmp)
 
 _GLOBAL(strncmp)
 	PPC_LCMPI r5,0
-	beqlr
+	beq-	2f
 	mtctr	r5
 	addi	r5,r3,-1
 	addi	r4,r4,-1
@@ -82,6 +82,8 @@ _GLOBAL(strncmp)
 	beqlr	1
 	bdnzt	eq,1b
 	blr
+2:	li	r3,0
+	blr
 
 _GLOBAL(strlen)
 	addi	r4,r3,-1
