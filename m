From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: PReP and generic PCI resource assignment
Date: Fri, 10 Aug 2001 11:56:59 +0200
Message-Id: <20010810095659.6588@smtp.adsl.oleane.com>
In-Reply-To: <Pine.LNX.4.05.10108101034110.2083-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10108101034110.2083-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>You should initialize the parent pointers in the PCI bus structure with
>pointers to resources containing the correct region.
>
>I once hardcoded the parents for the LongTrail, but that code is gone. Now it
>tries to set up the parents from information in the OF device, which works
>more or less. There are (or were, read as in `were the last time I tried
it, a
>few months ago) still some problems, though. One of them is that the
hardcoded
>ISA motherboard resources (i8259 and legacy stuff) are requested before PCI
>resources are done, and that the PCI bus parent resources were not requested
>and thus don't appear in the full resource tree.

Parent pointer should be set properly nowadays on bk _2_4_devel at least.

However, the generic PCI code still wants to add that PCIBIOS_MIN_MEM
value when assigning resources, I bet we should probably #define that
to 0 on PPC.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
