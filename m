Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F280B6FB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 09:31:15 +1000 (EST)
Date: Mon, 23 May 2011 18:31:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] powerpc/mm: 64-bit 4k: use a PMD-based virtual page
	table
Message-ID: <20110523183100.36c54904@schlenkerla.am.freescale.net>
In-Reply-To: <1306183861.7481.208.camel@pasglop>
References: <20110518210528.GA29524@schlenkerla.am.freescale.net>
	<1305754435.7481.3.camel@pasglop>
	<20110520155719.32e51635@schlenkerla.am.freescale.net>
	<1305929736.7481.188.camel@pasglop>
	<20110523135433.557e2d63@schlenkerla.am.freescale.net>
	<1306183861.7481.208.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 24 May 2011 06:51:01 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Is your linear mapping bolted ? If it is you may be able to cut out most
> of the save/restore stuff (SRR0,1, ...) since with a normal walk you
> won't take nested misses.

It is bolted -- we ignore anything we can't map with 16 entries.  The only
semi-realistic case I can think of where we might bump into that (and thus
want non-bolted memory), especially with more than negligible loss compared
to the size of memory, is AMP with a non-zero start address where we have
to stick with smaller pages due to alignment. Even so, 16 times the
alignment of the start of RAM doesn't seem that unreasonable a limit.  The
32-bit limit of 3 entries for lowmem is a bit more troublesome there.

-Scott
