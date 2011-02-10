Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE58BB7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 08:57:17 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1ALbXON023123
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 16:37:39 -0500
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CF2E04DE8026
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 16:56:21 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1ALvD1E354184
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 16:57:13 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p1ALvCKv005807
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 16:57:13 -0500
Date: Thu, 10 Feb 2011 13:57:10 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH powerpc 0/2] powerpc CONFIG_PREEMPT fixes
Message-ID: <20110210215710.GA18429@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

This series provides fixes for a couple of CONFIG_PREEMPT problems on
Power:

1.	The hpte_need_flush() function accesses per-CPU variables without
	protection.
2.	The rtas_event_scan() function needs to use raw_smp_processor_id()
	to get a starting point to avoid debugging splats.

There are probably a few more where these came from.  ;-)

								Thanx, Paul
