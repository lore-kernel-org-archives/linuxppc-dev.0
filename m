Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 935782C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 21:52:19 +1100 (EST)
Date: Wed, 5 Mar 2014 11:52:09 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] dts: mpc512x: adjust clock specs for FEC nodes
Message-ID: <20140305105209.GZ3327@book.gsilab.sittig.org>
References: <1393237557-31406-1-git-send-email-gsi@denx.de>
 <1393237557-31406-2-git-send-email-gsi@denx.de>
 <20140303092231.GS3327@book.gsilab.sittig.org>
 <20140305014836.GC8784@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140305014836.GC8784@S2101-09.ap.freescale.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Mike Turquette <mturquette@linaro.org>, Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 05, 2014 at 09:48 +0800, Shawn Guo wrote:
> 
> On Mon, Mar 03, 2014 at 10:22:31AM +0100, Gerhard Sittig wrote:
> > On Mon, Feb 24, 2014 at 11:25 +0100, Gerhard Sittig wrote:
> > > 
> > > a recent FEC binding document update that was motivated by i.MX
> > > development revealed that ARM and PowerPC implementations in Linux
> > > did not agree on the clock names to use for the FEC nodes
> > > 
> > > change clock names from "per" to "ipg" in the FEC nodes of the
> > > mpc5121.dtsi include file such that the .dts specs comply with
> > > the common FEC binding
> > > 
> > > this "incompatible" change does not break operation, because
> > > - COMMON_CLK support for MPC5121/23/25 and adjusted .dts files
> > >   were only introduced in Linux v3.14-rc1, no mainline release
> > >   provided these specs before
> > > - if this change won't make it for v3.14, the MPC512x CCF support
> > >   provides full backwards compability, and keeps operating with
> > >   device trees which lack clock specs or don't match in the names
> > > 
> > > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > 
> > ping
> > 
> > Are there opinions about making PowerPC users of FEC use the same
> > clock names as ARM users do, to re-use (actually: keep sharing)
> > the FEC binding?  The alternative would be to fragment the FEC
> > binding into several bindings for ARM and PowerPC, which I feel
> > would be undesirable, and is not necessary.
> 
> As I already said, Documentation/devicetree/bindings/net/fsl-fec.txt
> was created specifically for i.MX FEC controller from day one.  And even
> as of today, it doesn't serve PowerPC, because for example the property
> 'phy-mode' documented as required one is not required by PowerPC FEC.
> My opinion would be to patch fsl-fec.txt a little bit to make it clear
> that it's a binding doc for i.MX FEC, and create the other one for
> PowerPC FEC.  This is the way less confusing to people and easier for
> binding maintenance.

Should we still try to have a common behaviour where possible?
Such that even if there are two bindings, they don't diverge in
"unnecessary" ways?

But given that we already are past -rc5, I guess the suggested
change is too late for v3.14 anyway.  So we have to live with the
fact of a mainline release of different behaviour.

And the backwards compatibility support in the MPC512x CCF
implementation allows to cope with a potential future "ipg"
unification while still working with former "per" using device
trees.  There's no blocker.  So nevermind.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
