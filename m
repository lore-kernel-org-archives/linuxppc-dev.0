From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Date: Thu, 6 Jun 2002 00:15:42 +0200
Message-Id: <20020605221542.31000@smtp.wanadoo.fr>
In-Reply-To: <20020606014206.GQ2630@zax>
References: <20020606014206.GQ2630@zax>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>flush_instruction_cache() is already an iccci on 4xx (iccci flushes
>the entire ICU).  flush_dcache_icache() should be fixed though.  We
>could either replace the entire icache flushing loop with a single
>iccci, or we could replace each icbi with two icbis, on the address
>and the address XORed with 0x00001000 (which is the only possible
>alias with 4kb pages).

Provided that address ^ 0x1000 is mapped or we do that with
translation off (but then we must get to the physical address
of the first page).

Looks simpler to do an iccci.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
