Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 16A53DDDA5
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 07:29:49 +1100 (EST)
Date: Wed, 18 Mar 2009 23:29:47 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/4] powerpc/85xx: Move gianfar mdio nodes under the
	ethernet nodes
Message-ID: <20090318202947.GA14504@oksana.dev.rtsoft.ru>
References: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
	<20090318200039.GC8182@oksana.dev.rtsoft.ru>
	<49C1541F.8040803@freescale.com>
	<20090318202344.GA9708@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090318202344.GA9708@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 11:23:44PM +0300, Anton Vorontsov wrote:
> On Wed, Mar 18, 2009 at 03:05:51PM -0500, Scott Wood wrote:
> > Anton Vorontsov wrote:
> >> Currently it doesn't matter where the mdio nodes are placed, but with
> >> power management support (i.e. when sleep = <> properties will take
> >> effect), mdio nodes placement will become important: mdio controller
> >> is a part of the ethernet block, so the mdio nodes should be placed
> >> correctly. Otherwise we may wrongly assume that MDIO controllers are
> >> available during sleep.
> >>
> >> NOTE: mpc8572ds_camp_core1.dts now fully specifies ethernet@24000
> >> layout. ethernet@24000 node is disabled via status = "disabled on
> >> core1" property.
> >
> > Hmm, would that imply that the mdio underneath it is disabled as well?
> 
> Technically, yes. In practice, MDIO and MAC drivers are probed
> separately.
> 
> I don't see any better solution, should I just leave the core1's
> mdio node intact?

Ah. We also could change compatible entry to "fsl,gianfar-slave".
This will prevent gianfar MAC driver to probe on core1.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
