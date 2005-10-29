Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lLdN030108@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:50 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 35/43] ppc64 boot: print firmware provided stackpointer
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Show firmware provided stackpointer during boot.

This helps to find the "taboo" areas on the various boards.  claim tends to
fail for these memory areas, but some jokers return success anyway.

Use %p to print the load address, its a pointer.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/crt0.S |    1 +
 arch/ppc64/boot/main.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff -puN arch/ppc64/boot/crt0.S~ppc64-boot-print-firmware-provided-stackpointer arch/ppc64/boot/crt0.S
--- devel/arch/ppc64/boot/crt0.S~ppc64-boot-print-firmware-provided-stackpointer	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/crt0.S	2005-10-28 17:44:04.000000000 -0700
@@ -54,5 +54,6 @@ clear_caches:
 	sync
 	isync
 
+	mr	r6,r1
 	b	start
 
diff -puN arch/ppc64/boot/main.c~ppc64-boot-print-firmware-provided-stackpointer arch/ppc64/boot/main.c
--- devel/arch/ppc64/boot/main.c~ppc64-boot-print-firmware-provided-stackpointer	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/main.c	2005-10-28 17:44:04.000000000 -0700
@@ -131,7 +131,7 @@ static unsigned long try_claim(unsigned 
 	return addr;
 }
 
-void start(unsigned long a1, unsigned long a2, void *promptr)
+void start(unsigned long a1, unsigned long a2, void *promptr, void *sp)
 {
 	unsigned long i;
 	int len;
@@ -151,7 +151,7 @@ void start(unsigned long a1, unsigned lo
 	if (getprop(chosen_handle, "stdin", &stdin, sizeof(stdin)) != 4)
 		exit();
 
-	printf("\n\rzImage starting: loaded at 0x%lx\n\r", (unsigned long) _start);
+	printf("\n\rzImage starting: loaded at 0x%p (sp: 0x%p)\n\r", _start, sp);
 
 	/*
 	 * The first available claim_base must be above the end of the
_
