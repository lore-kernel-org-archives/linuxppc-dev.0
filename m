Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 79A56B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 13:15:03 +1000 (EST)
Date: Tue, 11 Aug 2009 13:14:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: use consistent types in mktree
Message-Id: <20090811131455.eceea05e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gcc v4.4 currently produces this build warning:

arch/powerpc/boot/mktree.c: In function 'main':
arch/powerpc/boot/mktree.c:104: warning: dereferencing type-punned pointer will break strict-aliasing rules

tmpbuf is only used as an array of unsigned ints, so declare it that way.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/boot/mktree.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/mktree.c b/arch/powerpc/boot/mktree.c
index c2baae0..e2ae243 100644
--- a/arch/powerpc/boot/mktree.c
+++ b/arch/powerpc/boot/mktree.c
@@ -36,7 +36,7 @@ typedef struct boot_block {
 } boot_block_t;
 
 #define IMGBLK	512
-char	tmpbuf[IMGBLK];
+unsigned int	tmpbuf[IMGBLK / sizeof(unsigned int)];
 
 int main(int argc, char *argv[])
 {
@@ -95,13 +95,13 @@ int main(int argc, char *argv[])
 
 	/* Assume zImage is an ELF file, and skip the 64K header.
 	*/
-	if (read(in_fd, tmpbuf, IMGBLK) != IMGBLK) {
+	if (read(in_fd, tmpbuf, sizeof(tmpbuf)) != sizeof(tmpbuf)) {
 		fprintf(stderr, "%s is too small to be an ELF image\n",
 				argv[1]);
 		exit(4);
 	}
 
-	if ((*(unsigned int *)tmpbuf) != htonl(0x7f454c46)) {
+	if (tmpbuf[0] != htonl(0x7f454c46)) {
 		fprintf(stderr, "%s is not an ELF image\n", argv[1]);
 		exit(4);
 	}
@@ -121,11 +121,11 @@ int main(int argc, char *argv[])
 	}
 
 	while (nblks-- > 0) {
-		if (read(in_fd, tmpbuf, IMGBLK) < 0) {
+		if (read(in_fd, tmpbuf, sizeof(tmpbuf)) < 0) {
 			perror("zImage read");
 			exit(5);
 		}
-		cp = (unsigned int *)tmpbuf;
+		cp = tmpbuf;
 		for (i = 0; i < sizeof(tmpbuf) / sizeof(unsigned int); i++)
 			cksum += *cp++;
 		if (write(out_fd, tmpbuf, sizeof(tmpbuf)) != sizeof(tmpbuf)) {
-- 
1.6.3.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
