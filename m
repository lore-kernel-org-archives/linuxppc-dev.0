Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 19230B7BB3
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Sep 2009 18:43:22 +1000 (EST)
In-Reply-To: <1253847827.7103.504.camel@pasglop>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>	<1253843480.7103.492.camel@pasglop>
	<1253847827.7103.504.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache	coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF028339A2.3A7A8D6F-ONC125763C.002DE73B-C125763C.002ECF90@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 25 Sep 2009 10:31:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
>
> > I think there's more finishyness to 8xx than we thought. IE. That
> > tlbil_va might have more reasons to be there than what the comment
> > seems to advertize. Can you try to move it even higher up ? IE.
> > Unconditionally at the beginning of set_pte_filter ?
> >
> > Also, if that doesn't help, can you try putting one in
> > set_access_flags_filter() just below ?
>
> Ok, I got a refresher on the whole concept of "unpopulated TLB entries"
> on 8xx, and that's damn scary. I think what mislead me initially is that
> the comment around the workaround is simply not properly describing the
> extent of the problem :-)
>
> So I'm not going to make the 8xx TLB miss code sane, that's beyond what
> I'm prepare to do with it, but I suspect that this should fix it (on top
> of upstream). Let me know if that's enough or if we also need to put
> one of these in ptep_set_access_flags().
>
> Please let me know if that works for you.
>
> Cheers,
> Ben.
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index 5304093..7a8e676 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -170,6 +170,16 @@ struct page * maybe_pte_to_page(pte_t pte)
>
>  static pte_t set_pte_filter(pte_t pte, unsigned long addr)
>  {
> +#ifdef CONFIG_8xx
> +   /* 8xx has a weird concept of "unpopulated" entries. When we take
> +    * a TLB miss for a non-valid PTE, we insert such an entry which
> +    * causes a page fault the next time around. This entry must now
> +    * be kicked out or we'll just fault again
> +    */
> +   /* 8xx doesn't care about PID, size or ind args */
> +   _tlbil_va(addr, 0, 0, 0);
> +#endif /* CONFIG_8xx */
> +

The main problem with 8xx it does not update the DAR register in
the TLB Miss/Fault handlers for cache instructions :( It on old bug
that was found only some years ago.

I think the old comment is correct though, as I recall it was Marcelo
that found the problem and added the workaround.

   Jocke
