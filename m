Message-ID: <3FABC7C3.8060703@embeddededge.com>
Date: Fri, 07 Nov 2003 11:26:43 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: m8260_cpm_hostalloc() data reads incorrect data
References: <B1243F436404D511A5CF009027E705DA148191C2@uswaumsx09medge.med.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Petersen, David (MED, GEMS-IT) wrote:

 > ....However the
> data that is read from the buffer is incorrect.  As a sanity check, I
> allocated my buffers using m8260_cpm_dpalloc() and I then read the correct
> data.

It doesn't sound like you are properly setting up the device with
the 'global' memory access flags, which cause the CPM to perform
cache coherent DMA.

> ....It is unclear to me how this memory can be
> in a PAGE_NO_CACHE region as it needs to be for the CPM.

The caches on the 82xx/603e cores are cache coherent with the CPM,
when the devices are configured properly.  If you notice, all of
the exisiting drivers enable cache coherent DMA from the CPM.

The flexibility of the CPM allows non-coherent options, but the
current implementation of VM on traditional PPC cores (which are
always cache coherent) doesn't provide for the creation of
such memory regions, which really aren't necessary.




	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
