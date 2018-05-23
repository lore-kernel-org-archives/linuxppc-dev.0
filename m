Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rhPy4K8vzF145
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 04:49:25 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4NIi0f2130709
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:23 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j5axdrxtw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 14:49:22 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 23 May 2018 12:49:22 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [PATCH net-next 0/8] ibmvnic: Failover hardening
Date: Wed, 23 May 2018 13:37:54 -0500
Message-Id: <1527100682-23099-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce additional transport event hardening to handle
events during device reset. In the driver's current state,
if a transport event is received during device reset, it can
cause the device to become unresponsive as invalid operations
are processed as the backing device context changes. After
a transport event, the device expects a request to begin the
initialization process. If the driver is still processing
a previously queued device reset in this state, it is likely
to fail as firmware will reject any commands other than the
one to initialize the client driver's Command-Response Queue.

Instead of failing and becoming dormant, the driver will make
one more attempt to recover and continue operation. This is
achieved by setting a state flag, which if true will direct
the driver to clean up all allocated resources and perform
a hard reset in an attempt to bring the driver back to an
operational state.

Thomas Falcon (8):
  ibmvnic: Mark NAPI flag as disabled when released
  ibmvnic: Introduce active CRQ state
  ibmvnic: Check CRQ command return codes
  ibmvnic: Return error code if init interrupted by transport event
  ibmvnic: Handle error case when setting link state
  ibmvnic: Create separate initialization routine for resets
  ibmvnic: Set resetting state at earliest possible point
  ibmvnic: Introduce hard reset recovery

 drivers/net/ethernet/ibm/ibmvnic.c | 223 +++++++++++++++++++++++++++++++++----
 drivers/net/ethernet/ibm/ibmvnic.h |   2 +
 2 files changed, 202 insertions(+), 23 deletions(-)

-- 
2.7.5
