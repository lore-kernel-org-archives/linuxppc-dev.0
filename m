Message-ID: <3CF4EAE9.1080505@embeddededge.com>
Date: Wed, 29 May 2002 10:51:21 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Armin <akuster@pacbell.net>,
	Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <20020528012516.GE1295@opus.bloom.county> <3CF32B87.4010908@pacbell.net> <20020528065027.GT16537@zax> <3CF3612B.8020102@embeddededge.com> <20020529034854.GC16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Well, actually, dma_cache_wback() and friends still appear to be more
> widely used than consistent_sync().  AFAICT only PPC and ARM use
> consistent_sync().

Just for a historical note.....these functions were implemented about
the same time to support non-PCI USB controllers.  They have found other
uses since then.  Other architectures seem to assume PCI is always present,
and will call the dma_cache_* functions within the pci functions to get
the same effect.  For non-PCI devices, they still call the pci functions
with a null pointer for the pci_dev.  On PPC and ARM we had systems that
wouldn't compile properly with PCI enabled, since there wasn't any PCI
bridge support (even fake ones :-).  We just added the consistent_sync()
to be orthogonal with the other archtecture independent consistent_* functions.
The other architectures are moving this way as they are finding it more
difficult to continue to fake a PCI on systems that really don't have it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
