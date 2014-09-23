Return-Path: <jolsa@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7A891A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 16:59:32 +1000 (EST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5721F14007B
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 16:59:31 +1000 (EST)
Date: Tue, 23 Sep 2014 08:59:06 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v5 1/1] powerpc/perf: Adjust callchain based on DWARF
 debug info
Message-ID: <20140923065906.GA2979@krava.brq.redhat.com>
References: <20140625000052.GA4484@us.ibm.com>
 <20140625074248.GC1153@krava.brq.redhat.com>
 <20140625154903.GA29607@us.ibm.com>
 <20140922213345.GB666@drone.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140922213345.GB666@drone.musicnaut.iki.fi>
Cc: Michael Ellerman <michaele@au1.ibm.com>, ulrich.weigand@de.ibm.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linuxppc-dev@ozlabs.org,
 Maynard Johnson <mpjohn@us.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 23, 2014 at 12:33:45AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jun 25, 2014 at 08:49:03AM -0700, Sukadev Bhattiprolu wrote:
> > powerpc/perf: Adjust callchain based on DWARF debug info
> > 
> > When saving the callchain on Power, the kernel conservatively saves excess
> > entries in the callchain. A few of these entries are needed in some cases
> > but not others. We should use the DWARF debug information to determine
> > when the entries are  needed.
> 
> This patch breaks perf compilation if DWARF support is not present.
> DWARF support is auto-detected early in the build, so IMHO either user
> should be informed to install the needed stuff, or the build should
> succeed with limited functionality.
> 
> arch/powerpc/util/skip-callchain-idx.c:13:19: fatal error: dwarf.h: No such file or directory #include <dwarf.h>
>                    ^
> compilation terminated.

looks like powerpc issue.. hows 'make -f tests/make' doing
on powerpc? It tests above scenario.

jirka
