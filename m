Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id B29E32BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Dec 2004 04:53:22 +1100 (EST)
To: paulus@samba.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:46:49 +0100
Message-Id: <20041225174639.5D1141EA0F@trashy.coderock.org>
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org
Subject: [patch 1/3] delete unused file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/ppc/kernel/find_name.c |   48 -----------------------------------------
 1 files changed, 48 deletions(-)

diff -L arch/ppc/kernel/find_name.c -puN arch/ppc/kernel/find_name.c~remove_file-arch_ppc_kernel_find_name.c /dev/null
--- kj/arch/ppc/kernel/find_name.c
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
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
_
