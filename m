Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY5SB5YZPzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:40:10 +1000 (AEST)
Date: Mon, 20 Jun 2016 11:40:03 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] tools/perf: Fix the mask in regs_dump__printf and
Message-ID: <20160620094003.GA32172@krava>
References: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160620091818.GC27702@krava> <5767B6FD.4080708@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5767B6FD.4080708@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 20, 2016 at 05:27:25PM +0800, Wangnan (F) wrote:
> 
> 
> On 2016/6/20 17:18, Jiri Olsa wrote:
> > On Mon, Jun 20, 2016 at 02:14:01PM +0530, Madhavan Srinivasan wrote:
> > > When decoding the perf_regs mask in regs_dump__printf(),
> > > we loop through the mask using find_first_bit and find_next_bit functions.
> > > "mask" is of type "u64", but sent as a "unsigned long *" to
> > > lib functions along with sizeof(). While the exisitng code works fine in
> > > most of the case, the logic is broken when using a 32bit perf on a
> > > 64bit kernel (Big Endian). We end up reading the wrong word of the u64
> > > first in the lib functions.
> > hum, I still don't see why this happens.. why do we read the
> > wrong word in this case?
> 
> If you read a u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1]
> you can get wrong value. This is what _find_next_bit() is doing.
> 
> In a big endian environment where 'unsigned long' is 32 bits
> long, "(u32 *)(&val)[0]" gets upper 32 bits, but without this patch
> perf assumes it gets lower 32 bits. The root cause is wrongly convert
> u64 value to bitmap.

i see, could you please put this into comment in the code?

also we could have common function for that, to keep it on
one place only, like bitmap_from_u64 or so

thanks,
jirka
