Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CE35DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 10:22:38 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id mABNMRon030396
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 10:22:27 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mABNMOgB207972
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 10:22:24 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mABNMOR4002830
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 10:22:24 +1100
Date: Wed, 12 Nov 2008 10:20:06 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [v2] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
Message-ID: <20081111232006.GA17193@yookeroo.seuss>
References: <a861cad705fe7ebccef3.1226359474@localhost.localdomain>
	<20081111125218.GA2266@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081111125218.GA2266@yoda.jdub.homelinux.org>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org, yanok@emcraft.com,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2008 at 07:52:18AM -0500, Josh Boyer wrote:
> On Mon, Nov 10, 2008 at 05:24:34PM -0600, Hollis Blanchard wrote:
> >The current CHIP11 errata truncates the device tree memory node, and subtracts
> >(hardcoded) 4096 bytes. This breaks kernels with larger PAGE_SIZE, since the
> >bootmem allocator assumes that total memory is a multiple of PAGE_SIZE.
> >
> >Instead, use a device tree memory reservation to reserve only the 256 bytes
> >actually affected by the errata, leaving the total memory size unaltered.
> >
> >Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> >
> >---
> >
> >Using large pages results in a huge performance improvement for KVM, and this
> >patch is required to make Ilya's large page patch work. David and/or Josh,
> >please apply.
> 
> The patch looks fine to me, and once David acks the fdt parts I'll apply
> for -next.  I'll try to do some testing later today as well, since I have
> one of the boards with the Errata.

Um.. I sent something the fdt stuff a while back, but didn't get a
response.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
