Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C5B4B6FC9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:14:40 +1000 (EST)
Received: by mail-fx0-f42.google.com with SMTP id 1so1329303fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:14:40 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 4/7] powerpc: Let simpleboot function with non zero-based
	memory maps
Date: Thu, 16 Jun 2011 16:14:25 +0200
Message-Id: <1308233668-24166-5-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-4-git-send-email-monstr@monstr.eu>
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
	<1308233668-24166-2-git-send-email-monstr@monstr.eu>
	<1308233668-24166-3-git-send-email-monstr@monstr.eu>
	<1308233668-24166-4-git-send-email-monstr@monstr.eu>
Cc: arnd@arndb.de, tmarri@apm.com, suzuki@in.ibm.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Williams <john.williams@petalogix.com>

It is unnecessarily restrictive to fatal() if there is physical memory at a
non-zero base address.

Signed-off-by: John Williams <john.williams@petalogix.com>
---
 arch/powerpc/boot/simpleboot.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/simpleboot.c b/arch/powerpc/boot/simpleboot.c
index 21cd480..910ae05 100644
--- a/arch/powerpc/boot/simpleboot.c
+++ b/arch/powerpc/boot/simpleboot.c
@@ -56,11 +56,6 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	if (size < (*na+*ns) * sizeof(u32))
 		fatal("cannot get memory range\n");
 
-	/* Only interested in memory based at 0 */
-	for (i = 0; i < *na; i++)
-		if (*reg++ != 0)
-			fatal("Memory range is not based at address 0\n");
-
 	/* get the memsize and trucate it to under 4G on 32 bit machines */
 	memsize64 = 0;
 	for (i = 0; i < *ns; i++)
-- 
1.5.5.6
