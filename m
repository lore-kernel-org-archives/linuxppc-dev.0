Subject: Re: chrp mmu and booting.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Bergner <bergner@vnet.ibm.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1074890984.2840.25.camel@otta.rchland.ibm.com>
References: <20040123111725.GB23537@iliana>
	 <1074883450.2842.9.camel@otta.rchland.ibm.com>
	 <20040123185433.GB5125@iliana>
	 <1074890984.2840.25.camel@otta.rchland.ibm.com>
Content-Type: text/plain
Message-Id: <1074906380.814.49.camel@gaston>
Mime-Version: 1.0
Date: Sat, 24 Jan 2004 12:06:21 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-01-24 at 07:49, Peter Bergner wrote:

> In real mode, there is no address mapping done.  When the kernel starts
> executing, we are not loaded where we were linked at, so we must be very
> careful about what we touch.  You'll see in arch/ppc64/kernel/prom.c,
> that we use the RELOC() macro to access global data.  It essentially
> maps the virtual/effective address the kernel expects things to be at
> to the physical address it's actually loaded at.  The ppc32 kernel was
> able to remove the RELOC() macro, but for various reasons, the PPC64
> kernel is still stuck using it.

Yup :( Anton, Paulus and I have been scratching our heads to find
a way to kill it, not as simple as ppc32 but we'll eventually do it :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
