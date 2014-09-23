Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB8261A0070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 02:26:48 +1000 (EST)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 21FA91400B7
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2014 02:26:47 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 10:26:45 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AC6991FF001D
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 10:15:27 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8NGQg6550724914
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 18:26:42 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8NGQfNQ013895
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 10:26:42 -0600
Date: Tue, 23 Sep 2014 09:26:23 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v5 1/1] powerpc/perf: Adjust callchain based on DWARF
 debug info
Message-ID: <20140923162623.GA1698@us.ibm.com>
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
 Maynard Johnson <mpjohn@us.ibm.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aaro Koskinen [aaro.koskinen@iki.fi] wrote:
| Hi,
| 
| On Wed, Jun 25, 2014 at 08:49:03AM -0700, Sukadev Bhattiprolu wrote:
| > powerpc/perf: Adjust callchain based on DWARF debug info
| > 
| > When saving the callchain on Power, the kernel conservatively saves excess
| > entries in the callchain. A few of these entries are needed in some cases
| > but not others. We should use the DWARF debug information to determine
| > when the entries are  needed.
| 
| This patch breaks perf compilation if DWARF support is not present.
| DWARF support is auto-detected early in the build, so IMHO either user
| should be informed to install the needed stuff, or the build should
| succeed with limited functionality.
| 
| arch/powerpc/util/skip-callchain-idx.c:13:19: fatal error: dwarf.h: No such file or directory #include <dwarf.h>
|                    ^
| compilation terminated.

Yes. Sorry. Anton fixed this recently:

	https://lkml.org/lkml/2014/9/19/29

Sukadev
