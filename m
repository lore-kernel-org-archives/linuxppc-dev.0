Return-Path: <brenohl@br.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 742251A0E1C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 07:49:32 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brenohl@br.ibm.com>;
 Tue, 19 Jan 2016 13:49:30 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4DC083E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 13:49:28 -0700 (MST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0JKnRV326869808
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 20:49:27 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0JKnR4L014251
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 15:49:27 -0500
Message-ID: <569EA155.5070602@br.ibm.com>
Date: Tue, 19 Jan 2016 18:49:25 -0200
From: Breno Leitao <brenohl@br.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
CC: Gustavo Bueno Romero <gromero@br.ibm.com>
Subject: Different SIGSEGV codes (x86 and ppc64le)
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During some debugging, we found that during a stack overflow, the SIGSEGV code
returned is different on Power and Intel.

We were able to narrow down the test case to the follow simple code:

  https://github.com/leitao/stack/blob/master/overflow.c

On Power, the SIGSEV si->si_code is 2 (SEGV_ACCERR) , meaning "access error". On
the other way around, the same test on x86 returns si->si_code = 1 (SEGV_MAPERR),
meaning "invalid permission". Any idea why such difference?

Example:

Power
-----
  $  gcc overflow.c
  $  ./a.out
  Got SIGSEGV(2) at address: 0x3fffdd90ffe0


x86
---
  $ gcc overflow.c
  $ ./a.out
  Got SIGSEGV(1) at address: 0x7fff9f089fe8


Thank you!
Breno
