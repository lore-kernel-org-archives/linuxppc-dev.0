Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AAF411A2C25
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 09:52:15 +1000 (AEST)
Message-ID: <1442274735.6342.1.camel@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc32: memset: only use dcbz once cache is enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: Christophe LEROY <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 sojkam1@fel.cvut.cz, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 15 Sep 2015 09:52:15 +1000
In-Reply-To: <1442247213.2909.71.camel@freescale.com>
References: <20150914062159.353701A2413@localhost.localdomain>
 <1442244054.2909.66.camel@freescale.com> <55F6EB5F.1070203@c-s.fr>
 <1442247213.2909.71.camel@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-14 at 11:13 -0500, Scott Wood wrote:
> On Mon, 2015-09-14 at 17:44 +0200, Christophe LEROY wrote:
> > Le 14/09/2015 17:20, Scott Wood a écrit :
> > > On Mon, 2015-09-14 at 08:21 +0200, Christophe Leroy wrote:
> > > > diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
> > > > index da5847d..68a59d4 100644
> > > > --- a/arch/powerpc/lib/copy_32.S
> > > > +++ b/arch/powerpc/lib/copy_32.S
> > > > @@ -73,8 +73,13 @@ CACHELINE_MASK = (L1_CACHE_BYTES-1)
> > > > @@ -122,6 +127,16 @@ _GLOBAL(memset)
> > > >        bdnz    8b
> > > >        blr
> > > >   
> > > > +/* Simple version of memset used during early boot until cache is 
> > > > enabled
> > > > */
> > > > +simple_memset:
> > > > +     cmplwi  cr0,r5,0
> > > > +     addi    r6,r3,-1
> > > > +     beqlr
> > > > +     mtctr   r5
> > > > +1:   stbu    r4,1(r6)
> > > > +     bdnz    1b
> > > > +     blr
> > > Instead couldn't you use the generic memset at label 2: and patch the "bne
> > > 2f"?
> > 
> > Yes I could but it means adding a global symbol there at the "bne 2f". I 
> > thought it was what Michael didn't like in my v1 of memcpy().
> > What name could I give to that symbol ? Something like 
> > memcpy_nocache_patch: ?
> > What would be the best ? Having b 2f, and replacing it with bne 2f ? Or 
> > have b 2f just above and replace it by nop once cache is up ?
> 
> I'm not sure why a global symbol for an instruction to be patched would be a 
> big deal (similar to kvm_emul.S)...  I thought Michael just wanted existing 
> infrastructure to be used if it's practical to do so.

Yeah, I don't mind adding a global if you need it.

I'm not wedded to either approach, I'm just trying to find the least intrusive
option that uses the most existing code, and is the most maintainable into the
future.

cheers
