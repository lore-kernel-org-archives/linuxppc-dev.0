Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 54E92DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 20:28:46 +1000 (EST)
Subject: Re: PS3 early lock-up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0808051142160.18419@vixen.sonytel.be>
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
	<1217886287.24157.87.camel@pasglop> <1217886777.24157.91.camel@pasglop>
	<48979F6F.1050507@am.sony.com> <1217900430.24157.142.camel@pasglop>
	<Pine.LNX.4.64.0808051142160.18419@vixen.sonytel.be>
Content-Type: text/plain; charset=utf-8
Date: Tue, 05 Aug 2008 20:28:37 +1000
Message-Id: <1217932117.24157.185.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> arch/powerpc/platfroms/ps3/htab.c:ps3_hpte_updatepp() uses `htab[slot].v'.

Ah, I missed that one. Indeed it -is- used.

Ok, that leaves us with 2 options:

 - Change ps3_hpte_updatepp() to not read from the hash table via that
mapping (ie, do you have an LV1 call to read an HPTE ? Do you measure
any significant performance loss using that instead ? updatepp shouldn't
be something called -that- often).

 - Add a way to setup HPTEs using 3 PPP bits. I'm not going to implement
that for the main hash code just yet though (the assembly) but it might
be possible to implement it specifically for mappings bolted. That
means it would only work when the mapping is done early but on PS3, we
know that the hash table is always mapped early.

The later would be a matter of taking my ﻿htab_convert_pte_flags() function
and making it capable, when _PAGE_USER is _not_ set and _PAGE_RW is not
set neither, to set PPP to 110.

You could do that by adding:

	if (!(pteflags & (_PAGE_USER | _PAGE_RW)))
		rflags |= (1 << 1) | (1 << 63);

Dbl check that the resulting mapping isn't accessible to user space though.

Ben.
