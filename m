Date: Thu, 4 Apr 2002 16:30:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020404063051.GP21034@zax>
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com> <20020403234051.GG21034@zax> <3CABC065.6050107@embeddededge.com> <20020404034809.GL21034@zax> <3CABD1E0.7020008@embeddededge.com> <20020404052349.GN21034@zax> <3CABEDE9.5020404@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CABEDE9.5020404@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 04, 2002 at 01:08:41AM -0500, Dan Malek wrote:
>
> David Gibson wrote:
>
> >Possibly a better approach would be to make the consistent_sync()
> >function be more careful and flush rather than invalidate cachelines
>
> That's basically what this patch does, with the overhead of always
> writing instead of just invalidating.  We just went the whole circle
> here, as this isn't a logically correct solution :-).

No, it's not, but:

a) It reduces the impact of DMA bugs - this way code which fails to
properly align its DMA buffers runs the risk of corrupting its DMA
transfers, but it won't corrupt other random data structures.  In
particular DMA buffers on the stack won't cause evil stack corruption
which is a complete PITA to debug (I spent a full day of extreme
frustration tracking this one down).

b) It means that consistent_sync() itself has a safe interface - it
won't damage data outside the region specified.  Which means it can be
used by code which does use non-aligned DMA buffers safely -
i.e. where it knows the surrounding memory won't be touched near the
transfer itself (between the consistent_sync() and the completion of
DMA).  That could have an application in a driver which allocated a
bunch of DMA buffers each with some attached bookeeping information.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
