Date: Thu, 2 Mar 2000 15:41:20 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, "Timothy A. Seufert" <tas@mindspring.com>,
        dledford@redhat.com
Subject: Re: Need reports about PCI I/O conflicts
In-Reply-To: <20000302152244.014464@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10003021537520.2213-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




	Hi,

> Note about the Adaptec problem reported earlier, this is apparently not
> an OF bug, but a combination of an OF "feature" along with a bug in
> Michel patches.
>
> What I think happens is that the firmware (and I suspect this is done by
> the Adaptec OF code on the card, not by OF itself) will "disable" the IO
> accesses and decides that the card should use only memory-mapped
> registers on PPC. It does this by writing 0 in the io space register, but
> doesn't disable IO accesses to the card in the PCI config header (or
> maybe they get re-enabled by the kernel fixup code). Also, I still have
> to check if the bit 0 is actually 0 or 1.
>
> However, Michel code doesn't see this and do it's fixup, causing a
> remapping of the io space to fe000000 instead of leaving 0, which may let
> some driver think the address was actually assigned. This is a problem
> since in theory, io 0 is perfectly valid, isn't it ? In this case, it
> should be considered wrong.

No, 0 is special: if you set all programmable bits to zero (an I/O space
BAR will always have the LSB set), the corresponding decoder is disabled
per the PCI specification. I know devices that do not respect this point
however, and it is a mess for I/O space on machines which have ISA since
it interfers with some ISA standard, well-known, devices.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
