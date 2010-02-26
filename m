Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6422B7CED
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 19:39:17 +1100 (EST)
Received: from sesr04.transmode.se (sesr04.transmode.se [192.168.201.15])
	by gw1.transmode.se (Postfix) with ESMTP id 57897650002
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 09:29:52 +0100 (CET)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] 8xx: Optimize TLB Miss code.
Date: Fri, 26 Feb 2010 09:29:39 +0100
Message-Id: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
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

Joakim Tjernlund (4):
  8xx: Optimze TLB Miss handlers
  8xx: Avoid testing for kernel space in ITLB Miss.
  8xx: Don't touch ACCESSED when no SWAP.
  8xx: Use SPRG2 and DAR registers to stash r11 and cr.

 arch/powerpc/kernel/head_8xx.S |   70 +++++++++++++++++++++++++++-------------
 1 files changed, 47 insertions(+), 23 deletions(-)
