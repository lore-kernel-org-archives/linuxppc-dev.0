Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 796EEB7BE2
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 06:54:19 +1100 (EST)
Message-ID: <4AF084C6.3020602@nortel.com>
Date: Tue, 03 Nov 2009 13:30:14 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, Dirk Eibach <eibach@gdsys.de>
Subject: Fwd: [PATCH] arch/powerpc: Improve _memcpy
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Forwarding to the ppc mailing list.

Chris


-------- Original Message --------
Subject: [PATCH] arch/powerpc: Improve _memcpy
Date: Tue,  3 Nov 2009 15:20:56 +0100
From: Dirk Eibach <eibach@gdsys.de>
To: linux-kernel@vger.kernel.org
CC: Dirk Eibach <eibach@gdsys.de>

The implementation of _memcpy_fromio and _memcpy_toio seems to be
suboptimal for size 4.

Signed-off-by: Dirk Eibach <eibach@gdsys.de>
---
 arch/powerpc/kernel/io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/io.c b/arch/powerpc/kernel/io.c
index 1882bf4..8dc7547 100644
--- a/arch/powerpc/kernel/io.c
+++ b/arch/powerpc/kernel/io.c
@@ -161,7 +161,7 @@ void _memcpy_fromio(void *dest, const volatile void
__iomem *src,
 		dest++;
 		n--;
 	}
-	while(n > 4) {
+	while(n >= 4) {
 		*((u32 *)dest) = *((volatile u32 *)vsrc);
 		eieio();
 		vsrc += 4;
@@ -190,7 +190,7 @@ void _memcpy_toio(volatile void __iomem *dest, const
void *src, unsigned long n)
 		vdest++;
 		n--;
 	}
-	while(n > 4) {
+	while(n >= 4) {
 		*((volatile u32 *)vdest) = *((volatile u32 *)src);
 		src += 4;
 		vdest += 4;
-- 
1.5.6.5

