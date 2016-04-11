Return-Path: <millerjo@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkK9g5MM6zDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 04:59:19 +1000 (AEST)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <millerjo@us.ibm.com>;
 Mon, 11 Apr 2016 12:59:16 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 137DE3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 12:59:14 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3BIxDAD38010908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 11:59:13 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3BIxD92013098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 12:59:13 -0600
From: Jack Miller <jack@codezen.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: michaele@au1.ibm.com, michael.neuling@au1.ibm.com
Subject: [RFC] P9 ldmx support 
Date: Mon, 11 Apr 2016 13:57:42 -0500
Message-Id: <1460401065-10540-1-git-send-email-jack@codezen.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All -

These are patches based on next to support the forthcoming ldmx instruction
through the existing P8 EBB infrastructure. Obviously it doesn't actually
*work* without some other patches and a P9 system, but with the context
switch change to FSCR it makes sense to get this upstream for testing ASAP.

The first patch context switches FSCR per thread so that the second patch can
lazily enable this feature (FSCR.LM) with a facility unavailable exception
and context switch two new ldmx registers (LMRR / LMSER) per thread as well.
Third patch is a couple of basic tests.

Any comments welcome.

- Jack
