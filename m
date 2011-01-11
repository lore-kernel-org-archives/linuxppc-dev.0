Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C92AB6F2B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jan 2011 07:27:23 +1100 (EST)
In-Reply-To: <20110111200853.GA21915@1wt.eu>
References: <1294695479-344-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20110111060926.GE16301@1wt.eu>
	<OFEC114402.5A694921-ONC1257815.002CC8F2-C1257815.002D1C7D@transmode.se>
	<20110111200853.GA21915@1wt.eu>
Subject: Re: [PATCH 00/13] powerpc: Backport 8xx TLB to 2.4
To: Willy Tarreau <w@1wt.eu>
Message-ID: <OF40F9D3A3.ED176FE9-ONC1257815.00704760-C1257815.00705C38@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 11 Jan 2011 21:27:16 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Willy Tarreau <w@1wt.eu> wrote on 2011/01/11 21:08:53:
>
> On Tue, Jan 11, 2011 at 09:12:44AM +0100, Joakim Tjernlund wrote:
> > Willy Tarreau <w@1wt.eu> wrote on 2011/01/11 07:09:26:
> > >
> > > Hi Joakim,
> > >
> > > On Mon, Jan 10, 2011 at 10:37:46PM +0100, Joakim Tjernlund wrote:
> > > > This is a backport from 2.6 which I did to overcome 8xx CPU
> > > > bugs. 8xx does not update the DAR register when taking a TLB
> > > > error caused by dcbX and icbi insns which makes it very
> > > > tricky to use these insns. Also the dcbst wrongly sets the
> > > > the store bit when faulting into DTLB error.
> > > > A few more bugs very found during development.
> > > >
> > > > I know 2.4 is in strict maintenance mode and 8xx is obsolete
> > > > but as it is still in use I wanted 8xx to age with grace.
> > >
> > > Thank you very much for taking care of this, that's very much appreciated.
> > > I'll look at this ASAP. Just a quick question in order to be certain, did
> > > you have the opportunity to test all of these changes on real hardware ?
> >
> > I tested these on real 8xx HW but I used an older 2.4 linux as we haven't
> > moved forward on 2.4 for quite some time.
> > The affected files were almost identical though.
>
> OK thank you for this precision. If you remember what version it was, we can
> also diff it against mainline and see if we spot any relevant changes that
> we need to take care of.

2.4.21-rc6 is the base version. The we have added bits and pieces.


>
> > Would be great if Scott could give them a spin on 8xx with current 2.4.
>
> Indeed, that would be great. My goal really is that 2.4 users can upgrade
> without wondering about any risk of regression. I appreciate a lot your
> fixes, they mean some people might see that some issues have suddenly
> disappeared. But it's important to stay on the non-reg side as much as
> possible.

Should be faster too :)
