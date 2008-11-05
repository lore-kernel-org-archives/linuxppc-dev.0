Return-Path: <linuxppc-dev@ml.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED215DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 19:16:46 +1100 (EST)
Date: Wed, 5 Nov 2008 09:16:39 +0100
From: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: "Introduce local (non-broadcast) forms of tlb invalidates"
	causes BUG()
Message-ID: <20081105081639.GA25005@Chamillionaire.breakpoint.cc>
References: <20081102151902.GA11120@Chamillionaire.breakpoint.cc>
	<Pine.LNX.4.64.0811041507320.8751@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <Pine.LNX.4.64.0811041507320.8751@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2008-11-04 15:10:42 [-0600]:

>Can you try this fix and let me know if it works for you:
>
>---
> arch/powerpc/kernel/misc_32.S |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
>
>diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
>index 6a9b4bf..5953232 100644
>--- a/arch/powerpc/kernel/misc_32.S
>+++ b/arch/powerpc/kernel/misc_32.S
>@@ -470,6 +470,7 @@ _GLOBAL(_tlbil_pid)
> 	mfspr	r3,SPRN_MMUCSR0
> 	andi.	r3,r3,MMUCSR0_TLBFI@l
> 	bne	1b
>+	msync
> 	blr
>
> /*

Yep, it helps. Thx Kumar.

Sebastian
