Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.154])
	by ozlabs.org (Postfix) with ESMTP id 733C8DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 11:08:56 +1100 (EST)
Message-ID: <4601C8F7.5060006@comcast.net>
Date: Wed, 21 Mar 2007 20:08:23 -0400
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: libfdt: going forward for u-boot
Content-Type: multipart/mixed; boundary="------------070000030501080105090804"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070000030501080105090804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

I'm using libfdt in u-boot and getting close to pushing u-boot changes 
upstream.  I'm curious what libfdt's legal status is WRT dual licensing 
and the legal dogs you've unleashed.

One thought that occurred to me since we last discussed this is to 
relicense it LGPL.  That way it could be linked into proprietary code 
without having to maintain a dual license and the copyright assignment 
headaches that come with outside contributors.

I made some trivial changes to fdt.h and libfdt_env.h to allow libfdt to 
compiler both on linux and for u-boot.  I've attached a patch since it 
_is_ trivial.

Here is the thumbnail sketch of my current changes to use libfdt in u-boot:

Makefile
--------
* Replaced with a u-boot version, unavoidable.

fdt.h
-----
* See attached patchfile for trivial change to allow compiling under
     linux and u-boot.

libfdt_env.h
------------
* See attached patchfile for change to allow compiling under linux
     and u-boot.
* #include <asm/byteorder.h> which gives us direct byteswapping
     utilities without having to do a #if __BYTE_ORDER == __BIG_ENDIAN
#define fdt32_to_cpu(x)                (__be32_to_cpu(x))
#define cpu_to_fdt32(x)                (__cpu_to_be32(x))
#define fdt64_to_cpu(x)                (__be64_to_cpu(x))
#define cpu_to_fdt64(x)                (__cpu_to_be32(x))
    (could change the source to use __be32_to_cpu(x) and friends, but
    I was too lazy to do this).

fdt_ro.c
--------
* Added comments as I figured out how things worked... ;-)
* Added a new function to allow me to step through tags, which I needed
     to recursively print the tree/subtree.  This returns a pointer to
     the name of the next node/property (if appropriate) via **namep.
     The caller can then use the node type (return value) and the string
     to print the property or follow the node.

uint32_t fdt_next_tag(const void *fdt, int offset,
                       int *nextoffset, char **namep);

     *This is the only thing I would consider non-trivial, and that is
     seriously debatable since it is mostly a copy of _fdt_next_tag()*

     Not done: because I protected namep against NULL, the existing
     _fdt_next_tag() could be trivially rewritten to be:
     fdt_next_tag(fdt, offset, nextoffset, NULL);

* Added a (void *) typecast to the fdt_getprop() return value to get rid
     of a compiler warning.

fdt_rw.c
--------
* Nonessential improvements to fdt_open_into()
   * Validate the header (fdt_move() does the validation, but I skip
       the move if buf == fdt so I needed to add the validation)
   * Do the fdt_move() only if (buf != fdt) - I call this at times with
       a new (longer) length but don't want to actually move the blob,
       just want the longer length so I can modify the fdt in-place.  The
       current code works, but it seemed silly to do a move if I'm not
       actually moving it.

gvb

--------------070000030501080105090804
Content-Type: text/plain;
 name="0001-Use-a-common-header-set-linux-u-boot.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Use-a-common-header-set-linux-u-boot.txt"

>From 6772dfdf27e153d0698f7fbecff767417ae76eab Mon Sep 17 00:00:00 2001
From: Gerald Van Baren <vanbaren@cideas.com>
Date: Wed, 21 Mar 2007 19:40:38 -0400
Subject: [PATCH] Use a common header set linux/u-boot

Using the "right" header files along with the __KERNEL__ discriminator
allows libfdt to be compiled under linux (userland) or u-boot.  It
also simplifies the byteswap #defines.

Signed-off-by: Gerald Van Baren <vanbaren@cideas.com>
---
 fdt.h        |    4 ++++
 libfdt_env.h |   21 +++++++++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fdt.h b/fdt.h
index 4687a31..64507a9 100644
--- a/fdt.h
+++ b/fdt.h
@@ -3,7 +3,11 @@
 
 #ifndef __ASSEMBLY__
 
+#ifndef __KERNEL__
 #include <stdint.h>
+#else
+#include <linux/types.h>
+#endif
 
 struct fdt_header {
 	uint32_t magic;                  /* magic word FDT_MAGIC */
diff --git a/libfdt_env.h b/libfdt_env.h
index 59f2536..dc6562e 100644
--- a/libfdt_env.h
+++ b/libfdt_env.h
@@ -2,21 +2,18 @@
 #define _LIBFDT_ENV_H
 
 #include <stddef.h>
+#ifndef __KERNEL__
 #include <stdint.h>
 #include <string.h>
-#include <endian.h>
-#include <byteswap.h>
-
-#if __BYTE_ORDER == __BIG_ENDIAN
-#define fdt32_to_cpu(x)		(x)
-#define cpu_to_fdt32(x)		(x)
-#define fdt64_to_cpu(x)		(x)
-#define cpu_to_fdt64(x)		(x)
 #else
-#define fdt32_to_cpu(x)		(bswap_32((x)))
-#define cpu_to_fdt32(x)		(bswap_32((x)))
-#define fdt64_to_cpu(x)		(bswap_64((x)))
-#define cpu_to_fdt64(x)		(bswap_64((x)))
+#include <linux/types.h>
+#include <linux/string.h>
 #endif
+#include <asm/byteorder.h>
+
+#define fdt32_to_cpu(x)		(__be32_to_cpu(x))
+#define cpu_to_fdt32(x)		(__cpu_to_be32(x))
+#define fdt64_to_cpu(x)		(__be64_to_cpu(x))
+#define cpu_to_fdt64(x)		(__cpu_to_be32(x))
 
 #endif /* _LIBFDT_ENV_H */
-- 
1.4.4.4


--------------070000030501080105090804--
