Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id 775C867A46
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2005 09:23:09 +1100 (EST)
To: paulus@samba.org
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:22:56 +0100
Message-Id: <20050306222256.A3F911F1FF@trashy.coderock.org>
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org
Subject: [patch 1/4] delete unused file arch_ppc_kernel_find_name.c
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
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
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
