Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E158DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 04:36:22 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78IaEAl018711
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:36:14 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78IaEmO469294
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:36:14 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78IaEDq008900
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 14:36:14 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, general@lists.openfabrics.org
Subject: [PATCH 0/7] IB/ehca: support for user space small queues,
	support more than 4k queue pairs, generate last WQE reached
Date: Wed, 8 Aug 2007 20:36:11 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708082036.12684.ossrosch@linux.vnet.ibm.com>
Cc: craisch@de.ibm.com, Hoang-Nam Nguyen <Hoang-Nam.Nguyen@dyn-9-152-249-53>,
	fenkes@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch set against Roland's git, branch for-2.6.23 for ehca.
It enables userspace support for small QP feature and make some fixes for it. 
Also there is add the mapping of 4k firmware context to user space.

They are in details:
[1/7] add support for userspace small queues and make some fixes
[2/7] ensure that a non-existing queues in case of SRQs are not interprete as 
small queues
[3/7] we have no longer to add 1 to the number of requestet wqes, because
firmware does now
[4/7] make changes to ehca_mmap() to support more than 4k queues 
[5/7] map 4k firmware context of cq, qp to user space
[6/7] generate last WQE reached, when base QP for SRQ has entered error state
[7/7] prevent overwriting QP init attributes given by caller

The patches should apply cleanly, in order, against Roland's git. Please
review the changes and apply the patches if they are okay.

Regards,
Stefan
