Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: robdlg@att.net
Message-Id: <200310061051.FAA10075@lists.linuxppc.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: popt, ELDK 2.0.2
Date: Mon, 06 Oct 2003 10:51:44 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was experimenting with the popt library in the ELDK 2.0.2, and I received
the following errors.  The same compiler invocation is successful when used
with gcc under Red Hat Linux 7.3.  The source code follows the error
messages.  How do I properly compile and link this file?

ppc_82xx-gcc -Wall -lpopt -o popt_test main.c
/tmp/ccMrZmW2.o: In function `main':
/tmp/ccMrZmW2.o(.text+0x60): undefined reference to `poptGetContext'
/tmp/ccMrZmW2.o(.text+0x60): relocation truncated to fit: R_PPC_REL24
poptGetContext
/tmp/ccMrZmW2.o(.text+0x70): undefined reference to `poptGetNextOpt'
/tmp/ccMrZmW2.o(.text+0x70): relocation truncated to fit: R_PPC_REL24
poptGetNextOpt
/tmp/ccMrZmW2.o(.text+0x94): undefined reference to `poptFreeContext'
/tmp/ccMrZmW2.o(.text+0x94): relocation truncated to fit: R_PPC_REL24
poptFreeContext
collect2: ld returned 1 exit status
make: *** [all] Error 1

#include <stdio.h>
#include <stdlib.h>
#include <popt.h>

int main(int argc, char *argv[])
{
	int rc;

	/* command-line arguments */
	struct poptOption options[] = {
		{ "help", 'h', POPT_ARG_NONE, NULL, 1 },
		{ NULL, 0, 0, NULL, 0 }
	};
	poptContext context;

	context = poptGetContext(NULL, argc, (const char **)argv, options,
0);
	rc = poptGetNextOpt( context );

	printf("%d\n", rc);

	poptFreeContext( context);

	return 0;
}

/* eof */

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
