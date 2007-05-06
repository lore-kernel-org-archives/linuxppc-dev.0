Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07E62DDEEB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 23:27:53 +1000 (EST)
In-Reply-To: <20070506114429.5c631864@localhost.localdomain>
References: <20070506004737.31233.52611.stgit@localhost.localdomain>
	<67c6bf6b7d37f5e133398ea83edeac78@kernel.crashing.org>
	<20070506114429.5c631864@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <84e2e0ca1796d87adb58c90c1b7dbc94@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Date: Sun, 6 May 2007 15:26:48 +0200
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Since this node's children's interrupt representation
>> is different from the node's parent's, you need an
>> interrupt-map in here.  You also forgot "#address-cells"
>> and I think you need "ranges" too?
>>
> Well, in fact it does not introduce SoC device different from any 
> others
> represented inside soc885 node. mk_int_int_mask() is just special
> way of enabling irq for PCMCIA stuff, in addition to normal pic stuff.

I have no idea what you mean here.  Care to try again?

> Emm. Why would I need #address-cells and ranges here? it uses parent 
> bus address space...

"#address-cells" is 3 for pcmcia, so not the default
value (which is 2), so you need to put it in.  The
value of this property is not inherited from the
parent node.

Absence of a "ranges" property means the child bus is
*not* direct mapped into the parent bus space.  If the
mapping you need is 1-1, put in an empty "ranges"
property; if not, you have to put the correct mapping
in.


Segher
