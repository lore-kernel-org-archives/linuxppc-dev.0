Message-Id: <200012272312.RAA03294@lists.linuxppc.org>
Date: Wed, 27 Dec 2000 18:12:14 -0500
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
> >bridge code working for the UMAX S900
>
> [...snip...]
>
> I had no time to fix that yet. email me in a couple of weeks, I'll have
> finished moving and my boxes will be back up.

Ok, np.

> Note that it's not similar to the 9500, the 9500 has 2 host bridges while
> you have only one with a PCI<->PCI bridge, the interrupt problem appear
> to be specific to this configuration on an oldworld machine.

Ahh, ok, I was under the impression that the 9500 also had p2p bridge,
didn't know it actually had two host controllers...

> If you want to give it a look by yourself, the code that gets the
> interrupt numbers is in arch/ppc/prom.c. Look at the bits that use the
> "AAPL,interrupt" property and modify it slightly so that when it can't
> find it, it looks for the parent.

Ok, here is where you can call me stupid :)  I just did have a long look
over the code, but bear in mind, this is the first time I've really looked
at any of the PPC-specific code (or much of any of it for that matter).

Here is what I tried, which didn't work, so maybe you could give me
a few more hints:

(this is repeated for every instance)

   ip = (int *) get_property(np, "AAPL,interrupts", &l);
   if (ip == 0)
           ip = (int *) get_property(np, "interrupts", &l);
++ if (ip == 0)
++         ip = (int *) get_property(np, "interrupt-parent", &l);

I also tried:

++ if (ip == 0)
++         ip = (int *) get_property(npi->parent, "AAPL,interrupts", &l);

Forgive me for my ignorance, but as I said, this is my first time even
looking at it :)

TIA for any help,
jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
