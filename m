Message-Id: <199909091814.UAA00323@piglet.cpu.lu>
Date: Thu, 9 Sep 1999 20:14:48 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PowerDomain 3940UWD
To: roikawa@rr.iij4u.or.jp
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19990910021436Q.roikawa@rr.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  10 Sep, this message from Ryuichi Oikawa echoed through cyberspace:
> I've tried Adaptec PowerDomain 3094UWD, dual channel UW SCSI card
> with PCI-PCI bridge and two SCSI controllers under the bridge,
> and I noticed driver related and OF related problems.
> 
> First I tried vger 2.2.12 kernel that caused machine check exception
> at first IO write transaction. I thought that this was normal because
> OF didn't properly set up P2P bridge's IO forwarding window.
> The real problem was this part(aic7xxx.c):
> 
> #ifdef MMAPIO
>           if ( !(temp_p->flags & AHC_MULTI_CHANNEL) ||
>                ((temp_p->chip != (AHC_AIC7870 | AHC_PCI)) &&
>                 (temp_p->chip != (AHC_AIC7880 | AHC_PCI))) )
>           {
> 	   ...... select MMIO and does ioremap ....
>            ...... if it fails select normal IO ....
> 	  }
> #endif
> 
> that rejected my SCSI card from MMIO forcing normal IO resulting in machin
> check. So I had to ignore this statement by #if !defined(__powerpc__) ...
> #endif statement.
> 
> Does anyone know what is this restriction for?

I could imagine that certain Adaptec SCSI chips use a regular PCI
memory region for their registers, while others use a PCI I/O region.
There are chances that the PCI I/O region is not enabled on your board,
and therefore accessing it results in a machine check.

Can you send me the output of lspci -vv, preferably once without the
aic7xxx driver in the kernel, and once with your fixes?

> After that aic7xxx.c properly detected two SCSI chips but entered in a
> timeout/resetting loop:-(  Apparently interrupts weren't fixed-up by
> pcibios_fixup.

IRQs do get fixed, even on devices behind P2P bridges... iff OF did
assing IRQs, that is, as you found below.

> So I scanned OF searching for correnct IRQ number and
> found it at AAPL,interrupts field of P2P bridge. SCSI controllers didn't
> have any AAPL,interrupts of course. It seems OF inserts AAPL,interrupts
> only at the top node of the slot when it detects a card in the physical
> slot. Therefore I had to change arch/ppc/kernel/prom.c as 
> 
[snip'ed code]

Your fix looks OK to me; on PowerMacs, all PCI devices in any one slot
share the same interrupt, as the four PCI interrupt pins are OR'ed
together per slot.

> I don't know if it is OF(PowerMac8500, OF 1.0.5) version specific,
> or SCSI card specific, or PowerMac OF nature. Any ideas?

Either OF-specific in general, or one of the many bugs in OF 1.0.5.
Anyway, as I said, your patch wouldn't break anything, even if OF did
assign IRQs already.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
