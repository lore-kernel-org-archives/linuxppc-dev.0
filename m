Mime-Version: 1.0 (Apple Message framework v613)
Message-Id: <034E6544-833B-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-dev@lists.linuxppc.org
From: John Whitney <johnw@sands-edge.com>
Subject: Generic DMA Core
Date: Wed, 31 Mar 2004 12:44:08 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have written a generic DMA core driver (drivers/dma/) that accepts
registrations from low-level DMA hardware drivers (providers).  I've
also written a provider driver for the MPC10x dual-channel DMA
controller.

Effectively, the DMA core accepts requests to transfer data from one
address to another, with the ability to request things like
source-address-holding, destination-address-holding, etc.  It then
matches a request to a provider that can support it, and queues the
request to the provider.  After completion, the DMA core calls a
provided callback for the client.  The core also handles
cache-coherency with explicit flushes and invalidates, not making
assumptions that the addresses are in cache-coherent regions.

Is there any interest in this code, and if so, what would be the best
way for going about getting it included in the kernel?

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
