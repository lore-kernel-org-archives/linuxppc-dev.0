Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdNrm5jLrzDvgm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 02:28:24 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tdNrm0SjKz9t0q
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2016 02:28:23 +1100 (AEDT)
Message-ID: <1481642851.17253.72.camel@kernel.crashing.org>
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>
Date: Tue, 13 Dec 2016 09:27:31 -0600
In-Reply-To: <1481607371.11971.1.camel@gmail.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
 <20161212233111.1712ba79@roar.ozlabs.ibm.com>
 <1481607371.11971.1.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-13 at 16:36 +1100, Balbir Singh wrote:
> Yep, although the code works for PPC_XICS only which is good for now.
> When we do XIVE, we can add more bits

We may want to do XIVE differently, dunno. On XIVE we can just poke the
processor priority with a single MMIO store, so we don't actually need
to "fetch" the interrupt and we can continue doing separate priorities.

Note that raising the priority would work on XICS in *theory* as well
but HW bugs get in the way if we do that.

We also need to make sure you either adjust MPIC and all other PICs
potentially used on ppc64 to do this "only one priority" thing or you
disable that new mechanism on all those PICs.

That's why I mentioned opt-in. Maybe make it conditional on a global
boolean that gets enabled by the PIC itself, or make it an enum

enum lazy_irq_masking_mode {
	lazy_irq_mask_ee,	/* Use CPU EE bit (default) */
	lazy_irq_mask_fetch,	/* Fetch the interrupt and stash it away */
	lazy_irq_mask_prio	/* Change processor priority */
};

For the latter we'd need a ppc_md. hook to do the priority change
which xive (and potentially others like MPIC) could use.

Cheers,
Ben.
