Return-Path: <caesar_hal9000@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
 by ozlabs.org (Postfix) with SMTP id E58AB2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2012 04:21:34 +1000 (EST)
Message-ID: <50197214.7090703@gmx.net>
Date: Wed, 01 Aug 2012 20:14:44 +0200
From: Michael Koch <caesar_hal9000@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Problem in phy.c, when using fixed network speed
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,
during testing i encountered a problem with setting up a 5200B 
controller with a MICREL phy at static 100MBit full duplex - without 
autonegotiation.

I performed this as usual with ethtool and was succesful when i had my 
link partner up, providing a link.

When kepping the link partner off, meaning no link at all, my machine 
started to degrade its link capabilities ending 10MBit half duplex.

I tracked it down to drivers/net/phy/phy.c:
in the function phy_state_machine, the case block PHY_FORCING causes 
this (at least for me) undesired behaviour. Calling the 
phy_force_reduction function degrades actually an intentionally static 
setup.

I deactivated those lines, and it works for me.

But anyhow i feel soe need to have a general solution that takes static 
non autonagotiation setups into account.

What do you think?

Hope to hear from you

Michael
