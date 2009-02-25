Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 2E3E8DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 20:26:04 +1100 (EST)
Message-ID: <49A50EA7.8040008@consentry.com>
Date: Wed, 25 Feb 2009 01:25:59 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>	
	<49810367.5000904@consentry.com>	
	<547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>	
	<20090219184410.GB4180@ld0162-tx32.am.freescale.net>	
	<547eba1b0902192101n323f51ceuf39b9d954b696225@mail.gmail.com>
	<547eba1b0902242309o2086dce2p49c59a9ea1b85b53@mail.gmail.com>
In-Reply-To: <547eba1b0902242309o2086dce2p49c59a9ea1b85b53@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Daniel Ng wrote:
>> Now, I'm seeing these boot messages:
>>
>> f0010d40:00 not found
>> eth0: Could not attach to PHY

Daniel,

These messages are typical of having the wrong GPIO pins in the mdio
node or the wrong MDIO address (reg property) in the ethernet-phy node.

>> Currently, our PHY
>> attributes eg. 'auto-negotiate' are not changeable, so we aren't
>> actually using MDC+MDIO even the MDC+MDIO lines exist.

The driver definitely tries to talk to the PHY using the GPIO pins
and address specified and if it doesn't respond, it won't attach.

>> Also, the PHY
>> interrupt line is not wired up. Hence the PHY0 interrupts field is <0
>> 8> (or should it be removed altogether?).

The mdio driver works without interrupts.  I have no interrupt-parent
or interrupts properties on my ethernet-phy node.

					-=] Mike [=-
