Date: Wed, 29 May 2002 12:40:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Recleanups in ocp.h
Message-ID: <20020529024036.GY16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your last batch of OCP changes seems to have reintroduced at least one
thing which I removed, for no readily apparent reason, and introduced
a couple of other silly things:
	- the procdir field of struct ocp_dev is back, but it's still
unused
	- the new dma_mask field is used nowhere
	- you've changed the type of the paddr field to (void *) which
is wrong.  It's a physical address so it should have type
(phys_addr_t)

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h linux-grinch/include/asm-ppc/ocp.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp.h	Wed May 29 12:36:03 2002
+++ linux-grinch/include/asm-ppc/ocp.h	Wed May 29 12:36:57 2002
@@ -117,17 +117,11 @@
 	char name[16];
 	u16 num;
 	enum ocp_type type;	/* OCP device type */
-	void *paddr;
+	phys_addr_t paddr;
 	void *vaddr;
 	u32 flags;
 	struct irq_resources irq_resource[MAX_EMACS][OCP_MAX_IRQS];
 	void *ocpdev;		/* ocp device struct  pointer */
-	u64		dma_mask;	/* Mask of the bits of bus address this
-					   device implements.  Normally this is
-					   0xffffffff.  You only need to change
-					   this if your device has broken DMA
-					   or supports 64-bit transfers.  */
-
 #if defined(CONFIG_PM)
 	u32 current_state;	/* Current operating state. In ACPI-speak,
 				   this is D0-D3, D0 being fully functional,
@@ -139,7 +133,6 @@
 	int (*enable_wake) (u32 state, int enable);	/* Enable wake event */
 #endif
 #if defined(CONFIG_OCP_PROC)
-	struct proc_dir_entry *procdir;	/* dir entry in /proc/bus */
 	struct proc_dir_entry *procent;	/* device entry in /proc/bus/ocp */
 #endif
 };


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
