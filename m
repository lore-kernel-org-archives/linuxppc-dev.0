Message-ID: <3CF5A798.3010500@embeddededge.com>
Date: Thu, 30 May 2002 00:16:24 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <3CF35E49.60203@embeddededge.com> <20020529041626.GD16537@zax> <3CF4ED71.4040706@embeddededge.com> <20020530030933.GJ16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> I'm attempting to argue that changing the callers of consistent_sync()
> to use the PCI_DMA_* constants ....

I see.  I think that would be fine as long as we can compile and get
these constants defined without having to enable CONFIG_PCI.  It is
a little weird to include pci header files in drivers that don't use it :-)

> I do want to change the flags to consistent_sync() but only if we
> change it everywhere, including in all the PCI stuff: that requires
> convincing Linus, and probably won't happen at all in 2.4.

But, doesn't that involve adding code to test PCI flags and convert
them to consistent_sync() flags that you didn't want to do?

How about this, we just add another set of flags that are disjoint
from the PCI flags, and just test for both in consistent_sync()?

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
