In-Reply-To: <20040401185956.GB3786@gate.ebshome.net>
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com> <20040401100546.A27472@home.com> <4317F0F4-8405-11D8-9FF0-000A95A07384@sands-edge.com> <20040401181926.GA3630@gate.ebshome.net> <406C658E.10500@embeddededge.com> <20040401185956.GB3786@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2C2F00BD-8410-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Problems with dma_alloc_coherent()
Date: Thu, 1 Apr 2004 14:10:00 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I think we should use "device" parameter passed to DMA API for such
> stuff, it
> already has a member "struct bus_type* bus".
>

This effectively makes the DMA API a superset of the PCI DMA API (the
DMA API would recognize a PCI device, and handle it accordingly)?  It
sounds like a good solution to me, although I'd like to see the
"device" structure get that DMA offset I mentioned, so the DMA API
wouldn't have to have a special case for each new bus-type added (PLB,
PCI, OCP, CPM, whatever), as it does now for PCI vs. non-PCI.  (That
assumes bus offset is the only difference that needs to be handled...)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
