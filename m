Date: Mon, 27 Mar 2000 23:12:54 +0200
From: Martin Mares <mj@ucw.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
Message-ID: <20000327231254.K359@albireo.ucw.cz>
References: <Pine.GSO.4.10.10003220927550.29557-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.10.10003220927550.29557-100000@dandelion.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

>   - There are machine dependent things related to PCI resource assignment,
>     namely PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM in include/asm-ppc/pci.h. On the
>     LongTrail, PCI memory space is from 0xc0000000 until 0xf7000000, so I had
>     to change PCIBIOS_MIN_MEM to make sure allocation starts at 0xc0000000. I
>     think we need
>
> 	#define PCIBIOS_MIN_IO	ppc_md.pcibios_min_io
> 	#define PCIBIOS_MIN_MEM	ppc_md.pcibios_min_mem
>
>     and solve this in the machine specific setup code.
>
>     Martin, do you think it makes sense to have PCIBIOS_MAX_IO and
>     PCIBIOS_MAX_MEM to pass to allocate_resource() as the upper limits?

   Better define resources for the root bus itself and let resources of the
other devices to be allocated from these root resources.

   Also, for the PPC you probably don't need all the multipass resource magic
we do on the PC.

				Have a nice fortnight
--
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Whoa...I did a 'cp /vmlinuz /dev/audio' and I think I heard God..."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
