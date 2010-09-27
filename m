Return-Path: <nacc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EBC8DB70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 09:18:18 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8RN2mVg012592
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Sep 2010 19:02:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8RNHpRO410772
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Sep 2010 19:17:51 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8RNHpLf004816
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Sep 2010 20:17:51 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 0/2] Fix IRQ round-robing w/o irqbalance on pseries
Date: Mon, 27 Sep 2010 16:17:41 -0700
Message-Id: <1285629463-27699-1-git-send-email-nacc@us.ibm.com>
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

Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
