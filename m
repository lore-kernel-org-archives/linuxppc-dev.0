Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD6021A08EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:46:13 +1100 (AEDT)
Date: Mon, 22 Feb 2016 09:36:16 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 7/9] powerpc/mm/book3s-64: Shuffle read, write,
 execute and user bits in PTE
Message-ID: <20160221223616.GB30309@fergus.ozlabs.ibm.com>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
 <1455948760-24710-8-git-send-email-paulus@samba.org>
 <87si0m7c5t.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87si0m7c5t.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 21, 2016 at 01:00:54PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > This moves the _PAGE_EXEC, _PAGE_RW and _PAGE_USER bits around in
> > the Linux PTE on 64-bit Book 3S systems to correspond with the bit
> > positions used in radix mode by PowerISA v3.0 CPUs.  This also adds
> > a _PAGE_READ bit corresponding to the read permission bit in the
> > radix PTE.  _PAGE_READ is currently unused but could possibly be used
> > in future to improve pte_protnone().
> >
> > Signed-off-by: Paul Mackerras <paulus@samba.org>
> > ---
> >  arch/powerpc/include/asm/book3s/64/hash.h | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> > index c8eba0e..0fc750c 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> > @@ -13,9 +13,12 @@
> >   * We could create separate kernel read-only if we used the 3 PP bits
> >   * combinations that newer processors provide but we currently don't.
> >   */
> > -#define _PAGE_BIT_SWAP_TYPE	2
> > -#define _PAGE_USER		0x00004 /* page may be accessed by userspace */
> > -#define _PAGE_EXEC		0x00008 /* execute permission */
> > +#define _PAGE_BIT_SWAP_TYPE	0
> > +
> > +#define _PAGE_EXEC		0x00001 /* execute permission */
> > +#define _PAGE_RW		0x00002 /* read & write access allowed */
> > +#define _PAGE_READ		0x00004	/* read access allowed */
> > +#define _PAGE_USER		0x00008 /* page may be accessed by userspace */
> >  #define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
> >  /* M (memory coherence) is always set in the HPTE, so we don't need it here */
> >  #define _PAGE_COHERENT		0x0
> > @@ -23,7 +26,6 @@
> >  #define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
> >  #define _PAGE_DIRTY		0x00080 /* C: page changed */
> >  #define _PAGE_ACCESSED		0x00100 /* R: page referenced */
> > -#define _PAGE_RW		0x00200 /* software: user write access allowed */
> >  #define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
> >  #define _PAGE_SPECIAL		0x10000 /* software: special page */
> >
> 
> 
> For radix, _PAGE_USER is the inverse of this right ?. Ie, we set that
> bit position to 1 to indicate privileged access only.

Right, we'll need a follow-on patch that changes this to a _PAGE_PRIV
bit and changes the logic that uses _PAGE_USER either that or a
_PAGE_PRIV bit.  But at least we have the bit position reserved now.

> Also can you use constants like
> #define _PAGE_USER PPC_BIT(60)

I'd really rather not - that is harder for the casual reader to parse,
because they then have to go off and find out what exactly PPC_BIT
does.  The only time that using PPC_BIT would help is when checking
that the bit definitions match the Power ISA, and that's presumably
done by intelligent people that can handle backwards bit numbering in
their heads. :)

Paul.
