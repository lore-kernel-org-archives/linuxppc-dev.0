In-Reply-To: <20040401191715.GC3786@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net> <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com> <20040401191715.GC3786@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CDB1AF42-8413-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Thu, 1 Apr 2004 14:35:59 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I think we should add such info to a structure which describes the
> _bus_, not
> _device_.
> I'm not "new-device-model" guru, so I cannot comment _how_ this can be
> implemented though :)

Yes, after thinking about it, it made more sense to modify the "struct
bus_type" structure to have the bus memory map offset.  We could then
have an OCP bus type, PLB bus type, etc.  However, that would be a core
kernel change, and I don't know how easy it is to get those pushed back
into the mainline.

Also, after looking at the kernel code more (I'm fairly new to 2.6,
which I'm sure you've deduced), it looks like most routines expect
instances of type "bus_type" to be enumeratable/hot-swappable, and many
of the busses I'd use in the embedded world wouldn't fit.  I don't know
how easy or difficult it would be to use the bus_type code construct in
this fashion.

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
