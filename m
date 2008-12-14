Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C1DADDF63
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 13:46:09 +1100 (EST)
Subject: Re: [PATCH][for 2.6.28] powerpc/fsl-booke: Fix problem with
	_tlbil_va being interrupted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <1229211183-5350-1-git-send-email-galak@kernel.crashing.org>
References: <1229211183-5350-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 14 Dec 2008 13:46:02 +1100
Message-Id: <1229222762.26324.19.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-12-13 at 17:33 -0600, Kumar Gala wrote:
> An example calling sequence which we did see:
> 
> copy_user_highpage -> kmap_atomic -> flush_tlb_page -> _tlbil_va
> 
> We got interrupted after setting up the MAS registers before the
> tlbwe and the interrupt handler that caused the interrupt also did
> a kmap_atomic (ide code) and thus on returning from the interrupt
> the MAS registers no longer contained the proper values.
> 
> Since we dont save/restore MAS registers for normal interrupts we
> need to disable interrupts in _tlbil_va to ensure atomicity.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Paul, this is a 2.6.28 regression, it should probably go to Linus in
case he hasn't released yet :-)

Cheers,
Ben.
