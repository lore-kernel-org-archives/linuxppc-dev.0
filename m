Subject: Re: chrp mmu and booting.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Peter Bergner <bergner@vnet.ibm.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040124082129.GA13487@iliana>
References: <20040123111725.GB23537@iliana>
	 <1074883450.2842.9.camel@otta.rchland.ibm.com>
	 <20040123185433.GB5125@iliana> <1074906498.1262.52.camel@gaston>
	 <20040124082129.GA13487@iliana>
Content-Type: text/plain
Message-Id: <1074944186.814.90.camel@gaston>
Mime-Version: 1.0
Date: Sat, 24 Jan 2004 22:36:27 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Well, as you know, we were forced on pegasos to force the start
> address to 0X10000, since the translate call returned 0. I spoke with
> the OF guy, and he said that it is normal that translate would return 0
> if you send it 0, which probably means that the translation is just
> plain doing nothing, which made me believe that the MMU must be of, or
> doing a plain identify translation or something.

I have to dbl check the code, we should translate our current offset
actually, not 0. (To get your current offset, bl <something>, then
mflr r3; blr)

> I was wondering if this is how it is supposed to be or not, and as i
> have access to the OF source code, i wondered if it was something worth
> fixing.
>
> > What prom.c is expected to return is at what physical address the kernel
> > was loaded. If you have MMU off or 1:1 mapping, the reloc "offset" is
> > usually enough, but if OF have setup some kind of non-1:1 MMU mapping
> > then you need the translate call.
>
> mmm.
>
> Friendly,
>
> Sven Luther
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
