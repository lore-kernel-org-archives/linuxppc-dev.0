Subject: Re: chrp mmu and booting.
From: Peter Bergner <bergner@vnet.ibm.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040123185433.GB5125@iliana>
References: <20040123111725.GB23537@iliana>
	 <1074883450.2842.9.camel@otta.rchland.ibm.com>
	 <20040123185433.GB5125@iliana>
Content-Type: text/plain
Message-Id: <1074890984.2840.25.camel@otta.rchland.ibm.com>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 14:49:44 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-01-23 at 12:54, Sven Luther wrote:
> Yeah, but in my case, i have no yaboot, and i know that these boxes are
> also capable of booting from the OF.

Yes, you can boot any 32-bit ELF binary from OF.  Yaboot and the zImage
wrapper for the 64-bit kernel are both 32-bit ELF binaries, so you can
boot either of these.  Note that you cannot boot a plain PPC64 vmlinux,
as the OF ELF loader doesn't support 64-bit ELF binaries.


> But then, how comes the OF translate call is able to map the address 0
> to the 0x10000 address ?

In real mode, there is no address mapping done.  When the kernel starts
executing, we are not loaded where we were linked at, so we must be very
careful about what we touch.  You'll see in arch/ppc64/kernel/prom.c,
that we use the RELOC() macro to access global data.  It essentially
maps the virtual/effective address the kernel expects things to be at
to the physical address it's actually loaded at.  The ppc32 kernel was
able to remove the RELOC() macro, but for various reasons, the PPC64
kernel is still stuck using it.


Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
