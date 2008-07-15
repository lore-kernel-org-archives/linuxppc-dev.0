Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2ACF9DDF4C
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 07:58:23 +1000 (EST)
Message-Id: <BF59BFC7-736B-4D3F-9227-97DC90CE4739@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: SW TLB MMU rework and SMP issues
Date: Tue, 15 Jul 2008 16:58:16 -0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

I've been giving some thought to the new software managed TLBs and SMP  
issues.  I was wondering if you had any insights on how we should deal  
with the following issues:

* tlb invalidates -- need to ensure we don't have multiple tlbsync's  
on the bus.  I'm thinking for e500/fsl we will move to IPI based  
invalidate broadcast and do invalidates locally (http://patchwork.ozlabs.org/linuxppc/patch?id=19657 
)

* 64-bit PTEs and reader vs writer hazards.  How do we ensure that the  
TLB miss handler samples a consistent view of the pte.  pte_updates  
seem ok since we only update the flag word.  However set_pte_at seems  
like it could be problematic.

- k
