Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E355F67F8E
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 16:27:22 +1000 (EST)
Date: Tue, 16 Aug 2005 17:11:44 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508161711140.5796@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: removed find_name.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No one uses find_name.c and no one seems to care about either.  So I'm
removing it.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit eb5d5922d749a74f58416ca1a852651e7323449b
tree cb2371796401d2a7446134cec8f5deaa397e47ed
parent f63ab7e926d6c5e96de501ec9eac7f28af188a65
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 16 Aug 2005 17:10:26 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 16 Aug 2005 17:10:26 -0500

 arch/ppc/kernel/find_name.c |   48 -------------------------------------------
 1 files changed, 0 insertions(+), 48 deletions(-)

diff --git a/arch/ppc/kernel/find_name.c b/arch/ppc/kernel/find_name.c
deleted file mode 100644
--- a/arch/ppc/kernel/find_name.c
+++ /dev/null
@@ -1,48 +0,0 @@
-#include <stdio.h>
-#include <asm/page.h>
-#include <sys/mman.h>
-#include <strings.h>
-/*
- * Finds a given address in the System.map and prints it out
- * with its neighbors.  -- Cort
- */
-
-int main(int argc, char **argv)
-{
-	unsigned long addr, cmp, i;
-	FILE *f;
-	char s[256], last[256];
-	
-	if ( argc < 2 )
-	{
-		fprintf(stderr, "Usage: %s <address>\n", argv[0]);
-		return -1;
-	}
-
-	for ( i = 1 ; argv[i] ; i++ )
-	{
-		sscanf( argv[i], "%0lx", &addr );
-		/* adjust if addr is relative to kernelbase */
-		if ( addr < PAGE_OFFSET )
-			addr += PAGE_OFFSET;
-		
-		if ( (f = fopen( "System.map", "r" )) == NULL )
-		{
-			perror("fopen()\n");
-			exit(-1);
-		}
-		
-		while ( !feof(f) )
-		{
-			fgets(s, 255 , f);
-			sscanf( s, "%0lx", &cmp );
-			if ( addr < cmp )
-				break;
-			strcpy( last, s);
-		}
-		
-		printf( "%s%s", last, s );
-	}		
-	fclose(f);
-	return 0;
-}
