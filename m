Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 633BDB7D42
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 02:37:21 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
Subject: [PATCH 0/4] 8xx: Optimize TLB Miss code.
Date: Tue, 2 Mar 2010 16:37:08 +0100
Message-Id: <1267544232-14784-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of tries to optimize the TLB code on 8xx even
more. If they work, it should be a noticable performance
boost.

I would be very happy if you could test them for me.

 - v2:
   Since Scott has done some testing of these patches I resend
   them with my SOB.
   Scott, can you "bless" these patches too?

Joakim Tjernlund (4):
  8xx: Optimze TLB Miss handlers
  8xx: Avoid testing for kernel space in ITLB Miss.
  8xx: Don't touch ACCESSED when no SWAP.
  8xx: Use SPRG2 and DAR registers to stash r11 and cr.

 arch/powerpc/kernel/head_8xx.S |   70 +++++++++++++++++++++++++++-------------
 1 files changed, 47 insertions(+), 23 deletions(-)
