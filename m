Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FE421A0FDE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 04:24:18 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 17:24:13 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 026921B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:24:47 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FHOAYe54919302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 17:24:10 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FHO9QF028083
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 10:24:09 -0700
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH] pseries/le: Fix another endiannes issue in RTAS call from xmon
Date: Thu, 15 Jan 2015 18:23:47 +0100
Message-Id: <1421342627-7214-1-git-send-email-ldufour@linux.vnet.ibm.com>
In-Reply-To: <1421295950.11409.3.camel@ellerman.id.au>
References: <1421295950.11409.3.camel@ellerman.id.au>
Cc: paulus@samba.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit 3b8a3c010969 ("powerpc/pseries: Fix endiannes issue in RTAS
call from xmon") was fixing an endianness issue in the call made from
xmon to RTAS.

However, as Michael Ellerman noticed, this fix was not complete, the
token value was not byte swapped. This lead to call an unexpected and
most of the time unexisting RTAS function, which is silently ignored
by RTAS.

This fix addresses this hole.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 5b150f0c5df9..13c6e200b24e 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -337,6 +337,7 @@ static inline void disable_surveillance(void)
 	args.token = rtas_token("set-indicator");
 	if (args.token == RTAS_UNKNOWN_SERVICE)
 		return;
+	args.token = cpu_to_be32(args.token);
 	args.nargs = cpu_to_be32(3);
 	args.nret = cpu_to_be32(1);
 	args.rets = &args.args[3];
-- 
1.9.1
