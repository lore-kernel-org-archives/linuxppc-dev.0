Subject: Re: Vga on sandpoint
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: maurie <maurie@risc.sps.mot.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <000a01c38ce9$4c8ec740$9b7c520a@sps.mot.com>
References: <000a01c38ce9$4c8ec740$9b7c520a@sps.mot.com>
Content-Type: text/plain
Message-Id: <1065561997.31018.54.camel@gaston>
Mime-Version: 1.0
Date: Tue, 07 Oct 2003 23:28:03 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2003-10-07 at 17:40, maurie wrote:
> Linuxppc developers,
>
> 	I am attempting to get pci vga working on the sandpoint platform
> using dink32 to start linux.  I have tried several S3 cards with no video
> success.  The kernel has vga driver support for SIS and ATI support, but
> these are classified as experimental and will not compile, undefined
> externals for __floatsidf, __divdf3, __adddf3, __fixunsdfsi, __muldf3, and
> __vmalloc.

What kernel is this exactly ? Those symbols seem to imply something
is trying to do floating point in the kernel, which is totally
forbidden. Most video cards need to be soft-booted (POSTed) some way
before a kernel driver can use them. This require some firmware support,
typically an x86 BIOS emulator, do you have that in dink32 ? Some
fbdev's, afaik, can run a card booted from scratch (I think Matroxfb
with earlier cards and some clgen but I don't know the details).

Regarding __vmalloc, that should be defined (and exported) by the
core kernel.

Now, regarding he availability of the VGA space, that depends how
your host bridge is configured, do you have a pass-through window
to legacy VGA addresses on the PCI ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
