Message-ID: <3CF35E49.60203@embeddededge.com>
Date: Tue, 28 May 2002 06:39:05 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:



> Changing consistent_sync() to use its own constants isn't completely
> trivial, because asm/pci.h calls consistent_sync() with the constants
> passed as arguments to pci_map_single() et al, ....

The constent_sync() is not unique to 4xx and it absolutely must not
be required to use pci headers/functions for it to work properly.
These lower level functions are common to other platforms, other drivers
will call consistent_* functions directly, and in some cases the platforms
or drivers that use these functions will not require (nor compile correctly)
if PCI is enabled.  Unfortunately, making some of these drivers work without
PCI defined was the great challenge, so changing these constant the time I
put these functions into PowerPC was the least of the problem :-)


On a slightly different topic, are we getting a little carried away with
our "inline" functions?  What do we gain by having these complex functions
in asm/pci.h where clearly the overhead of a function call is insignficant
compared to the work done in the function?  I just noticed that other arches
have collected these functions into C files.


> .....  So, to decouple the consistent_sync() constants from
> the PCI direction constants we would have to put a switch in every
> time consistent_sync() is used in asm/pci.h.

Just define them so they have the same value as their PCI counterparts.

> ... In io.h along with the prototype for
> consistent_sync() would be a better idea.

Yes, thank you :-)


> ..... But that
> means convincing Linus, of course.

...and convincing the world there is something other than x86/PCI/consistent
systems that run Linux.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
