Return-Path: <timur@freescale.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 1CF59DDDA9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 18:36:45 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org,
	galak@kernel.crashing.org
Subject: [PATCH] powerpc: fix mktree build error on Mac OS X host
Date: Thu, 30 Apr 2009 23:16:44 -0500
Message-Id: <1241151404-5274-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mktree utility defines some variables as "uint", although this is not a
standard C type, and so cross-compiling on Mac OS X fails.  Change this to
"unsigned int".

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/mktree.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/mktree.c b/arch/powerpc/boot/mktree.c
index 45d06a8..c2baae0 100644
--- a/arch/powerpc/boot/mktree.c
+++ b/arch/powerpc/boot/mktree.c
@@ -42,7 +42,7 @@ int main(int argc, char *argv[])
 {
 	int	in_fd, out_fd;
 	int	nblks, i;
-	uint	cksum, *cp;
+	unsigned int	cksum, *cp;
 	struct	stat	st;
 	boot_block_t	bt;
 
@@ -90,7 +90,7 @@ int main(int argc, char *argv[])
 
 	cksum = 0;
 	cp = (void *)&bt;
-	for (i=0; i<sizeof(bt)/sizeof(uint); i++)
+	for (i = 0; i < sizeof(bt) / sizeof(unsigned int); i++)
 		cksum += *cp++;
 
 	/* Assume zImage is an ELF file, and skip the 64K header.
@@ -101,7 +101,7 @@ int main(int argc, char *argv[])
 		exit(4);
 	}
 
-	if ((*(uint *)tmpbuf) != htonl(0x7f454c46)) {
+	if ((*(unsigned int *)tmpbuf) != htonl(0x7f454c46)) {
 		fprintf(stderr, "%s is not an ELF image\n", argv[1]);
 		exit(4);
 	}
@@ -125,8 +125,8 @@ int main(int argc, char *argv[])
 			perror("zImage read");
 			exit(5);
 		}
-		cp = (uint *)tmpbuf;
-		for (i=0; i<sizeof(tmpbuf)/sizeof(uint); i++)
+		cp = (unsigned int *)tmpbuf;
+		for (i = 0; i < sizeof(tmpbuf) / sizeof(unsigned int); i++)
 			cksum += *cp++;
 		if (write(out_fd, tmpbuf, sizeof(tmpbuf)) != sizeof(tmpbuf)) {
 			perror("boot-image write");
-- 
1.6.2.4
