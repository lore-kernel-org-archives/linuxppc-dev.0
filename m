Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5C756DDF3A
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 23:35:23 +1000 (EST)
Date: Mon, 23 Apr 2007 08:54:30 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] [v2] powerpc: save trap number in bad_stack
Message-ID: <20070423135430.GA1805@lixom.net>
References: <20070416062347.GA20196@lixom.net>
	<20070422233821.GB28479@lixom.net>
	<20070423232217.08e420a6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070423232217.08e420a6.sfr@canb.auug.org.au>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2007 at 11:22:17PM +1000, Stephen Rothwell wrote:
> On Sun, 22 Apr 2007 18:38:21 -0500 olof@lixom.net (Olof Johansson) wrote:
> >
> > --- powerpc.orig/include/asm-powerpc/paca.h
> > +++ powerpc/include/asm-powerpc/paca.h
> > @@ -68,6 +68,7 @@ struct paca_struct {
> >  	void *emergency_sp;		/* pointer to emergency stack */
> >  	u64 data_offset;		/* per cpu data offset */
> >  	s16 hw_cpu_id;			/* Physical processor number */
> > +	u16 trap_save;			/* Used when bad stack is encountered */
> 
> Please read the comment at the top of the struct:
> 
>         /*
>          * Because hw_cpu_id, unlike other paca fields, is accessed
>          * routinely from other CPUs (from the IRQ code), we stick to
>          * read-only (after boot) fields in the first cacheline to
>          * avoid cacheline bouncing.
>          */
> 
> So please move this out of the first cache line.

Never thought I'd say this: Too many comments! I missed that one. :)

The variable should be written very rarely, so there should be no
performance impact for a normal system. Still, it's a valid point and
for consistency it should be moved.

There's room right before the u8 variables further down, I'll move
it there.


-Olof
