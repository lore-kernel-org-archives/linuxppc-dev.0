Subject: Re: address translation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ppc339@vtnet.ca
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200305150729.36436.ppc339@vtnet.ca>
References: <200305150729.36436.ppc339@vtnet.ca>
Content-Type: text/plain
Message-Id: <1053007531.2561.38.camel@gaston>
Mime-Version: 1.0
Date: 15 May 2003 16:05:31 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-05-15 at 13:29, Trevor Woerner wrote:
> I want to setup a mapping so that when anything tries to read/write the
> 16 bytes at 0x1f0 - 0x1ff the actual physical memory that gets accessed
> is 0xf7000000 - 0xf700000f.

I would say you are taking the problem backward.

Tell us more about what you are doing. Looks like you have some IDE mapped
at 0xf7000000+. You need to tell IDE to use those. What kind of PPC CPU is
this ? IDE by default uses inx/outx accesses, which are relative to
_IO_BASE. So you just need to pass IDE some addresses that when offsetted
with _IO_BASE will fall in an ioremap'ed mapping of 0xf7000000

There is no MMU trick involved

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
