Message-Id: <200101042226.f04MQ6Z20543@ginger.cmf.nrl.navy.mil>
To: Tibor Pausz <pausz@stud.uni-frankfurt.de>
cc: jingai <jingai@floatingpenguins.com>,
        debian-powerpc <debian-powerpc@lists.debian.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900 
In-reply-to: Your message of "Thu, 04 Jan 2001 20:19:39 +0100."
             <19341129125123.15815@mail.server.uni-frankfurt.de>
Date: Thu, 04 Jan 2001 17:26:06 -0500
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <19341129125123.15815@mail.server.uni-frankfurt.de>,Tibor Pausz writ
es:
>Today I tried your patch. Well, I breaks the hole interrupt stuff.
>Now, even Mesh has trouble with interrupts (kernel crash), the
>console=ttyS0 doesn't work so no output from the booting ...

i was wrong about the checking for the interrupts property before
allocating an interrupt. the correct patch follows:

--- prom.c.000	Thu Dec 28 08:43:12 2000
+++ prom.c	Tue Jan  2 09:18:53 2001
@@ -1563,8 +1563,8 @@
 	}

 	ip = (int *) get_property(np, "AAPL,interrupts", &l);
-	if (ip == 0)
-		ip = (int *) get_property(np, "interrupts", &l);
+	if (ip == 0 && np->parent != NULL)
+		ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
 	if (ip != 0) {
 		np->intrs = (struct interrupt_info *) mem_start;
 		np->n_intrs = l / sizeof(int);
@@ -1616,8 +1616,8 @@
 		return mem_start;

 	ip = (int *) get_property(np, "AAPL,interrupts", &l);
-	if (ip == 0)
-		ip = (int *) get_property(np, "interrupts", &l);
+	if (ip == 0 && np->parent != NULL)
+		ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
 	if (ip != 0) {
 		np->intrs = (struct interrupt_info *) mem_start;
 		np->n_intrs = l / sizeof(int);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
