Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D73ABDDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jan 2007 12:11:52 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0JLrDAh080860
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 21:53:13 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0JLrDKY1568810
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 22:53:13 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0JLrCAI030599
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 22:53:12 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org
Subject: [PATCH 2.6.20 0/2] ehca: fix yield and spinlock conflicts
Date: Fri, 19 Jan 2007 22:49:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701192249.33587.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland!
Here is patch set for ehca with the following bug fixes:
* Fix unproper use of yield within spinlock context
* Fix mismatched spin_unlock in irq handler
Thanks
Nam


 ehca_cq.c  |    5 ++++-
 ehca_irq.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
