Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D39DB68046
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2005 13:02:09 +1000 (EST)
Date: Mon, 22 Aug 2005 23:56:45 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050823025645.GG9667@dmt.cnet>
References: <1124317852.24373.13.camel@localhost.localdomain>
	<8DC63AB4-C547-4023-BE7F-46176BC71535@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8DC63AB4-C547-4023-BE7F-46176BC71535@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: When are machine checks suppose to be recoverable?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 17, 2005 at 10:42:12PM -0500, Kumar Gala wrote:
> 
> On Aug 17, 2005, at 5:30 PM, David Woodhouse wrote:
> 
> >On Thu, 2005-08-18 at 07:44 +1000, Benjamin Herrenschmidt wrote:
> >
> >>On Wed, 2005-08-17 at 09:00 -0500, Kumar Gala wrote:
> >>
> >>>David's 8250 cleanup patch made me wondering when are machine checks
> >>>
> >
> >
> >>>suppose to recoverable?  General class of conditions is what I'm
> >>>looking for here.
> >>>
> >>>Is David's case due to some PCI master abort or something else?
> >>>
> >>
> >>Might be some issue on SMP machines...
> >>
> >
> >Yeah, that'll probably be the reason it turns out _not_ to be
> >recoverable despite our expectations. But that wasn't Kumar's  
> >question.
> 
> David's right, that wasn't my question :)  I was asking more about  
> what cases do we actually recover and that is considered correct  
> behavior.

Quoting David:

"My dual G4 PowerMac crashes sometimes when it probes for the (absent)
serial ports. Theoretically it's supposed to take a machine check and
recover -- but it doesn't always work like that."

Maybe you just need the proper entry in the exception table for IO
inb/outb?

Is there a stacktrace, David?

arch/ppc/kernel/traps.c:

/*
 * I/O accesses can cause machine checks on powermacs.
 * Check if the NIP corresponds to the address of a sync
 * instruction for which there is an entry in the exception
 * table.
 * Note that the 601 only takes a machine check on TEA
 * (transfer error ack) signal assertion, and does not
 * set any of the top 16 bits of SRR1.
 *  -- paulus.
 */
static inline int check_io_access(struct pt_regs *regs)
{
#ifdef CONFIG_PPC_PMAC
        unsigned long msr = regs->msr;
        const struct exception_table_entry *entry;
        unsigned int *nip = (unsigned int *)regs->nip;

        if (((msr & 0xffff0000) == 0 || (msr & (0x80000 | 0x40000)))
            && (entry = search_exception_tables(regs->nip)) != NULL) {
