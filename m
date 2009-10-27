Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E1CE2B7BFA
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Oct 2009 02:58:41 +1100 (EST)
Date: Tue, 27 Oct 2009 10:58:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
Message-ID: <20091027155841.GA25916@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF2108C9F5.3115433C-ONC125765C.003129B4-C125765C.0032EE38@transmode.se>
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

On Tue, Oct 27, 2009 at 10:16:17AM +0100, Joakim Tjernlund wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 27/10/2009 01:00:53:
> >
> > On Mon, 2009-10-26 at 16:26 -0700, Dan Malek wrote:
> > > Just be careful the get_user() doesn't regenerate the same
> > > translation error you are trying to fix by being here......
> 
> yes, I had some problems with this initially but managed to work around
> that. I noticed another problem though, I got multiple TLB errors for the
> same address when I did it in C. Noticed by just printk:ing every hit for
> a dcbX insn in do_page_fault. I can't explain it, but it seems like when
> moving to C you have to execute a rfi insn and that might somehow restart
> the dcbX insn before moving on to the page fault routine(or something
> totally different)

The rfi should be to other kernel code -- there is no way that it should be
restarting the dcbX (other than when trying to turn a TLB miss into a TLB
error).  Can you post the C version, maybe we can see what's going wrong? 
Is the empty TLB entry from the miss getting invalidated in the dcbX fixup
case?

> > It shouldn't since it will always come up with a proper DAR but
> > you may want to double check before hand that your instruction
> > address you are loading from is -not- your marker value for bad DAR.
> 
> hmm, I check that the insn really is a dcbX insn, but not that the address is
> != 0x00f0. Don't see how it could be as if something is wrong with
> the insn address you get ITLB error instead of a DTLB error.

I'm guessing he meant the data address you're loading.

> Anyhow, things seems stalled as I haven't heard from Scott or Rex for a
> while. If this isn't working now, I really don't know what is wrong and
> need some debugging help.

I'll test the latest version, but I have some scheduling latency. :-)

-Scott
