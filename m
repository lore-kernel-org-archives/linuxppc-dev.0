Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11F07B7B70
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 18:03:29 +1100 (EST)
In-Reply-To: <1255326374.2192.112.camel@pasglop>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255296330.2192.42.camel@pasglop>
	<OF67239BF2.43007548-ONC125764C.007A17D3-C125764C.007A9BE3@transmode.se>
	<1255301096.2192.44.camel@pasglop>	
	<OFE59DA813.A2491F26-ONC125764D.001E597A-C125764D.001EC8E7@transmode.se>
	<1255326374.2192.112.camel@pasglop>
Subject: Re: [PATCH 6/8] 8xx: Add missing Guarded setting in DTLB Error.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF463AA1A7.D3BA204B-ONC125764D.0023FDA0-C125764D.00266023@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 12 Oct 2009 08:59:09 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 12/10/2009 07:46:14:
>
> On Mon, 2009-10-12 at 07:36 +0200, Joakim Tjernlund wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 12/10/2009 00:44:56:
> > > On Mon, 2009-10-12 at 00:19 +0200, Joakim Tjernlund wrote:
> > > >
> > > > I hear you, I can remove DTLB error with an add on patch later if that is OK?
> > > > I cannot remove the DARFix though, when I move that to do_page_fault(), I get
> > > > duplicate TLB hits on the same insn. It is like when transfer_to_handler()
> > > > executes rfi, the cpu restarts the the faulting insn instead of jumping
> > > > to the page fault handler, not always but often.
> > >
> > > I'm not sure what you mean here ...
> >
> > Just that I need to keep the DAR fix for dcbX insn in the DTLB handler. If I try
> > to move it to do_page_fault() I get a lot more DTLB errors for dcbX insn.
>
> I'm not sure why (ie, I didn't get your explanation about rfi and
> restarting the faulting insn etc...) but ok, I don't mind having
> the DAR fixup remain in the asm. It's the whole logic that looks
> at the PTE and does things with it that I feel has no room in there :-)

OK, I will send a removal patch too.

>
> BTW. Maybe the do_page_fault() thing comes from the fact that we
> also go there via ITLB Error which doesn't set the DAR and
> that's normal ?

I had that idea to, but no. These have different traps numbers and
address is set to SRR0 for ITLB and to DAR for DTLB. I test for DTLB
trap number before doing anything.
