Message-Id: <200012291509.eBTF9qZ11058@ginger.cmf.nrl.navy.mil>
To: jingai@floatingpenguins.com
cc: "debian-powerpc" <debian-powerpc@lists.debian.org>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900 
In-reply-to: Your message of "Thu, 28 Dec 2000 19:16:41 EST."
             <200012290016.SAA25126@lists.linuxppc.org>
Date: Fri, 29 Dec 2000 10:09:51 -0500
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <200012290016.SAA25126@lists.linuxppc.org>,jingai writes:
>Doh!  I didn't even think to check if the second get_property() call
>was returning > 0.. this fixes it!  Thanks bunches for spotting that!

it seems like someone was confused about the meaning of the 'interrupts'
property when they wrote prom.c.  its basically the number of interrupts
supported by this pci device.  interpret_dbdma_props() also has the
same confusion, so the following would be a more complete patch to
prom.c.  note that it checks to see if a pci node has an interrupt
property before assigning one, otherwise devices on the far side of
a pci bridge (that shares interrupts) would be assigned interrupts
when they dont need them.


--- prom.c.000	Thu Dec 28 08:43:12 2000
+++ prom.c	Fri Dec 29 10:05:54 2000
@@ -1562,9 +1562,12 @@
 		return mem_start;
 	}

+	if ((ip = (int *) get_property(np, "interrupts", &l)) == 0)
+		return mem_start;
+
 	ip = (int *) get_property(np, "AAPL,interrupts", &l);
-	if (ip == 0)
-		ip = (int *) get_property(np, "interrupts", &l);
+	if (ip == 0 && np->parent != NULL)
+		ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
 	if (ip != 0) {
 		np->intrs = (struct interrupt_info *) mem_start;
 		np->n_intrs = l / sizeof(int);
@@ -1615,9 +1618,12 @@
 	if (use_of_interrupt_tree)
 		return mem_start;

+	if ((ip = (int *) get_property(np, "interrupts", &l)) == 0)
+		return mem_start;
+
 	ip = (int *) get_property(np, "AAPL,interrupts", &l);
-	if (ip == 0)
-		ip = (int *) get_property(np, "interrupts", &l);
+	if (ip == 0 && np->parent != NULL)
+		ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
 	if (ip != 0) {
 		np->intrs = (struct interrupt_info *) mem_start;
 		np->n_intrs = l / sizeof(int);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
