Date: Wed, 21 Nov 2001 10:30:50 +1100
From: Anton Blanchard <anton@samba.org>
To: Jan Smith <smith@cendio.se>
Cc: linuxppc-dev@lists.linuxppc.org, peter@cendio.se
Subject: Re: Problem with a IBM ServerRAID and it's PCI-bridge
Message-ID: <20011121103050.A13279@krispykreme>
References: <vxherpthki.fsf@snoddas.lkpg.cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <vxherpthki.fsf@snoddas.lkpg.cendio.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

> We are trying to build the ips driver for the IBM ServerRAID 4H
> card.

The last time I looked, this driver was not endian safe.

> When the kernel is booting do we get some information about some
> fixup function that are moving the cards I/O-adress from fffc00 to
> 1fffc00. (Output from dmesg is included below.)

Thats fine, its due to the way io apertures for different host bridges
are handled. The apertures are mapped in one after the other so that only
the first one has no offset.

If you have more than one host bridge, you have to add the offset since
the io ports are all relative to the start of the first host bridge
aperture.

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
