From: Benjamin Herrenschmidt <bh40@calva.net>
To: <jingai@telocity.com>, debian-powerpc <debian-powerpc@lists.debian.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900
Date: Wed, 27 Dec 2000 11:06:29 +0100
Message-Id: <19341121033813.21271@192.168.1.2>
In-Reply-To: <j-jvNB.A.O4F.4jrR6@murphy>
References: <j-jvNB.A.O4F.4jrR6@murphy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hello, I am just curious if anyone is working on getting the PCI-PCI
>bridge code working for the UMAX S900 (similar to 9500, but
>obviously different enough to break the code).  The problem is this:
>all cards not in slots 1-2 are assigned an IRQ of 1, which is
>obviously wrong.  I'm not sure why slot 3 does not work, however,
>unless the code just thinks the PCI bridge *is* slot 3 (which it does
>appear to be that way).
>
>If no one is currently attempting to fix it, but someone would like to,
>here is all of the relevant info I can think of.  Thanks in advance for
>any help.

I had no time to fix that yet. email me in a couple of weeks, I'll have
finished moving and my boxes will be back up.

Note that it's not similar to the 9500, the 9500 has 2 host bridges while
you have only one with a PCI<->PCI bridge, the interrupt problem appear
to be specific to this configuration on an oldworld machine.

If you want to give it a look by yourself, the code that gets the
interrupt numbers is in arch/ppc/prom.c. Look at the bits that use the
"AAPL,interrupt" property and modify it slightly so that when it can't
find it, it looks for the parent.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
