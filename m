Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 16840B6FFE
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2012 09:25:14 +1000 (EST)
Message-ID: <1338593099.16119.60.camel@pasglop>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 02 Jun 2012 09:24:59 +1000
In-Reply-To: <4FC9456B.8090400@freescale.com>
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
 <4FC8EDC4.2050704@freescale.com> <1338589800.16119.58.camel@pasglop>
 <4FC9456B.8090400@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Bob Cochran <ppc@mindchasers.com>,
 support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-06-01 at 17:42 -0500, Scott Wood wrote:
> On 06/01/2012 05:30 PM, Benjamin Herrenschmidt wrote:
> > BTW. My point of view is that this whole business about MSR:DE is a HW
> > design bug. There should be -no- (absolutely 0) interaction between the
> > SW state and the HW debugger for normal operations unless the user of
> > the debugger explicitly wants to change some state.
> 
> I agree entirely, and e500mc at least has less of this than e500v2 (not
> sure if it still needs MSR[DE], but supposedly it doesn't have the
> requirement for there to be a valid instruction at the debug vector,
> which is lots of fun when booting).  But this isn't exactly something
> Freescale is going to replace existing chips over.
> 
> Getting all the way to zero interaction would require a completely
> separate debug facility so software can debug at the same time.  I'd be
> all for that (and let's throw in a third, for the hypervisor), but I'm
> not the one that needs to be convinced.

You can find a good compromise. If you have some kind of SPR letting you
know now many DACs and IACs are available, you could essentially
"reserve" some for HW debug with the probe. Not as good as a fully
separate facility but still better than stepping on each other toes.

Things like DBCR should probably still be separated. There's no excuse
for the MSR:DE bullshit tho :-)

Cheers,
Ben.
