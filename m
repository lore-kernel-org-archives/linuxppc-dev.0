Message-Id: <200012280405.WAA05948@lists.linuxppc.org>
Date: Wed, 27 Dec 2000 23:05:03 -0500
From: jingai <jingai@floatingpenguins.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: debian-powerpc@lists.debian.org
Subject: Re: Re: Status of PCI-PCI bridge on UMAX S900
Reply-To: jingai@floatingpenguins.com
In-Reply-To: <19341121033813.21271@192.168.1.2>
References: <j-jvNB.A.O4F.4jrR6@murphy> <19341121033813.21271@192.168.1.2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Hello, I am just curious if anyone is working on getting the PCI-PCI
> >bridge code working for the UMAX S900...
>
> If you want to give it a look by yourself, the code that gets the
> interrupt numbers is in arch/ppc/prom.c. Look at the bits that use the
> "AAPL,interrupt" property and modify it slightly so that when it can't
> find it, it looks for the parent.

Ok, I've given it a more thorough looksee, and here is what I have done:

--- prom.c  Wed Dec 27 22:54:42 2000
+++ prom.c.old  Wed Dec 27 22:04:15 2000
@@ -1566,10 +1566,6 @@
    ip = (int *) get_property(np, "AAPL,interrupts", &l);
    if (ip == 0)
        ip = (int *) get_property(np, "interrupts", &l);
-   /* JSL: HACK FOR UMAX S900 PCI-PCI BRIDGE (DECchip 21052)
-    */
-   if (ip == 0 && np->parent != NULL)
-           ip = (int *) get_property(np->parent, "AAPL,interrupts", &l);
    if (ip != 0) {
        np->intrs = (struct interrupt_info *) mem_start;
        np->n_intrs = l / sizeof(int);

I have verified that the code I added is in fact called when it probes the
two
cards in slots 3 and 4; however, *ip == 1 for both cards.  It seems as
though
the IRQ info cannot be retrieved from AAPL,interrupts, or it is just
incorrect.

I did try *manually* setting the IRQs for these cards to 25 and 26, which
as I expected, did not work... (it appears to have the same effect as
when they are set to 1, considering that is also incorrect).

If it might help, the card in slot 4 is my second ethernet card (used for
my LAN -- internal is used for DSL), and it *does* work a little --
here is output from ping:

PING 192.168.1.2 (192.168.1.2): 56 data bytes
64 bytes from 192.168.1.2: icmp_seq=0 ttl=255 time=7648.2 ms
64 bytes from 192.168.1.2: icmp_seq=1 ttl=255 time=6656.9 ms
64 bytes from 192.168.1.2: icmp_seq=2 ttl=255 time=5657.2 ms
64 bytes from 192.168.1.2: icmp_seq=3 ttl=255 time=4654.8 ms
64 bytes from 192.168.1.2: icmp_seq=4 ttl=255 time=3657.5 ms
64 bytes from 192.168.1.2: icmp_seq=5 ttl=255 time=2656.7 ms
64 bytes from 192.168.1.2: icmp_seq=6 ttl=255 time=1657.8 ms
64 bytes from 192.168.1.2: icmp_seq=7 ttl=255 time=657.9 ms

--- 192.168.1.2 ping statistics ---
11 packets transmitted, 8 packets received, 27% packet loss
round-trip min/avg/max = 657.9/4155.8/7648.2 ms

As you might notice, 7648.2ms is pretty bad for a machine in the
next room :)  Not to mention the 27% packet loss..

Anyway, I think I am stepping out of my bounds here now... hopefully
this is enough information for someone to give me some more pointers
on where I should look..

/me really wishes he were a kernel guru right now :)

TIA,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
