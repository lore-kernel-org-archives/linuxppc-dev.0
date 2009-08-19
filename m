Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E8FDAB7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 11:51:03 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 7CB1ADDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 11:51:03 +1000 (EST)
Date: Wed, 19 Aug 2009 05:51:01 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/85xx: Add eSDHC support for MPC8536DS boards
Message-ID: <20090819015101.GA10782@oksana.dev.rtsoft.ru>
References: <20090807195724.GA24020@oksana.dev.rtsoft.ru>
	<20090807195822.GG2735@oksana.dev.rtsoft.ru>
	<A17F24A0-87E0-4FFA-9C14-DF57D8A9D015@kernel.crashing.org>
	<20090818233818.GA29042@oksana.dev.rtsoft.ru>
	<F58A75CD-73CC-4F75-AF51-2BCC0B828E84@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <F58A75CD-73CC-4F75-AF51-2BCC0B828E84@kernel.crashing.org>
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

On Tue, Aug 18, 2009 at 08:24:17PM -0500, Kumar Gala wrote:
> 
> On Aug 18, 2009, at 6:38 PM, Anton Vorontsov wrote:
> 
> >This patch simply adds sdhci node to the device tree.
> >
> >We specify clock-frequency manually, so that eSDHC will work without
> >upgrading U-Boot. Though, that'll only work for default setup (1500
> >MHz) on new board revisions. For non-default setups, it's recommended
> >to upgrade U-Boot, since it will fixup clock-frequency automatically.
> >
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> out of interest the 85xx eSDHC don't need the sdhci,wp-inverted
> property?

Yes, eSDHC controllers in MPC85xx report normal state in its
registers.

But the funny thing is that the switch itself is inverted,
so to enable writing, on MPC8569E-MDS and MPC8536DS boards
we have to place card's write protect tab into "lock" position.

Unfortunately we can't fix that in software since controller
doesn't permit write operations if it detects write-protected
state. On the bright side, IIRC MPC8536DS revision history
says that WP line level is fixed via BCSR upgrade. Not sure
if it is possible to fix it for MPC8569E-MDS.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
