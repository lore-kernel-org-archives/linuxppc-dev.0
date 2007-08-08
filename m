Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE44EDDE99
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 00:50:10 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78Eo7Qr002029
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 10:50:07 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78Eo5L3247892
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 08:50:06 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78Eo1pB010516
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 08:50:01 -0600
Date: Wed, 8 Aug 2007 09:49:59 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070808094959.3ddd3751@weaponx.rchland.ibm.com>
In-Reply-To: <20070807042050.GJ13522@localhost.localdomain>
References: <20070807042050.GJ13522@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Todd Inglett <tinglett@us.ibm.com>, Volkmar Uhlig <vuhlig@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 7 Aug 2007 14:20:50 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The 440 family of processors don't have a tlbie instruction.  So, we
> implement TLB invalidates by explicitly searching the TLB with tlbsx.,
> then clobbering the relevant entry, if any.  Unfortunately the PID for
> the search needs to be stored in the MMUCR register, which is also
> used by the TLB miss handler.  Interrupts were enabled in _tlbie(), so
> an interrupt between loading the MMUCR and the tlbsx could cause
> incorrect search results, and thus a failure to invalide TLB entries
> which needed to be invalidated.
> 
> This patch fixes the problem in both arch/ppc and arch/powerpc by
> inhibiting interrupts (even critical and debug interrupts) across the
> relevant instructions.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

And I agree this should go into 2.6.23.

josh
