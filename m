Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19FE01A003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 09:25:13 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 18 Aug 2014 19:25:10 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id EEC1FC90042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 19:24:59 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7INP7Ho5767428
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 23:25:07 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7INP6bk027761
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Aug 2014 19:25:07 -0400
Date: Mon, 18 Aug 2014 16:25:05 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/perf/powerpc: Fix build break
Message-ID: <20140818232505.GA6955@us.ibm.com>
References: <1408004299-18986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1408004299-18986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.or
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I posted a patch for this to LKML last week:

	https://lkml.org/lkml/2014/8/7/77

Aneesh Kumar K.V [aneesh.kumar@linux.vnet.ibm.com] wrote:
|   CC       arch/powerpc/util/skip-callchain-idx.o
| arch/powerpc/util/skip-callchain-idx.c: In function =E2=80=98check_return=
_reg=E2=80=99:
| arch/powerpc/util/skip-callchain-idx.c:55:3: error: implicit declaration =
of function =E2=80=98pr_debug=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
|    pr_debug("dwarf_frame_register() %s\n", dwarf_errmsg(-1));
|=20
| Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
| ---
|  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 1 +
|  1 file changed, 1 insertion(+)
|=20
| diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/pe=
rf/arch/powerpc/util/skip-callchain-idx.c
| index a7c23a4b3778..d73ef8bb08c7 100644
| --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
| +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
| @@ -15,6 +15,7 @@
| =20
|  #include "util/thread.h"
|  #include "util/callchain.h"
| +#include "util/debug.h"
| =20
|  /*
|   * When saving the callchain on Power, the kernel conservatively saves
| --=20
| 1.9.1
|=20
| _______________________________________________
| Linuxppc-dev mailing list
| Linuxppc-dev@lists.ozlabs.org
| https://lists.ozlabs.org/listinfo/linuxppc-dev
