Date: Wed, 23 Feb 2000 15:41:21 -0600
From: Grant Erickson <grant@borg.umn.edu>
To: Tom Shaver <tom_shaver@psilongbeach.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC403 bootup problem
In-Reply-To: <NCBBJBFMKKFOJFGDOKNBCEFIDFAA.tom_shaver@psilongbeach.com>
Message-ID: <Pine.SGI.4.21.0002231523580.64196-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 23 Feb 2000, Tom Shaver wrote:
> I am trying to boot my IBM 403 eval board using Grant's 403 kernels. First
> question is, I don't know what eval board it is. It doesn't say "OAK" or
> anything like that on it.

Judging by the output from the PROM output you included, I can't tell if
it's an "Oak" board or not. It looks like your board has four DRAM SIMM
slots, whereas mine only has two. That issue aside, my guess is that the
boards are otherwise identical. The Linux kernel shouldn't much care
either, as long as the devices are located in the same places in physical
address space:

	DRAM:	0x00000000 - DRAM Size
	ROM:	0xFFF00000 - 0xFFFFFFFF
	S2:	0x7E000000 - 0x7E000007
	S1:	0x40000000 - 0x40000007
	ENET:	0xF4000000 - 0xF400003F

> It goes through what looks like a normal startup, does a bootp, loads
> the linux kernel via tftp, tries to boot the kernel, and hangs
> immediately.

It appears to be hanging, but in reality, it's probably not. At present,
there is no serial console support, so once it makes the jump to 0x200000,
text output to your console ceases. But, rest assured, it's probably still
working in silence.

If you had a hardware emulator/debugger (like RISCWatch), you could probe
the memory location at 'log_buf' and see the actual console output sitting
in it's memory buffer.

I'll try to throw Ben Bodley's NS16550A serial console patches up on the
web site later today. The ideal situation would be to get a 403GC[X] SCC
serial console driver going. Someone might well be working on this at
present.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
