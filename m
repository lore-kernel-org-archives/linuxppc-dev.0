Return-Path: <nacc@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DAA4FB70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 07:26:30 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o91LMMBR009653
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 15:22:22 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o91LQQrQ139342
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 15:26:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o91LQQ9i028477
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 15:26:26 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RESEND PATCH 0/2] Fix IRQ round-robing w/o irqbalance on pseries
Date: Fri,  1 Oct 2010 14:26:16 -0700
Message-Id: <1285968378-12805-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have received reports on power systems not running irqbalance where
all interrupts are being routed to CPU0 rather than being interleaved by
default across the system. Current firmware only allows either sending
interrupts to all CPUs or sending them to one CPU. The following two
patches address this issue by fixing the mask used in generic code and
by fixing the check for the "all" setting in the pseries code.

Nishanth Aravamudan (2):
  IRQ: use cpu_possible_mask rather than online_mask in setup_affinity
  pseries/xics: use cpu_possible_mask rather than cpu_all_mask

 arch/powerpc/platforms/pseries/xics.c |    2 +-
 kernel/irq/manage.c                   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
