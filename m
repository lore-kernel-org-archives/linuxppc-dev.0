Date: Sat, 24 Jan 2004 09:21:29 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Peter Bergner <bergner@vnet.ibm.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: chrp mmu and booting.
Message-ID: <20040124082129.GA13487@iliana>
References: <20040123111725.GB23537@iliana> <1074883450.2842.9.camel@otta.rchland.ibm.com> <20040123185433.GB5125@iliana> <1074906498.1262.52.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074906498.1262.52.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 24, 2004 at 12:08:19PM +1100, Benjamin Herrenschmidt wrote:
>
> > Yeah, but in my case, i have no yaboot, and i know that these boxes are
> > also capable of booting from the OF.
> >
> > But then, how comes the OF translate call is able to map the address 0
> > to the 0x10000 address ?
>
> If you are talking about non-IBM HW, then you can't rely on what happens
> on IBM CHRP as a reference :) Any OF implementation does things differently
> (and for example, Apple's one runs in virtual mode, not in real mode, thus
> the translate call is useful in case you are loaded at a non-1:1 address).

Well, as you know, we were forced on pegasos to force the start
address to 0X10000, since the translate call returned 0. I spoke with
the OF guy, and he said that it is normal that translate would return 0
if you send it 0, which probably means that the translation is just
plain doing nothing, which made me believe that the MMU must be of, or
doing a plain identify translation or something.

I was wondering if this is how it is supposed to be or not, and as i
have access to the OF source code, i wondered if it was something worth
fixing.

> What prom.c is expected to return is at what physical address the kernel
> was loaded. If you have MMU off or 1:1 mapping, the reloc "offset" is
> usually enough, but if OF have setup some kind of non-1:1 MMU mapping
> then you need the translate call.

mmm.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
