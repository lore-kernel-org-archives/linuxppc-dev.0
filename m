Message-ID: <406C658E.10500@embeddededge.com>
Date: Thu, 01 Apr 2004 13:55:10 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eugene Surovegin wrote:

> Hmm, I don't understand this, bus != PCI bus.

Isn't that necessary due to bridge windows?  If != PCI bus I guess we
assume OCP that are connected to a 1:1 mapped internal bus, which
may not be a valid assumption either.

> Current implementation just relies on the fact that PCI devices view system
> memory the same way as other-bus devices (e.g. OCP devices which sit on OPB).

I don't think so.  PCI devices are known to go through bridges, while
others are assumed to not.

> In more general case, yes, "views" can be different for each bus type or even
> for each bus...

So, we should always have some kind of 'bus type' device handle, that provides
this information.  It's clear that all Linux APIs are designed from the
viewpoint of PC-like workstations.  They have always fallen very short when
pressed into the more prevalent embedded computing space :-)


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
