Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C82401A09CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 11:04:03 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 19:04:00 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8AFE238C807D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 19:00:17 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1I03wqe20840622
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 00:03:58 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1I03vdB030427
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 19:03:58 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 0/3] powerpc/powernv: Correctly detect optional OPAL calls
Date: Wed, 18 Feb 2015 11:03:41 +1100
Message-Id: <1424217824-30596-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series fixes three possible warnings that OPAL firmware would emit
when booting on hardware/simulator that didn't support certain functionality.

The correct thing for Linux to do is to detect firmware capability
by using the OPAL_CHECK_TOKEN call or examining device tree. In the case
of these three warnings, it was OPAL_CHECK_TOKEN.

Stewart Smith (3):
  powerpc/powernv: only register log if OPAL supports doing so
  powerpc/powernv: only call OPAL_ELOG_RESEND if firmware supports it
  powerpc/powernv: only call OPAL_RESEND_DUMP if firmware supports it

 arch/powerpc/platforms/powernv/opal-dump.c |    3 ++-
 arch/powerpc/platforms/powernv/opal-elog.c |    3 ++-
 arch/powerpc/platforms/powernv/opal.c      |    6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
1.7.10.4
