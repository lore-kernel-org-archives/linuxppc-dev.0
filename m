Message-Id: <200101042248.QAA10042@lists.linuxppc.org>
Date: Thu, 04 Jan 2001 17:48:30 -0500
From: jingai <jingai@floatingpenguins.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Re: Status of PCI-PCI bridge on UMAX S900
Reply-To: jingai@floatingpenguins.com
In-Reply-To: <19341129141248.27470@mailhost.mipsys.com>
References: <19341129125123.15815@mail.server.uni-frankfurt.de> <19341129141248.27470@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The "interrupts" property can have various meanings depending on the OF
> version, I suggest you don't mess with it. Just check that if you find no
> AAPL,interrupts, and that pmac_newworld == 0, then look for parent
> AAPL,interrupts.

So, then does the following patch seem valid?  If so, I'd appreciate it if
others with different macs (newworld and oldworld) could try it and let
me know if it breaks anything...

..and if not, how would one go about getting this into the official trees?


--- prom.c.old  Wed Jan  3 20:31:59 2001
+++ prom.c      Thu Jan  4 17:44:02 2001
@@ -1564,8 +1564,15 @@
        }

        ip = (int *) get_property(np, "AAPL,interrupts", &l);
-       if (ip == 0)
+       if (ip == 0) {
+           /* hack to force a look at the parent node for interrupts on
+            * oldworld macs with funky PCI<->PCI bridges (ie, UMAX S900)
+            */
+           if (!pmac_newworld && np->parent != NULL)
+               ip = (int *) get_property(np->parent, "AAPL,interrupts",
&l);
+           else
                ip = (int *) get_property(np, "interrupts", &l);
+       }
        if (ip != 0) {
                np->intrs = (struct interrupt_info *) mem_start;
                np->n_intrs = l / sizeof(int);
@@ -1617,8 +1624,15 @@
                return mem_start;

        ip = (int *) get_property(np, "AAPL,interrupts", &l);
-       if (ip == 0)
+       if (ip == 0) {
+           /* hack to force a look at the parent node for interrupts on
+            * oldworld macs with funky PCI<->PCI bridges (ie, UMAX S900)
+            */
+           if (!pmac_newworld && np->parent != NULL)
+               ip = (int *) get_property(np->parent, "AAPL,interrupts",
&l);
+           else
                ip = (int *) get_property(np, "interrupts", &l);
+       }
        if (ip != 0) {
                np->intrs = (struct interrupt_info *) mem_start;
                np->n_intrs = l / sizeof(int);
@@ -1774,8 +1788,15 @@
                return mem_start;

        ip = (int *) get_property(np, "AAPL,interrupts", &l);
-       if (ip == 0)
+       if (ip == 0) {
+           /* hack to force a look at the parent node for interrupts on
+            * oldworld macs with funky PCI<->PCI bridges (ie, UMAX S900)
+            */
+           if (!pmac_newworld && np->parent != NULL)
+               ip = (int *) get_property(np->parent, "AAPL,interrupts",
&l);
+           else
                ip = (int *) get_property(np, "interrupts", &l);
+       }
        if (ip != 0) {
                np->intrs = (struct interrupt_info *) mem_start;
                np->n_intrs = l / sizeof(int);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
