Date: Tue, 29 Jun 2004 22:42:30 +0200
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pegasos 2 support patch ...
Message-ID: <20040629204230.GA15900@pegasos>
References: <20040629165029.GA13468@pegasos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <20040629165029.GA13468@pegasos>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Tue, Jun 29, 2004 at 06:50:29PM +0200, Sven Luther wrote:
> The pegasos1 support is not complete, but i believe this is due to some
> brokeness in the OF. The main problem being that the translate function
> is broken, and altough phys has the right value (0x00010000) before
> calling it, it is 0 afterwards. I suppose the initial value is taken
> from &_stext, so it should be feasible to detect that this is the
> correct value before calling the translate OF method, or fixing it if we
> detect a Pegasos 1 with the model OF property. Comments on this would
> also be welcome. There may be some interrupt level thing left on pegasos
> 1 also, but i would need to check that.

Well, the pegasos 1 seems to start with mmu enabled, but with BATs
mapped 1:1. There is not much we can do unless we fix the translate
method, i think. The attached patch tests if the machine is a pegasos 1
(but not 2) and sets the phys to 0x00010000 if this is the case.

Another solution would be to test before doing the translate call, maybe
this would be more elegant ?

Friendly,

Sven Luther

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="pegasos1.diff"

diff -urN kernel-source-2.6.7.orig/arch/ppc/syslib/prom_init.c kernel-source-2.6.7.peg2/arch/ppc/syslib/prom_init.c
--- kernel-source-2.6.7.orig/arch/ppc/syslib/prom_init.c	2004-06-16 07:20:24.000000000 +0200
+++ kernel-source-2.6.7.peg2/arch/ppc/syslib/prom_init.c	2004-06-29 21:07:04.491319912 +0200
@@ -794,6 +794,9 @@
 	char *p, *d;
  	unsigned long phys;
 	void *result[3];
+	char model[32];
+	phandle node;
+	int rc;

  	/* Default */
  	phys = (unsigned long) &_stext;
@@ -880,6 +883,11 @@
 	for (i = 0; i < prom_num_displays; ++i)
 		prom_display_paths[i] = PTRUNRELOC(prom_display_paths[i]);

+	/* Pegasos 1 has a broken translate method in the OF, fix it */
+	node = call_prom("finddevice", 1, 1, "/");
+	rc = call_prom("getprop", 4, 1, node, "model", model, sizeof(model));
+	if (rc > 0 && !strncmp (model, "Pegasos", 7) && strncmp (model, "Pegasos2", 8)) phys = 0x00010000;
+
 	prom_print("returning 0x");
 	prom_print_hex(phys);
 	prom_print("from prom_init\n");

--gBBFr7Ir9EOA20Yy--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
