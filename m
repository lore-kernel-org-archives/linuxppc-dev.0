Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6CED0B7013
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2012 04:29:46 +1000 (EST)
In-Reply-To: <1338593099.16119.60.camel@pasglop>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
 <4FC8EDC4.2050704@freescale.com> <1338589800.16119.58.camel@pasglop>
 <4FC9456B.8090400@freescale.com> <1338593099.16119.60.camel@pasglop>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFF2E739FE.A96EBAF2-ONC1257A11.00655546-C1257A11.0065978F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 2 Jun 2012 20:29:39 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
 Bob Cochran <ppc@mindchasers.com>, support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> On Fri, 2012-06-01 at 17:42 -0500, Scott Wood wrote:
> > On 06/01/2012 05:30 PM, Benjamin Herrenschmidt wrote:
> > > BTW. My point of view is that this whole business about MSR:DE is a HW
> > > design bug. There should be -no- (absolutely 0) interaction between the
> > > SW state and the HW debugger for normal operations unless the user of
> > > the debugger explicitly wants to change some state.
> >
> > I agree entirely, and e500mc at least has less of this than e500v2 (not
> > sure if it still needs MSR[DE], but supposedly it doesn't have the
> > requirement for there to be a valid instruction at the debug vector,
> > which is lots of fun when booting).  But this isn't exactly something
> > Freescale is going to replace existing chips over.
> >
> > Getting all the way to zero interaction would require a completely
> > separate debug facility so software can debug at the same time.  I'd be
> > all for that (and let's throw in a third, for the hypervisor), but I'm
> > not the one that needs to be convinced.
>
> You can find a good compromise. If you have some kind of SPR letting you
> know now many DACs and IACs are available, you could essentially
> "reserve" some for HW debug with the probe. Not as good as a fully
> separate facility but still better than stepping on each other toes.
>
> Things like DBCR should probably still be separated. There's no excuse
> for the MSR:DE bullshit tho :-)

hmm, where does this go w.r.t the patch? Got the feeling that the
best thing is to just turn MSR:DE on and be done with it?

 Jocke
