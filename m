Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C6D51A18C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Oct 2014 05:02:10 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 8 Oct 2014 14:02:07 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AD0F738C8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 14:02:04 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s98I24um65929374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 18:02:04 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s98I23oD016107
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Oct 2014 14:02:04 -0400
Date: Wed, 8 Oct 2014 11:01:33 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/perf/powerpc: Fix build break
Message-ID: <20141008180133.GB7110@us.ibm.com>
References: <1408004299-18986-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87oatm3m26.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87oatm3m26.fsf@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, paulus@samba.org,
 linux-kernel@vger.kernel.or, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V [aneesh.kumar@linux.vnet.ibm.com] wrote:
| "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
|=20
| >   CC       arch/powerpc/util/skip-callchain-idx.o
| > arch/powerpc/util/skip-callchain-idx.c: In function =E2=80=98check_retu=
rn_reg=E2=80=99:
| > arch/powerpc/util/skip-callchain-idx.c:55:3: error: implicit declaratio=
n of function =E2=80=98pr_debug=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
| >    pr_debug("dwarf_frame_register() %s\n", dwarf_errmsg(-1));
| >
| > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
| > ---
| >  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 1 +
| >  1 file changed, 1 insertion(+)
| >
| > diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/=
perf/arch/powerpc/util/skip-callchain-idx.c
| > index a7c23a4b3778..d73ef8bb08c7 100644
| > --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
| > +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
| > @@ -15,6 +15,7 @@
| >
| >  #include "util/thread.h"
| >  #include "util/callchain.h"
| > +#include "util/debug.h"
| >
| >  /*
| >   * When saving the callchain on Power, the kernel conservatively saves
|=20
| We still have this broken upstream.

The fix is in Ingo's tree, commit ad7e767.

Ingo, can you push this fix to Linus - it fixes a build failure in
Powerpc.

Sukadev


|=20
| -aneesh
|=20
| _______________________________________________
| Linuxppc-dev mailing list
| Linuxppc-dev@lists.ozlabs.org
| https://lists.ozlabs.org/listinfo/linuxppc-dev
