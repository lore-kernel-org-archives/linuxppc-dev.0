From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Ethan Benson" <erbenson@alaska.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: install with Debian CD ok, but can't boot any kernel
Date: Sat, 19 Oct 2002 00:55:28 +0200
Message-Id: <20021018225528.25177@192.168.4.1>
In-Reply-To: <20021018185053.GU27982@plato.local.lan>
References: <20021018185053.GU27982@plato.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>why do that, just boot yaboot manually if thats what happened.
>
>its already there.

Ok, I'm not sure what happened to him exactly, it may well
be a video problem in which case your suggestion of using
ofonly video is correct.

>if someone would send me device-trees for this model i could fix
>ofpath.

I'll get one rsn. Note that in order to make that better, I've
just added to my tree a proc entry for ide-pmac. It appears
under /proc/ide/pmac, and shows, for each interface driven by
this driver, the full OF path (among others). I still need to
do something for PCI based controllers (like Promise) though.

An example of output on my tipb:

ide0 (KeyLargo ATA-4)
  of_path  : /pci@f2000000/mac-io@17/ata-4@1f000
  bus-id   : 2
  cable    : 80 connector
ide1 (KeyLargo ATA-3)
  of_path  : /pci@f2000000/mac-io@17/ata-3@20000
  bus-id   : 0
  cable    : 40 connector
ide2 (KeyLargo ATA-3)
  of_path  : /pci@f2000000/mac-io@17/ata-3@21000
  bus-id   : 1
  cable    : 40 connector

(the algorithm to go from hdX to ideY is basically
(X - 'a') / 2, then remainder beeing the OF unit number
(0 for master, 1 for slave).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
