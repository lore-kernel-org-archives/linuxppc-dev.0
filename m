Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 253B51A092A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 16:25:41 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 12 Feb 2015 00:25:39 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9AF59C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 00:16:48 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1C5PbVT26214652
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 05:25:37 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1C5PZBG002083
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 00:25:36 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 0/3] Silence "OPAL called with invalid token" errors
Date: Thu, 12 Feb 2015 16:25:26 +1100
Message-Id: <1423718729-17992-1-git-send-email-stewart@linux.vnet.ibm.com>
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

If OPAL firmware is called with an invalid token, that is, one that
the current running firmware does not support, it dumps an error into
its log. For three calls we were making in Linux, we were not adequately
checking that the current firmware supported them, so could get
this warning spuriously.

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
