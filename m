Date: Mon, 10 Mar 2003 21:11:51 -0700
From: Matt Porter <porter@cox.net>
To: Jeff Boyd <jeff.boyd@att.net>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 36 bit DMA address on IBM 440 PPC
Message-ID: <20030310211151.A23781@home.com>
References: <200303101316.HAA25661@lists.linuxppc.org> <20030310071217.A22215@home.com> <3E6D34CB.62007516@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E6D34CB.62007516@att.net>; from jeff.boyd@att.net on Mon, Mar 10, 2003 at 07:58:51PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 10, 2003 at 07:58:51PM -0500, Jeff Boyd wrote:
> Is it to be 64 bit, or will the ref be more abstract and come from an
> /asm/ architecture specific include? It seems to me that in general it
> would be better to make things that hold or return or take a physical
> address reference it as such (e.g. phys_addr_t) rather than declare it
> to be some data size (e.g. unsigned long [long]), since data bus and
> address bus sizes are not necessarily in sync for size. Thus my vote for
> a separate architecture specific data type for physical address.

The discussion on lkml suggested that Linus wants resources on all
platforms to be 64 bits, period.  Of course, the driving factor is
to handle some ia32 PAE management in a better manner.  One thing
to keep in mind is that resources are not necessarily a CPU physical
address (although most platforms define them as such), they are defined
as an 'ioremapable token'.  In the same manner, ioremap produces a
token which can be passed to read*/write*, in most implementations
that token is a virtual address which dereference directly (though
that is cheating the API).  One thing that makes a u64 resource
convenient is that there is no abstraction necessary to printk
info/warnings involving resource values.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
