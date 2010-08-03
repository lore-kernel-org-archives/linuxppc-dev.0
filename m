Return-Path: <anton@ozlabs.org>
Date: Tue, 3 Aug 2010 16:11:36 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/3] powerpc: Add 64bit csum_and_copy_to_user
Message-ID: <20100803061135.GB31448@kryten>
References: <20100803060834.GK29316@kryten>
 <20100803060952.GA31448@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100803060952.GA31448@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This adds the equivalent of csum_and_copy_from_user for the receive side so we
can copy and checksum in one pass. It is modelled on the generic checksum
routine.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/checksum.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/checksum.h	2010-08-03 16:02:02.234491674 +1000
+++ powerpc.git/arch/powerpc/include/asm/checksum.h	2010-08-03 16:04:10.733241094 +1000
@@ -57,6 +57,9 @@ extern __wsum csum_partial_copy_generic(
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				      int len, __wsum sum, int *err_ptr);
+#define HAVE_CSUM_COPY_USER
+extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
+				    int len, __wsum sum, int *err_ptr);
 #else
 /*
  * the same as csum_partial, but copies from src to dst while it
Index: powerpc.git/arch/powerpc/lib/checksum_wrappers_64.c
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/checksum_wrappers_64.c	2010-08-03 16:02:02.234491674 +1000
+++ powerpc.git/arch/powerpc/lib/checksum_wrappers_64.c	2010-08-03 16:02:03.063242741 +1000
@@ -63,3 +63,40 @@ out:
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
+
+__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
+			     __wsum sum, int *err_ptr)
+{
+	unsigned int csum;
+
+	might_sleep();
+
+	*err_ptr = 0;
+
+	if (!len) {
+		csum = 0;
+		goto out;
+	}
+
+	if (unlikely((len < 0) || !access_ok(VERIFY_WRITE, dst, len))) {
+		*err_ptr = -EFAULT;
+		csum = -1; /* invalid checksum */
+		goto out;
+	}
+
+	csum = csum_partial_copy_generic(src, (void __force *)dst,
+					 len, sum, NULL, err_ptr);
+
+	if (unlikely(*err_ptr)) {
+		csum = csum_partial(src, len, sum);
+
+		if (copy_to_user(dst, src, len)) {
+			*err_ptr = -EFAULT;
+			csum = -1; /* invalid checksum */
+		}
+	}
+
+out:
+	return (__force __wsum)csum;
+}
+EXPORT_SYMBOL(csum_and_copy_to_user);
