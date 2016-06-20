Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY4z7020VzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:18:27 +1000 (AEST)
Date: Mon, 20 Jun 2016 11:18:18 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] tools/perf: Fix the mask in regs_dump__printf and
Message-ID: <20160620091818.GC27702@krava>
References: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 20, 2016 at 02:14:01PM +0530, Madhavan Srinivasan wrote:
> When decoding the perf_regs mask in regs_dump__printf(),
> we loop through the mask using find_first_bit and find_next_bit functions.
> "mask" is of type "u64", but sent as a "unsigned long *" to
> lib functions along with sizeof(). While the exisitng code works fine in
> most of the case, the logic is broken when using a 32bit perf on a
> 64bit kernel (Big Endian). We end up reading the wrong word of the u64
> first in the lib functions.

hum, I still don't see why this happens.. why do we read the
wrong word in this case?

thanks,
jirka

> first in the lib functions. Proposed fix is to swap the words of the
> u64 to handle this case. This is not endianess swap.
> 

SNIP
