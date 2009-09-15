Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80414B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 19:45:25 +1000 (EST)
Subject: Re: Oops in IDE probing on ppc_440 when PCI is enabled in strapping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ludo Van Put <ludo.vanput@gmail.com>
In-Reply-To: <5edaeed70909150157n59745b92qe9abf2ed13147288@mail.gmail.com>
References: <5edaeed70909140536s53fb36ael4f0cb90abfe327e0@mail.gmail.com>
	<20090914125129.GB12372@zod.rchland.ibm.com>
	<5edaeed70909140608m3ddcda33y7f92b2dfd18ca92e@mail.gmail.com>
	<1252975341.8375.167.camel@pasglop>
	<5edaeed70909150157n59745b92qe9abf2ed13147288@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 19:44:55 +1000
Message-Id: <1253007895.8375.212.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-15 at 10:57 +0200, Ludo Van Put wrote:
> Thnx for the suggestion, but the ide_insw is in fact of copy of the
> _insw assembly routine, and it gets passed
> the effective address, without the _IO_BASE offset.
> 
> I was thinking about TLB stuff. I'm not a u-boot expert, but could it
> be that I need to tweak/reconfigure u-boot so I can access the address
> returned from ioremap64?

No. If you pass the right physical address to ioremap64, the result
should be useable as-is. The TLB entries will be faulted in
automatically by the kernel when doing accesses.

At this stage, I can't say what's wrong, it looks like you may be
accessing the wrong virtual address or something like that. Hard to
tell. It's a data access exception, not a machine check, so that means
that in some ways, the virtual address accessed by ide_insw is not
mapped by the kernel page tables, which is what the kernel TLB miss
handler uses to populate the TLB.

2.6.10 is so old, that I really have little memories of what is going on
in that area and I'm afraid am of little help here. If you have a HW
debugger such as a BDI, you may want to trace through the access, what
kind of TLB faults it generates and why the TLB miss handler doesn't
handle it.

Cheers,
Ben.
