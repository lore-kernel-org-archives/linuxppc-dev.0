Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 680FA2C0312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:34:03 +1000 (EST)
Message-ID: <1342150420.15597.12.camel@pasglop>
Subject: Re: [PATCH v4] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Fri, 13 Jul 2012 13:33:40 +1000
In-Reply-To: <20120712224556.GA9730@bloggs.ozlabs.ibm.com>
References: <1341499295-10795-1-git-send-email-stuart.yoder@freescale.com>
 <20120712224556.GA9730@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, linuxppc-dev@lists.ozlabs.org,
 Stuart Yoder <stuart.yoder@freescale.com>, agraf@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-07-13 at 08:45 +1000, Paul Mackerras wrote:
> On Thu, Jul 05, 2012 at 09:41:35AM -0500, Stuart Yoder wrote:
> 
> > diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> > index ba3aeb4..bad42e3 100644
> > --- a/arch/powerpc/kernel/entry_32.S
> > +++ b/arch/powerpc/kernel/entry_32.S
> > @@ -92,7 +92,7 @@ crit_transfer_to_handler:
> >  	mfspr	r8,SPRN_SPRG_THREAD
> >  	lwz	r0,KSP_LIMIT(r8)
> >  	stw	r0,SAVED_KSP_LIMIT(r11)
> > -	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
> > +	CURRENT_THREAD_INFO(r0, r1)
> >  	stw	r0,KSP_LIMIT(r8)
> >  	/* fall through */
> >  #endif
> > @@ -112,7 +112,7 @@ crit_transfer_to_handler:
> >  	mfspr	r8,SPRN_SPRG_THREAD
> >  	lwz	r0,KSP_LIMIT(r8)
> >  	stw	r0,saved_ksp_limit@l(0)
> > -	rlwimi	r0,r1,0,0,(31-THREAD_SHIFT)
> > +	CURRENT_THREAD_INFO(r0, r1)
> >  	stw	r0,KSP_LIMIT(r8)
> >  	/* fall through */
> >  #endif
> 
> Do you really mean to replace a rlwimi with a rlwinm?  If so, is that
> because the rlwinm is a bug fix, or is it because you know something
> special about KSP_LIMIT(r8) which means that rlwinm and rlwimi are
> equivalent here?

Ah that's an interesting one I hadn't spotted when reviewing. Both
variants (rlwimi and rlwinm)  will effectively replace the top bits of
KSP_LIMIT, switching it to the current stack.

The difference is that the original one (rlwimi) will preserve the
bottom bits.

Now, do we want those bottom bits ? It looks like we do if we want to
make the thread_info at the bottom of the stack as "out of bounds".

So the patch breaks that. It will not generally break a working kernel
but the stack overflow detection may not trigger if the overflow is just
enough to override the thread infos.

Stuart, I already applied v4 of the patch to powerpc-next and I'd rather
not rebase it, can you send a fixup patch please, one that will
effecticely revert those two hunks, we can leave that open coded. While
at it, please add a comment explaining what the code does to avoid
similar confusion in the future.

Cheers,
Ben.
