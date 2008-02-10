Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 201ABDDEBB
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 07:37:48 +1100 (EST)
Date: Sun, 10 Feb 2008 21:07:59 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/8] arch/ppc: Use FIELD_SIZEOF
Message-ID: <Pine.LNX.4.64.0802102107060.23906@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Robert P.J. Day proposed to use the macro FIELD_SIZEOF in replace of code
that matches its definition.

The modification was made using the following semantic patch
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@haskernel@
@@

#include <linux/kernel.h>

@depends on haskernel@
type t;
identifier f;
@@

- (sizeof(((t*)0)->f))
+ FIELD_SIZEOF(t, f)

@depends on haskernel@
type t;
identifier f;
@@

- sizeof(((t*)0)->f)
+ FIELD_SIZEOF(t, f)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---

diff -u -p a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
--- a/arch/ppc/8xx_io/commproc.c 2008-02-02 15:28:16.000000000 +0100
+++ b/arch/ppc/8xx_io/commproc.c 2008-02-10 17:36:23.000000000 +0100
@@ -43,7 +43,7 @@
 ({									\
 	u32 offset = offsetof(immap_t, member);				\
 	void *addr = ioremap (IMAP_ADDR + offset,			\
-			      sizeof( ((immap_t*)0)->member));		\
+			      FIELD_SIZEOF(immap_t, member));		\
 	addr;								\
 })
 
