Message-ID: <3CF4FB77.3010203@mvista.com>
Date: Wed, 29 May 2002 09:01:59 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <3CF35E49.60203@embeddededge.com> <20020529041626.GD16537@zax> <3CF4ED71.4040706@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> We can't change the PCI names, so I just suggested we change the names to
> consistent_sync(), define those in io.h (so non-PCI systems don't have to
> include pci header files just to get a flag name), and put a big comment
> around the flag definitions that they have to match the PCI_ names.

Why not put the flag definition in a /linux/dma.h and include that in
/linux/pci.h.  Have the pci flags be defined as the ones in dma.h.  That
way it's obvious where the orginal defines are and easier to maintain. :)


dma.h
/* This defines the direction arg to the DMA mapping routines. */
#define DMA_BIDIRECTIONAL	0
#define DMA_TODEVICE		1
#define DMA_FROMDEVICE		2
#define DMA_NONE		3

pci.h
/* This defines are defined in linux/dma.h */
#define PCI_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
#define PCI_DMA_TODEVICE	DMA_TODEVICE
#define PCI_DMA_FROMDEVICE	DMA_FROMDEVICE
#define PCI_DMA_NONE		DMA_NONE


>
>
>     -- Dan
>
>
>
>
Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
