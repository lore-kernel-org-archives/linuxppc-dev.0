Date: Mon, 8 Sep 2003 15:14:59 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: virt_to_phys() on 440
Message-ID: <20030908151459.A16761@home.com>
References: <20030908213638.4000.qmail@web40910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030908213638.4000.qmail@web40910.mail.yahoo.com>; from bkuschak@yahoo.com on Mon, Sep 08, 2003 at 02:36:38PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 08, 2003 at 02:36:38PM -0700, Brian Kuschak wrote:
>
> I think the virt_to_phys() function is incorrect for
> PPC440.  It should call iopa for all 4xx, not only the
> 405.  By chance, it happens to work currently if the
> address is in SDRAM, but is always incorrect for
> ioremapped addresses.  virt_to_bus() does the right
> thing.
>
> Also, to be correct, shouldn't this function return a
> phys_addr_t rather than an unsigned long, as the
> physical address is >32 bits on 44x?

Read IO-mapping.txt and DMA-mapping.txt

PPC40x is incorrect.  These APIs are valid only for system
memory kernel addresses that are staticly mapped.

Anything wanting a generic translation from virt->phys should
call iopa() directly until somebody drives a generic translation
API into the kernel.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
