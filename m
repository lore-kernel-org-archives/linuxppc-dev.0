Date: Thu, 4 Apr 2002 13:48:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Workaround for USB DMA bugs
Message-ID: <20020404034809.GL21034@zax>
References: <20020403024321.GN1026@zax> <3CAB3F0B.8080700@embeddededge.com> <20020403234051.GG21034@zax> <3CABC065.6050107@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CABC065.6050107@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 03, 2002 at 09:54:29PM -0500, Dan Malek wrote:
>
> David Gibson wrote:
>
>
> >It's becoming easier though, with the __cacheline_aligned macro.  Plus
> >I think if the buffer is individually kmalloc()ed it will be properly
> >aligned.
>
> Alignment is only half the problem.  You have to ensure the object is
> modulo cache line size as well.  You can't be sharing cache lines subject
> to DMA with other DMA or processor core data.

Oh, right, yes.  That was actually what I was meaning when I said
"aligned" (sort of aligned at both ends), forgetting that the normal
meaning only applies to the start address.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
