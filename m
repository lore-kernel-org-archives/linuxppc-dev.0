Return-Path: <Qingtao.Cao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 833A8DE077
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 20:04:06 +1000 (EST)
From: Harry Ciao <qingtao.cao@windriver.com>
To: benh@kernel.crashing.org, bluesmoke-devel@lists.sourceforge.net
Subject: [v1 PATCH 0/4] Add INT mode support for EDAC drivers on Maple
Date: Mon, 18 May 2009 18:04:56 +0800
Message-Id: <1242641100-15324-1-git-send-email-qingtao.cao@windriver.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Ben,

This is the v2 patches that have integrated your suggestions to
remove the refcount for a hwriq2virq mapping as long as we don't
dispose it, the changes are mostly within the 1/4 patch where the
unnecessary refcount and irqmap structure are removed, and callings
to edac_put_mpic_irq() are also removed from the rest of patches.

Since there are 3 EDAC modules on Maple will use one same copy of
code to create hwirq2virq mappings, I perfer to preserve it in
edac_mpic_irq.c.

How do feel about the assumption that MPIC will latch INT 0 pin for 
the NMI Reqeust Messages whose vector is == 0? This is the thing that
I have least confidence in, so far all I can get is the brief
introduction in CPC925 user manual that "This interrupt vector is used
to set a corresponding interrupt latch", P111, so I think it imples that
vector==0 will latch pin #0.

Many thanks for all your comments!

Best regards,

Harry
