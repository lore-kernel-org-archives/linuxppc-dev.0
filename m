Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D7B6DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:17 +1000 (EST)
Date: Mon, 20 Aug 2007 12:40:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 16/20] bootwrapper: Move strncmp() and strchr() from
	flatdevtree_env.h to string.h.
Message-ID: <20070820174007.GO30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

strncmp() will be needed for PlanetCore firmware support.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree_env.h |   20 --------------------
 arch/powerpc/boot/string.h          |   20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_env.h b/arch/powerpc/boot/flatdevtree_env.h
index 83bc1c7..ad0420d 100644
--- a/arch/powerpc/boot/flatdevtree_env.h
+++ b/arch/powerpc/boot/flatdevtree_env.h
@@ -24,24 +24,4 @@
 #define be64_to_cpu(x)		(x)
 #define cpu_to_be64(x)		(x)
 
-static inline int strncmp(const char *cs, const char *ct, size_t count)
-{
-	signed char __res = 0;
-
-	while (count) {
-		if ((__res = *cs - *ct++) != 0 || !*cs++)
-			break;
-		count--;
-	}
-	return __res;
-}
-
-static inline char *strchr(const char *s, int c)
-{
-	for (; *s != (char)c; ++s)
-		if (*s == '\0')
-			return NULL;
-	return (char *)s;
-}
-
 #endif /* _PPC_BOOT_FLATDEVTREE_ENV_H_ */
diff --git a/arch/powerpc/boot/string.h b/arch/powerpc/boot/string.h
index 9fdff1c..439ff64 100644
--- a/arch/powerpc/boot/string.h
+++ b/arch/powerpc/boot/string.h
@@ -14,4 +14,24 @@ extern void *memmove(void *dest, const void *src, unsigned long n);
 extern void *memcpy(void *dest, const void *src, unsigned long n);
 extern int memcmp(const void *s1, const void *s2, size_t n);
 
+static inline int strncmp(const char *cs, const char *ct, size_t count)
+{
+	signed char __res = 0;
+
+	while (count) {
+		if ((__res = *cs - *ct++) != 0 || !*cs++)
+			break;
+		count--;
+	}
+	return __res;
+}
+
+static inline char *strchr(const char *s, int c)
+{
+	for (; *s != (char)c; ++s)
+		if (*s == '\0')
+			return NULL;
+	return (char *)s;
+}
+
 #endif	/* _PPC_BOOT_STRING_H_ */
-- 
1.5.0.3
