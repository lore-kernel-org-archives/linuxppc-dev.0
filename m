From: Benjamin Herrenschmidt <bh40@calva.net>
To: <jingai@floatingpenguins.com>
Cc: David Edelsohn <dje@watson.ibm.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Re: Status of PCI-PCI bridge on UMAX S900
Date: Fri, 5 Jan 2001 15:24:33 +0100
Message-Id: <19341130075617.28501@mailhost.mipsys.com>
In-Reply-To: <200101051258.GAA21989@lists.linuxppc.org>
References: <200101051258.GAA21989@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>My guess would be probably, to be thorough.  But I'm no kernel
>expert, so anyone else have any comments?
>
>Although (again just guessing), I don't think many (if any) systems
>will have more than one PCI controller, or more than one bridge
>chip for that matter...

The best solution is probably to cleanup the current parsing mecanism in
prom.c to clearly separate the 3 cases:

 - Real OF with interrupt tree (CHRP, newworld mac booting via OF). This
one is already more or less separate.

 - OldWorld macs (booted either via OF or BootX/miBoot)

 - Newworld macs booted via BootX/miBoot


Only the second case should iterate the AAPL,interrupts parents, and in
this case, all parents should be iterated up to the top of the tree in
case of cascaded bridges. For now, your patch may be enough, I'll look
into cleaning all that up myself. The only "tricky" case is NewWorld macs
booted via BootX/miBoot. Those machine should use the OF interrupt tree.
Unfortunately, MacOS screws it up (we no longer have access to the
phandle's, and so can't follow the interrupt-parent links). So we rely on
other types of infos left by MacOS, but those seem to occasionally be
different on older newworld macs and core99 machines.


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
