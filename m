Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 73F1B67C5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 23:56:29 +1000 (EST)
Date: Wed, 27 Jul 2005 06:56:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Avni Hillel-R58467 <hillel.avni@freescale.com>
Message-ID: <20050727065626.D32625@cox.net>
References: <D39C8B3D64A0D511A61E00D0B7828EEA0C0764FD@zil05exm01.ea.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D39C8B3D64A0D511A61E00D0B7828EEA0C0764FD@zil05exm01.ea.freescale.net>;
	from hillel.avni@freescale.com on Wed, Jul 27, 2005 at 01:36:15PM +0300
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][5/5] RapidIO support: net driver over messaging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2005 at 01:36:15PM +0300, Avni Hillel-R58467 wrote:
> Hi Matt,
> 
> Two questions:
> 
> A. How can a node (not the host) know who is in the rionet to broadcast to them? 

All nodes in the rionet are flagged in the active peer list.  There is an
active peer list kept for the rionet instance on _each node_. There is
no distinction as to whether a node was the winning enumerating host or
is just another processing element that found devices in the system via
passing discovery. The only inherently significant about a "host" in
RapidIO is that it participates in enumeration. After the system is
enumerated it's no longer special (unless your particular system
application designates the hosts have some special network-wide
ownership of resources or something). 

Broadcast works the same way on all nodes by sending the same packet
to every node in the active peer list.

> B. How do you emulate broadcasting to all the mailboxes, in multi mbox systems? Is this done by the node getting the broadcast in MB 0 and forwarding it to the other MBs?

rionet doesn't handle multiple mailboxes yet.

However, it becomes tricky because we don't want to bridge separate
Ethernet networks by policy in the driver.  If two mailboxes are
part of separate rio device trees, then it doesn't make sense to send
broadcasts out on both mailboxes. It needs some thought and also
docs on how new silicon might be implementing queues in new mailboxes.

With RIO, there's so much left to be implementation specific in the
silicon. It did not make sense to make assumptions and try to
handle multiple mailboxes. If you have a multi mbox system it would
help to have a description so we can work to support it.

-Matt
