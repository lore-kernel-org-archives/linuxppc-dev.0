Subject: Re: chrp mmu and booting.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Peter Bergner <bergner@vnet.ibm.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040123185433.GB5125@iliana>
References: <20040123111725.GB23537@iliana>
	 <1074883450.2842.9.camel@otta.rchland.ibm.com>
	 <20040123185433.GB5125@iliana>
Content-Type: text/plain
Message-Id: <1074906498.1262.52.camel@gaston>
Mime-Version: 1.0
Date: Sat, 24 Jan 2004 12:08:19 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Yeah, but in my case, i have no yaboot, and i know that these boxes are
> also capable of booting from the OF.
>
> But then, how comes the OF translate call is able to map the address 0
> to the 0x10000 address ?

If you are talking about non-IBM HW, then you can't rely on what happens
on IBM CHRP as a reference :) Any OF implementation does things differently
(and for example, Apple's one runs in virtual mode, not in real mode, thus
the translate call is useful in case you are loaded at a non-1:1 address).

What prom.c is expected to return is at what physical address the kernel
was loaded. If you have MMU off or 1:1 mapping, the reloc "offset" is
usually enough, but if OF have setup some kind of non-1:1 MMU mapping
then you need the translate call.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
