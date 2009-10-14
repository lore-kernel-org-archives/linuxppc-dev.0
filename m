Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B6A3B7BA7
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 06:05:11 +1100 (EST)
In-Reply-To: <20091014172003.GD21215@loki.buserror.net>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091014172003.GD21215@loki.buserror.net>
Subject: Re: [PATCH 4/8] 8xx: Fixup DAR from buggy dcbX instructions.
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF64D89B73.6073827F-ONC125764F.00687BC4-C125764F.0068D4DC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 14 Oct 2009 21:05:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 14/10/2009 19:20:03:
>
> On Sun, Oct 11, 2009 at 06:35:08PM +0200, Joakim Tjernlund wrote:
> > This is an assembler version to fixup DAR not being set
> > by dcbX, icbi instructions. There are two versions, one
> > uses selfmodifing code, the other uses a
> > jump table but is much bigger(default).
> > ---
> >  arch/powerpc/kernel/head_8xx.S |  146 +++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 145 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> > index 093176c..9839e79 100644
> > --- a/arch/powerpc/kernel/head_8xx.S
> > +++ b/arch/powerpc/kernel/head_8xx.S
> > @@ -494,7 +494,8 @@ DataTLBError:
> >
> >     mfspr   r10, SPRN_DAR
> >     cmpwi   cr0, r10, 0x00f0
> > -   beq-   2f   /* must be a buggy dcbX, icbi insn. */
> > +   beq-   FixDAR   /* must be a buggy dcbX, icbi insn. */
> > +DARFix:   /* Return from dcbx instruction bug workaround, r10 holds value of DAR */
>
> Both FixDAR and DARFix?  Could we make the labels a little clearer?

Yes, need to come up with better names :)

>
> > +/* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
> > + * by decoding the registers used by the dcbx instruction and adding them.
> > + * DAR is set to the calculated address and r10 also holds the EA on exit.
> > + */
>
> How often does this happen?  Could we just do it in C code after saving all
> the registers, and avoid the self modifying stuff (or the big switch
> statement equivalent)?

I had some problems with the C-version. I got lots of extra TLB errors for the same address
so I am not confident it will work in the long run.

BTW, you could add a test and printk in do_page_fault on address 0x000000f0.
if that ever hits there is a problem with dcbX fixup.
