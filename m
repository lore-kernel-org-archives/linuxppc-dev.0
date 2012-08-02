Return-Path: <Clive.Jenkins@xerox.com>
Received: from USA7109MR002.ACS-INC.COM (usa7109mr002.acs-inc.com
 [63.101.151.11])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "usa7109mr.acs-inc.com",
 Issuer "USERTrust Legacy Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8477B2C0088
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 19:46:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Problem in phy.c, when using fixed network speed
Date: Thu, 2 Aug 2012 10:35:45 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB906A791B1@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <50197214.7090703@gmx.net>
References: <50197214.7090703@gmx.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: Michael Koch <caesar_hal9000@gmx.net>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi all,
> during testing i encountered a problem with setting
> up a 5200B controller with a MICREL phy at static
> 100MBit full duplex - without autonegotiation.
>
> I performed this as usual with ethtool and was
> succesful when i had my link partner up, providing
> a link.
>
> When kepping the link partner off, meaning no link
> at all, my machine started to degrade its link
> capabilities ending 10MBit half duplex.
>
> I tracked it down to drivers/net/phy/phy.c:
> in the function phy_state_machine, the case block
> PHY_FORCING causes this (at least for me) undesired
> behaviour. Calling the phy_force_reduction function
> degrades actually an intentionally static setup.
>
> I deactivated those lines, and it works for me.
>
> But anyhow i feel soe need to have a general
> solution that takes static non autonagotiation
> setups into account.
>
> What do you think?
>
> Hope to hear from you
>
> Michael

Yes, I have encountered this before. I think it dates=20
back to before Auto Negotiation became part of the=20
IEEE802* standard and each manufacturer implemented=20
its own strategy to establish a link. Although it is=20
possible "by experiment" to find the speed of your=20
link partner, it is impossible to determine its=20
Full/Half Duplex mode. IMHO when a fixed speed and=20
duplex setting is applied, phy.c should keep that=20
setting regardless of whether or not the link is=20
established. Not only is this undesirable behaviour,=20
but it deviates from the standard.

Clive
