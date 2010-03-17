Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD28FB7D47
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 18:35:57 +1100 (EST)
In-Reply-To: <1268774376.2335.130.camel@pasglop>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1268774376.2335.130.camel@pasglop>
Subject: Re: [PATCH 2/4] 8xx: Avoid testing for kernel space in ITLB Miss.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF796DDDFE.127D046C-ONC12576E9.00272CEF-C12576E9.0029B630@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 17 Mar 2010 08:35:36 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2010/03/16 22:19:36:
>
> On Fri, 2010-02-26 at 09:29 +0100, Joakim Tjernlund wrote:
> > +#ifdef CONFIG_MODULES
> > +       /* Only modules will cause ITLB Misses as we always
> > +        * pin the first 8MB of kernel memory */
> >         andi.   r11, r10, 0x0800        /* Address >= 0x80000000 */
> >         beq     3f
> >         lis     r11, swapper_pg_dir@h
> >         ori     r11, r11, swapper_pg_dir@l
> >         rlwimi  r10, r11, 0, 2, 19
> >  3:
> > +#endif
>
> You can optimize that further I think...
>
> You can probably just remove the code above, and add something to
> do_page_fault() that lazily copies the kernel PGD entries from
> swapper_pg_dir to the app pgdir. (You can even pre-fill that when
> creating a new mm).

I did look at this at some point and could not figure out how
to do this.
