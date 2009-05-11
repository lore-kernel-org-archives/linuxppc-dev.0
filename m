Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADDCADDDE9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 08:25:22 +1000 (EST)
Subject: Re: device trees.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 May 2009 08:25:07 +1000
Message-Id: <1242080707.304.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dhlii@dlasys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Not pretty, but it does more or less what you're talking about. Would
> > need some work to get it going on !pseries obviously.
> 
> Heh, I didn't even know this existed.  :-)
> 
> Thinking about this more, it seems to me that the tricky bit would be
> figuring out how to drop all references to a node before it is pruned
> from the tree.  of_platform_devices would probably be the easiest
> because the bus could walked before pruning the node, but there are
> also references on the i2c, spi and mdio busses that must be dealt
> with appropriately.

Also, the way userspace manipulates the tree via /proc/ppc64 is quite
gross... Some time ago we discussed about moving that to the kernel
since the firmware call that gives us the new bits of tree could be done
there in a relatively generic way but that's only one option.

Maybe it's time to have a proper devicetreefs so one can use standard fs
APIs to create nodes & properties though we would need a trick to turn
them from "temporary" to "online" and similar for offlining. Maybe with
mv from/to a "staging" directory that isn't "live" vs. the kernel.

Cheers,
Ben.
 
