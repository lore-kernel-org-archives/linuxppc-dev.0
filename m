Return-Path: <anton@samba.org>
Date: Sat, 2 Jun 2012 21:34:52 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 viro@zeniv.linux.org.uk
Subject: [PATCH] powerpc: Fix size of st_nlink on 64bit
Message-ID: <20120602213452.66ba4cbb@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


commit e57f93cc53b7 (powerpc: get rid of nlink_t uses, switch to
explicitly-sized type) changed the size of st_nlink on ppc64 from
a long to a short, resulting in boot failures.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/stat.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/stat.h	2012-06-02 21:25:50.322275743 +1000
+++ linux-build/arch/powerpc/include/asm/stat.h	2012-06-02 21:26:35.183130538 +1000
@@ -30,7 +30,7 @@ struct stat {
 	unsigned long	st_dev;
 	ino_t		st_ino;
 #ifdef __powerpc64__
-	unsigned short	st_nlink;
+	unsigned long	st_nlink;
 	mode_t		st_mode;
 #else
 	mode_t		st_mode;
