Date: Thu, 6 Jun 2002 11:42:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@kernel.crashing.org
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Message-ID: <20020606014206.GQ2630@zax>
References: <20020605032241.GD2630@zax> <20020604193130.2384@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020604193130.2384@mailhost.mipsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 04, 2002 at 09:31:30PM +0200, Benjamin Herrenschmidt wrote:
>
> >I've committed a patch to use 'sync' before changing the PID (to flush
> >any loads/stores through the MMU before we change the context) and
> >'isync' afterwards to flush the shadow TLBs.  I'm guessing that isync
> >flushes both shadow TLBs, not just the ITLB, and that the missing
> >infomation is a documentation error.  I've sent some email to the IBM
> >PPC support people to check.
>
> Sounds good. In my local tree, I also replaced the icbi's in
> flush_dcache_icache & flush_instruction_cache with iccci's to
> make sure we don't have stale aliases. I haven't yet checked
> glibc for this though.

I heard back from the PPCSUPP people, and apparently isync (or any
context sychronising instruction) does the right thing and flushes the
shadow DTLB.

flush_instruction_cache() is already an iccci on 4xx (iccci flushes
the entire ICU).  flush_dcache_icache() should be fixed though.  We
could either replace the entire icache flushing loop with a single
iccci, or we could replace each icbi with two icbis, on the address
and the address XORed with 0x00001000 (which is the only possible
alias with 4kb pages).

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
