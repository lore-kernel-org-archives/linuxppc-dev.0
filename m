Date: Thu, 1 Apr 2004 10:59:56 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Dan Malek <dan@embeddededge.com>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
Message-ID: <20040401185956.GB3786@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <406C658E.10500@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 01, 2004 at 01:55:10PM -0500, Dan Malek wrote:
> >Current implementation just relies on the fact that PCI devices view system
> >memory the same way as other-bus devices (e.g. OCP devices which sit on
> >OPB).
>
> I don't think so.  PCI devices are known to go through bridges, while
> others are assumed to not.

Well, bridge doesn't necessarily mean there is an address translation :).
Currently 4xx systems (not sure all, at least ones I use) use PCI == phys
address mapping, and yes, bridge is setup so this is the case.

Although, I understand in more general case, bridge will translate address.

> >In more general case, yes, "views" can be different for each bus type or
> >even
> >for each bus...
>
> So, we should always have some kind of 'bus type' device handle, that
> provides
> this information.  It's clear that all Linux APIs are designed from the
> viewpoint of PC-like workstations.  They have always fallen very short when
> pressed into the more prevalent embedded computing space :-)

I think we should use "device" parameter passed to DMA API for such stuff, it
already has a member "struct bus_type* bus".

Eugene

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
