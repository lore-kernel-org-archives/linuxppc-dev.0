Date: Thu, 19 Jul 2001 11:38:49 -0700
From: Matt Porter <mmporter@home.com>
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4.6 kernel on MCP750 board
Message-ID: <20010719113849.A30665@cx258813-a.chnd1.az.home.com>
References: <619D608DD3F0D311882C009027732E1A35320B@ntserver.act.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <619D608DD3F0D311882C009027732E1A35320B@ntserver.act.domain>; from rudolf.ladyzhenskii@act-aus.net on Wed, Jul 18, 2001 at 09:54:41AM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 18, 2001 at 09:54:41AM +1000, Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> I am trying to put the latest kernel on Motorola MCP750 card. 2.2 kernel
> used to work fine, but 2.4.6 have some PCI problems.
> It can not allocate resources to network interface and, as a result, I can
> not boot.
> Startup dump attached.

The PCI subsystem is shooting itself in the foot when it sees a P2P
bridge with I/O and Mem windows disabled.  That's the case when you
plug in a system master (that uses a transparent bridge to cPCI) in
by itself.  A peripheral card in any slot will avoid the issue.

Apply the following patch (current linuxppc_2_4_devel / 2.4.7pre8) to
cure the problem:

===== drivers/pci/pci.c 1.16 vs edited =====
--- 1.16/drivers/pci/pci.c	Wed Jul  4 18:46:09 2001
+++ edited/drivers/pci/pci.c	Thu Jul 19 14:47:38 2001
@@ -957,13 +957,9 @@
 		res->start = base;
 		res->end = limit + 0xfff;
 		res->name = child->name;
-	} else {
-		/*
-		 * Ugh. We don't know enough about this bridge. Just assume
-		 * that it's entirely transparent.
-		 */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 0);
-		child->resource[0] = child->parent->resource[0];
+	} else if (base > limit) {
+		/* Disabled bridge windows get no resources */
+		printk(KERN_DEBUG "PCI: Found disabled bridge I/O window\n");
 	}

 	res = child->resource[1];
@@ -976,10 +972,9 @@
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comment above. Same thing */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 1);
-		child->resource[1] = child->parent->resource[1];
+	} else if (base > limit) {
+		/* Disabled bridge windows get no resources */
+		printk(KERN_DEBUG "PCI: Found disabled bridge memory window\n");
 	}

 	res = child->resource[2];
@@ -1003,10 +998,9 @@
 		res->start = base;
 		res->end = limit + 0xfffff;
 		res->name = child->name;
-	} else {
-		/* See comments above */
-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 2);
-		child->resource[2] = child->parent->resource[2];
+	} else if (base > limit) {
+		/* Disabled bridge windows get no resources */
+		printk(KERN_NOTICE "PCI: Found disabled bridge prefetch window\n");
 	}
 }


--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
