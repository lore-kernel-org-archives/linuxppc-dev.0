Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 29722DE007
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 23:33:41 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 13 Jan 2009 13:33:39 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090113123339.168500@gmx.net>
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 13 Jan 2009 16:01:42 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
> Betreff: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards

> > I think I throw away the IDE controller node for now, as libata just
> > reads the PCI register settings (progif) and I guess the IDE subsystem
> > will do the same in the future.
> 
> Well... if all AmigaOne use a 8259, they probably use the same interrupt
> routing except for PCI slots. In which case, I would -still- prefer if
> you had a proper interrupt tree, and at runtime or boot-wrapper time,
> fixed up the PCI host "interrupt-map" property to contain the right
> values for a given board.
That would be the ideal solution. But there is no reliable way to identify,
if the board is an AmigaOneSE, AmigaOneXE or an uA1. AFAIK the firmware
checks for a specifc onboard PCI sound chip to differentiate between an A1XE
and the uA1, but this sound chip is also used on various PCI sound cards.
I don't really like that approach.

> I'm not going to include the new platform in .29, it's way too late
> anyway (it should have been published a couple of weeks before the merge
> window at least I'd say) so we have some time til .30 to polish things a
> bit.
Okay. Some months more don't matter after all these years. :-)

> Another area to look at is to cleanup the non-coherent DMA thingy. The
> config option should just enable a set of non-coherent backend ops, but
> we should still be able to decide which ones to use (coherent vs.
> non-coherent) at runtime.
What about drivers that need to handle non coherent DMA differently
(e.g. because they map DMA memory to userspace)? Will the
"#ifdef CONFIG_NOT_COHERENT_CACHE" be replaced with calls to
dma_is_consistent()? (for example in the radeon driver, that you fixed for
non coherent DMA platforms in 2.6.25).
If I may express a wish: a reworked CPU feature fixup code for PPC32 will
avoid bigger problems with the AmigaOne platform in the future.

Thanks a lot!

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
