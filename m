Date: Thu, 6 Jun 2002 17:52:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Message-ID: <20020606075247.GX2630@zax>
References: <20020606014206.GQ2630@zax> <20020605221542.31000@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020605221542.31000@smtp.wanadoo.fr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 06, 2002 at 12:15:42AM +0200, Benjamin Herrenschmidt wrote:
>
> >flush_instruction_cache() is already an iccci on 4xx (iccci flushes
> >the entire ICU).  flush_dcache_icache() should be fixed though.  We
> >could either replace the entire icache flushing loop with a single
> >iccci, or we could replace each icbi with two icbis, on the address
> >and the address XORed with 0x00001000 (which is the only possible
> >alias with 4kb pages).
>
> Provided that address ^ 0x1000 is mapped or we do that with
> translation off (but then we must get to the physical address
> of the first page).

Blah.  Good point.

> Looks simpler to do an iccci.

Agreed.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
