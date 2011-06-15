Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 254C9B6F92
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2011 17:36:52 +1000 (EST)
In-Reply-To: <OF75A64D65.5ABAA9A9-ONC12578AF.0062124A-C12578AF.0062E416@LocalDomain>
References: <1308059700-10839-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1308059700-10839-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<53DBBA1E-BD8C-4856-9E35-028C8BB0911F@digitaldans.com>
	<OF75A64D65.5ABAA9A9-ONC12578AF.0062124A-C12578AF.0062E416@LocalDomain>
Subject: Re: [PATCH 06/15] 8xx: Always pin kernel instruction TLB
To: Dan Malek <ppc6dev@digitaldans.com>
Message-ID: <OF2C6FF80A.8207F3A3-ONC12578B0.00295A5C-C12578B0.0029D201@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 15 Jun 2011 09:36:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund/Transmode wrote on 2011/06/14 20:00:09:
> From: Joakim Tjernlund/Transmode
>
> Dan Malek <ppc6dev@digitaldans.com> wrote on 2011/06/14 18:06:45:
> >
> >
> > Hi Joakim.
> >
> > On Jun 14, 2011, at 6:54 AM, Joakim Tjernlund wrote:
> >
> > > Various kernel asm modifies SRR0/SRR1 just before executing
> > > a rfi. .....
> >
> > I'm going to argue we can easily visually inspect for this
> > since the code is static with just a couple of RFIs in these
> > exception handlers.
>
> Yes, but then you also miss out on 8xx: Optimize ITLBMiss handler.
>
> >
> > Some 8xx processors have few TLB entries, and always taking
> > one for the kernel, especially if it isn't needed, could have a
> > detrimental effect on the application performance.  Even the
> > "big" 8xx processors don't have that many entries.  Some
> > benchmarks run on an MPC850 would likely show this.
>
> I don't have a mpc850, do you?
>
> >
> > Anyone making modifications to this level of software should
> > know of this problem, or make it known in a comment.  If you
> > are making changes, just compile the code and manually
> > check it with the couple of configuration options that affect
> > the placement of the instructions.
>
> Very fragile but then again, not much are expected to change
> in this area for 8xx.

So I checked and SRR0/SRR1 are fine w.r.t to head_8xx.S, it does
not even come close. There are SRR0/SRR1 mods in entry.S too
which works fine ATM. We don't have the same control of
that file though.
Could you check what impact pinning ITLB on 850 has?

 Jocke
