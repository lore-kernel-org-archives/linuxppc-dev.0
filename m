Subject: Re: dma_alloc_init badness ??
From: David Woodhouse <dwmw2@infradead.org>
To: "Demke, Torsten" <Torsten.Demke@fci.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <9CFB9DA5261CD611A29B00508B7890480B842F73@ex-deu-munich02.force.de>
References: 
	 <9CFB9DA5261CD611A29B00508B7890480B842F73@ex-deu-munich02.force.de>
Content-Type: text/plain
Date: Tue, 20 Jul 2004 18:00:57 -0400
Message-Id: <1090360857.9473.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-07-20 at 13:26 +0200, Demke, Torsten wrote:
> Hello all,
>
> Im currently porting our application from 2.4.22 to 2.6.
> CPU is MPC852T and the bootloader is u-boot.
>
> The kernel boot prints a warning in dma_alloc_init,
> but Im not sure what that exactly means, and how to solve
> the problem:(
> Can anybody here please give me some help?

	...

> Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:342

The warning at line 342 of dma-mapping.c is:

		WARN_ON(!pmd_none(*pmd));

It's bitching that there's already a page table entry at the virtual
address you've given as CONFIG_CONSISTENT_START. The range specified by
CONFIG_CONSISTENT_START and CONFIG_CONSISTENT_SIZE must be a range of
_virtual_ addresses which are unused in your kernel.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
