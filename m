From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Timothy A. Seufert" <tas@mindspring.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: tulip (was Re: any easy way to force 10/100 nics to 10?)
Date: Tue, 30 Oct 2001 20:30:53 +0100
Message-Id: <20011030193053.2256@smtp.wanadoo.fr>
In-Reply-To: <p05101000b7fe0531e893@[10.0.0.42]>
References: <p05101000b7fe0531e893@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Speaking of tulip and PPC, I think I sent you the attached endianness fix
>for ADMTek Comet chips a while back, but it doesn't appear to have gotten
>into any trees yet.  The first and last parts fix problems where the
>ethernet MAC address would get mangled during the process of reading &
>writing the hardware MAC address registers.  The middle part does the same
>for the write to the multicast hash filter registers (which appear to be
>similar to the MAC address registers).  I don't know how to test multicast
>so I don't know if that part of the patch is necessary, but the MAC address
>fix is necessary to get the chip working properly on PPC (& other BE cpus).
>
>I still have problems with poor Tx performance on PPC.  In an x86 notebook,
>the card can transmit with full 100 Mbps throughput, but in two different
>PPC notebooks it only manages ~20-30 Mbps.  Both architectures receive at
>100 Mbps.  Haven't figured out what's going on there.
>
>What's really needed for accessing the MAC and multicast hash registers are
>nonswapping forms of outl and inl.  I looked at insl_ns and outsl_ns but
>they appeared to be enough different in implementation from outl and inl
>that I didn't want to risk using them (the calculation of the I/O address
>appeared to be different, at least on PPC).

insl_ns and outsl_ns are "stream" (or string) versions, they are used to
read/write fifos. Address calc. should be the same, but they don't have,
I beleive, the protection against machine check we have in inl/outl.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
