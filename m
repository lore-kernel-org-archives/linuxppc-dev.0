Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0616DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 11:09:36 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id mAC08lfr018918
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 11:08:47 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAC09gtD4112384
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 11:09:42 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAC09XYt023335
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 11:09:33 +1100
Date: Wed, 12 Nov 2008 11:09:30 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
Message-ID: <20081112000930.GB17193@yookeroo.seuss>
References: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <700c59731cf97778d3a4.1226448406@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, yanok@emcraft.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2008 at 06:06:46PM -0600, Hollis Blanchard wrote:
> The current CHIP11 errata truncates the device tree memory node, and subtracts
> (hardcoded) 4096 bytes. This breaks kernels with larger PAGE_SIZE, since the
> bootmem allocator assumes that total memory is a multiple of PAGE_SIZE.
> 
> Instead, use a device tree memory reservation to reserve only the 256 bytes
> actually affected by the errata, leaving the total memory size unaltered.
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

libfdt usage changes look fine to me.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
