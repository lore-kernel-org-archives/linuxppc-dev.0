Return-Path: <hollisb@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 35178474C3
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 07:37:28 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mAIKWfaY021809
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 15:32:41 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAIKakg2153910
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 15:36:46 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAIKakDT032325
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 15:36:46 -0500
Subject: Re: [PATCH] [v3] powerpc/4xx: work around CHIP11 errata in a more
	PAGE_SIZE-friendly way
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <200811141609.44161.hollisb@us.ibm.com>
References: <4b6790c7a989dce8c200000687275224@bga.com>
	<84e16946c1ed4b782568f6492931512a@bga.com>
	<200811141609.44161.hollisb@us.ibm.com>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 14:33:32 -0600
Message-Id: <1227040412.5314.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-11-14 at 16:09 -0600, Hollis Blanchard wrote:
> 
> Basically my revised proposal is to add explicit memory reservation properties 
> to the device tree. Currently, "/memreserve" properties in .dts files are not 
> present in the device tree itself, only in the FDT header. I think these 
> reservations should be duplicated in the tree itself, so that they become 
> visible to post-boot tools like kexec.
> 
> In summary, all memory reservations will then exist both in the device tree 
> and in the FDT header. Comments?
> 
> Impact to uboot: revert memory node truncation; create reservation 
> and /memreserve property.
> 
> Impact to cuboot wrapper: revert memory node truncation; create reservation 
> and /memreserve property.
> 
> Impact to kernel: none. /memreserve will be ignored, since memory reservations 
> are already handled properly.
> 
> Impact to kexec-tools: Must take /memreserve into account when placing data 
> at "the end of memory".
> 
> If this is all too much, then I'm close to giving up and burning a 64KB page, 
> which requires only ALIGN_DOWN() in the kernel.

Any comments?

-- 
Hollis Blanchard
IBM Linux Technology Center
