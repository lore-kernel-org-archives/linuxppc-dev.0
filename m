Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88C4ADE8F1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 02:39:59 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69GdukZ022873
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 12:39:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m69GduaK212948
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 12:39:56 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m69Gdtuc006419
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 12:39:55 -0400
Date: Wed, 9 Jul 2008 12:36:33 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: rework 4xx PTE access and TLB miss
Message-ID: <20080709123633.72758580@zod.rchland.ibm.com>
In-Reply-To: <20080709102308.4735d48a@zod.rchland.ibm.com>
References: <20080708055449.EDFDADDEF5@ozlabs.org>
	<20080709102308.4735d48a@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jul 2008 10:23:08 -0400
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Tue, 08 Jul 2008 15:54:40 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This is some preliminary work to improve TLB management on SW loaded
> > TLB powerpc platforms. This introduce support for non-atomic PTE
> > operations in pgtable-ppc32.h and removes write back to the PTE from
> > the TLB miss handlers. In addition, the DSI interrupt code no longer
> > tries to fixup write permission, this is left to generic code, and
> > _PAGE_HWWRITE is gone.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Boots for me now.  So far it's surviving a dbench run, and I'll try
> hackbench/kernbench shortly.

For those interested, here are the results of my stupidly simple
hackbench runs:

Setup: 

- AMCC PowerPC Sequoia 440EPx board, 128MiB of DRAM, 533 MHz CPU
clock
- NFS rootfs over 100MBit ethernet
- soft-float userspace

Times were gathered by booting to a prompt, running five 'hackbench 50'
tests, and averaging the results.

sequoia_defconfig:       Avg time - 48.1118 seconds
sequoia_defconfig+patch: Avg time - 47.8996 seconds

I consider that difference to be in the noise range, but the important
thing is that it doesn't show a regression in performance.

Feel free to flame away at my lame testing.  I didn't have the setup or
time to do much else at the moment.

josh
