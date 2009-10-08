Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1EA81B7B80
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 11:21:06 +1100 (EST)
In-Reply-To: <1254960296.2733.3.camel@pasglop>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254950092.2409.7.camel@pasglop>
	<OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
	<1254954017.2409.14.camel@pasglop>	
	<OFCA7943E6.AFEF924A-ONC1257648.007E27B0-C1257648.007F62E9@transmode.se>
	<1254960296.2733.3.camel@pasglop>
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFE2E96EF3.F21AB563-ONC1257649.0000A4AC-C1257649.0001C04D@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 02:19:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 08/10/2009 02:04:56:
>
>
> > Yes it does. If one adds HWEXEC it will fail, right?
>
> Why ? We can just filter out DSISR, we don't really care why it failed
> as long as we know whether it was a store or not.
>
> > Also this count as a read and you could easily end up
> > in the protection case(in 2.4 you do)
>
> I'm not sure what you mean by "the protection case" Again, the C code
> shouldn't care.

it does, and it should. How else should you know if you try
to read a NA space?

See:
	/* Protection fault on exec go straight to failure on
		 * Hash based MMUs as they either don't support per-page
		 * execute permission, or if they do, it's handled already
		 * at the hash level. This test would probably have to
		 * be removed if we change the way this works to make hash
		 * processors use the same I/D cache coherency mechanism
		 * as embedded.
		 */
		if (error_code & DSISR_PROTFAULT)
			goto bad_area;

...
/* a read */
	} else {
		/* protection fault */
		if (error_code & 0x08000000)
			goto bad_area;

>
> > hey, I think you have to show how then :) I am not
> > good at ppc shift, mask, rotate insn.
>
> They are so fun ! :-0

Great that someone thinks so :)

>
> > >
> > > > Because if you go to C with a protection fault, you are in trouble.
> > >
> > > Why ?
> >
> > In 2.4 you end up in read protection fault an get a SEGV back :)
>
> We probably should ignore the DSISR bits then. So it just goes to
> generic C code which then fixes up ACCESSED etc... and returns.

Not really I think.

>
> > Now I only handle DIRTY and the rest in C. Figured it is
> > much faster and really simplie now, stay tuned.
>
> You should not even have to handle DIRTY at all in asm. At least in 2.6.
> I can't vouch for what 2.4 generic code does... You should really port
> your board over :-)

2.4 and 2.6 have the same handling in asm.
hmm, maybe I should just call C, but 8xx isn't a speed monster so every
cycle counts :)
It works if I trap to C for DIRTY too.
Before thinking on porting my old board, I want 2.4 to enjoy
the new TLB code too :)

  Jocke
