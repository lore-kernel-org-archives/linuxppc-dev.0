Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 85037B7B92
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 01:19:55 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B6399DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 01:19:54 +1000 (EST)
Date: Fri, 28 Aug 2009 19:19:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Hu Mingkai-B21284 <Mingkai.Hu@freescale.com>
Subject: Re: [PATCH v2] powerpc/85xx: Add eSDHC support for MPC8536DS boards
Message-ID: <20090828151953.GA14776@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
	<20090807195822.GG2735@oksana.dev.rtsoft.ru>
	<A17F24A0-87E0-4FFA-9C14-DF57D8A9D015@kernel.crashing.org>
	<20090818233818.GA29042@oksana.dev.rtsoft.ru>
	<F58A75CD-73CC-4F75-AF51-2BCC0B828E84@kernel.crashing.org>
	<20090819015101.GA10782@oksana.dev.rtsoft.ru>
	<73839B4A0818E747864426270AC332C304438438@zmy16exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <73839B4A0818E747864426270AC332C304438438@zmy16exm20.fsl.freescale.net>
Cc: Ben Dooks <ben@fluff.org>, linux-kernel@vger.kernel.org,
	sdhci-devel@lists.ossman.eu, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pierre Ossman <pierre@ossman.eu>, David Vrabel <david.vrabel@csr.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2009 at 07:02:51PM +0800, Hu Mingkai-B21284 wrote:
> > On Tue, Aug 18, 2009 at 08:24:17PM -0500, Kumar Gala wrote:
> > > 
> > > On Aug 18, 2009, at 6:38 PM, Anton Vorontsov wrote:
> > > 
> > > >This patch simply adds sdhci node to the device tree.
> > > >
> > > >We specify clock-frequency manually, so that eSDHC will 
> > work without 
> > > >upgrading U-Boot. Though, that'll only work for default setup (1500
> > > >MHz) on new board revisions. For non-default setups, it's 
> > recommended 
> > > >to upgrade U-Boot, since it will fixup clock-frequency 
> > automatically.
> > > >
> > > >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > > 
> > > out of interest the 85xx eSDHC don't need the sdhci,wp-inverted 
> > > property?
> > 
> > Yes, eSDHC controllers in MPC85xx report normal state in its 
> > registers.
> > 
> 
> Hi Anton,
> 
> The eSDHC controller in different silicon version on MPC8536  reports
> different WP state in the register PRSSTAT:

Thanks a million for the heads up!

Yes, the manual I used ("MPC8536ERM Rev. 0 10/2008") doesn't mention
that, but the newer manual that I just downloaded ("MPC8536ERM Rev. 1
05/2009") does.

[...]
> For silicon 1.0,  the macro SDHCI_QUIRK_INVERTED_WRITE_PROTECT is also
> defined,
> so the dirver will report the error WP state in function sdhci_get_ro.

Not any longer. We don't actually define it for any 85xx CPUs.

I need to think how should we handle all these WP inversions. :-)

So, we have inversion in BCSR (depending on the BCSR revision),
configurable inversion in CPU via GENCFGR for 1.1 silicon, and
non-configurable non-inverted reporting for 1.0 silicon...

Do you know if there are any plans to fix the WP inversion for
MPC8569E-MDS boards, or make something like GENCFGR for MPC8569
CPUs?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
