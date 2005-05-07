Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D66A679EF
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 May 2005 06:24:12 +1000 (EST)
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHGEJMCLAA.Joakim.Tjernlund@lumentis.se>
References: <BCEFJBPJCGFCNMMMIDBHGEJMCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <779d257b5aa25f341bc452dabf5987c4@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 7 May 2005 16:24:01 -0400
To: <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 7, 2005, at 2:10 PM, Joakim Tjernlund wrote:

> Not completly sure that this is correct. There are a few:
> 	addi	r10, r10, 0x0100
>  	mtspr	SPRN_MD_CTR, r10
> later on which will "overflow" 0x1f00 into 0x2000 etc.

Oh right, I forgot I did that.  I explicitly set the tlb index before
each write.  Sorry, I thought it was due to more bits of index
in the 885.

So, I guess what was there should have worked.

OK, so the reason TLB pinning doesn't work is a tlbie() can
evict the pinned entry.  That stupid code in the cpm reset
will throw them out, plus anything else that would do a
tlbie() of a kernel address within the pinned space (like
the update_mmu_cache() hack).  We have to fix those,
and look for any others where that may happen.

Thanks.


	-- Dan
