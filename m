Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A95A167B53
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 01:08:01 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 29 Aug 2006 17:07:59 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <yf9bqq6p305.fsf@omoikane.mc.pp.se>
Message-ID: <20060829150759.269420@gmx.net>
MIME-Version: 1.0
References: <yf9bqq6p305.fsf@omoikane.mc.pp.se>
Subject: Re: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system
To: Marcus Comstedt <marcus@mc.pp.se>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Marcus,

I guess this message should also be forwarded to linux-usb-devel@lists.sourceforge.net. I hope the developers there can make some comments.

Gerhard

-------- Original-Nachricht --------
Datum: Sun, 27 Aug 2006 18:17:14 +0200
Von: Marcus Comstedt <marcus@mc.pp.se>
An: linuxppc-dev@ozlabs.org
Betreff: [PATCH] EHCI Oops on CONFIG_NOT_COHERENT_CACHE system

> 
> Hello.
> 
> I'm running 2.6.16.27 on an AmigaOneXE, which is a G4 based board
> which has a northbridge (ArticiaS) which does not support cache
> coherency.  Because of this, CONFIG_NOT_COHERENT_CACHE is set.
> 
> The problem I've been having is that the EHCI USB2 host driver causes
> a kernel oops (see attachment) immediately on bootup.
> 
> First, let me outline why this oops happens:
> 
> 1) The EHCI driver uses a structure called "echi_qh", which contains
>    both data to be accessed by the USB hardware through DMA, and
>    private housekeeping data.
> 2) Since part of the structure is for DMA, instances of the structre
>    are allocated with dma_pool_alloc().
> 3) Pages allocated with dma_pool_alloc() are cache-inhibited on this
>    system, due to the lack of cache coherency support.
> 4) The private data in this structure included a struct kref, which in
>    turn contains an atomic_t.
> 5) Incrementing and decrementing an atom_t, and thereby a kref, is
>    done with lwarx/stwcx.
> 6) lwarx on a cache-inhibited address is not allowed on G4 (generates
>    a DSI).
> 
> Now, the problem is deciding in which of these steps the actual error
> lies, since none of these facts (apart from #6) is set in stone.  In
> my opinion though, it makes sense to simply say that atomic_t:s (and
> therefore kref:s) are not supported in DMA memory.  This would place
> the error in the EHCI driver, with two possible solutions:
> 
> A) Rewrite qh_get() and qh_put() to use something else than
>    kref_get()/kref_put().  Simply using non-atomic increment and
>    decrement made the Oops go away, but as I don't know the design
>    decision behind using a struct kref, I can't say that atomicity
>    isn't needed, so such a simple fix might lead to race conditions.
> 
> B) Break struct ehci_qh into two parts, one allcated with
>    dma_pool_alloc() and one allocated with kmalloc(), where the fields
>    accessed by the hardware is put into the former, and the driver
>    private data (which includes the kref) in the latter.  Safe and no
>    major performance hit (just one level of indirection added in some
>    places, and using cache-enabled memory for the internal data might
>    actually improve performance), but the change touches a rather
>    large amount of lines (patch attached).
> 
> C) Basically the same as B, but only the kref (and a pointer back to
>    the rest of the data, so that qh_destroy can find it) is moved to
>    the kmalloced part.  This means only ehci_qh_alloc(), qh_get() and
>    qh_put() need to be changed, so the changeset is much smaller.  I
>    don't have a patch ready for this, but I can make one on request.
> 
> A completely different approach would be
> 
> D) Make the DSI exception handler emulate lwarx on cache-inhibited
>    pages.
> 
> This seems like a more complex fix though, and I'm sure the
> performance would be pretty lousy (although only NOT_COHERENT_CACHE
> systems would be affected of course).
> 
> So, what do you guys think?  Which is the best way to rectify the
> situation?  (Apart from changing to a better northbrige, which I don't
> see happening, realistically.  :-/ )
> 
> 
>   // Marcus
> 
-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
