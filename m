Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F7AEDDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 04:33:40 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBHHW9aC030663
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 10:32:09 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBHHXYou137142
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 10:33:34 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBHHXWET022047
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 10:33:33 -0700
Date: Wed, 17 Dec 2008 12:33:29 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/16] powerpc/4xx: Extended DCR support v2
Message-ID: <20081217173329.GD3049@localhost.localdomain>
References: <1229319836.100184.344640589620.qpush@grosgo>
	<20081215054516.146BFDDFAB@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081215054516.146BFDDFAB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 15, 2008 at 04:44:17PM +1100, Benjamin Herrenschmidt wrote:
>This adds supports to the "extended" DCR addressing via
>the indirect mfdcrx/mtdcrx instructions supported by some
>4xx cores (440H6 and later)
>
>I enabled the feature for now only on AMCC 460 chips
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

I actually ran some tests on this patch on a Bamboo board that
lacks the new instructions.  While tbench might not be great here,
it's the thing I had handy and it does drive some DCR access given
that every interrupt uses DCR instructions to handle the UIC bits
(and some of the MAL stuff I'm assuming).

The results with and without the patch were pretty close.
Differences were in the noise range.  I wanted to test on
Canyonlands, which does have the new instructions, but mine
appears to be DOA.

So in summary, it doesn't make things worse :).

josh
