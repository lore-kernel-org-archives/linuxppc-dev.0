Date: Thu, 12 Sep 2002 07:51:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Todd Poynor <tpoynor@mvista.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: consistent_free re-revisited
Message-ID: <20020912145146.GD13840@opus.bloom.county>
References: <20020912142945.GC13840@opus.bloom.county> <20020912072315.5346@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020912072315.5346@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 12, 2002 at 09:23:15AM +0200, Benjamin Herrenschmidt wrote:
> >> That's the least of our worries - the current consistent_alloc() is
> >> badly broken.  It breaks the DMA-mapping.txt rules, because it can't
> >> safely be called from interrupt context.  I think we need generic
> >> changes (gfp masks to various functions) to fix this sanely.
> >
> >IIRC, to fix the interrupt context bit, we need something like the
> >following, which was Paul's idea, and he said he would talk to Dave M.
> >about it.  Did anything ever happen there?
>
> I tend to hate anything that relies on in_interrupt() as they
> are other contexts that will have in_interrupt() cleared but still
> have the same limitations. Typically, anything on the VM path must
> do either GFP_ATOMIC or GFP_NOIO allocations, wether it's running
> at interrupt time or not.

The problem is that the atomic pool is limited, iirc.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
