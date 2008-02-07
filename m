Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 958AFDDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 15:43:43 +1100 (EST)
Message-ID: <47AA8C7D.3030109@pikatech.com>
Date: Wed, 06 Feb 2008 23:43:41 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: asm-offsets.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just did a git pull of Josh's tree, and 
arch/powerpc/kernel/asm-offsets.c does not compile. I have only been 
glossing over the linuxppc-dev emails, so forgive me if this already 
came up.

It looks like, at least for the Warp, CLOCK_REALTIME_RES is not defined 
so asm-offsets.c gets an error. The following patch fixes it.... but I 
am not sure it is right since I don't know if CLOCK_REALTIME_RES should 
be defined.

Cheers,
  Sean

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets
.c
index e6e4928..c1568aa 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -313,7 +313,9 @@ int main(void)
        DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
        DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
        DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
+#ifdef CLOCK_REALTIME_RES
        DEFINE(CLOCK_REALTIME_RES, (KTIME_MONOTONIC_RES).tv64);
+#endif
 
 #ifdef CONFIG_BUG
        DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
