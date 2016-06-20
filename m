Return-Path: <wangnan0@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [58.251.152.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY5M84LPXzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:35:48 +1000 (AEST)
Subject: Re: [PATCH v2] tools/perf: Fix the mask in regs_dump__printf and
To: Jiri Olsa <jolsa@redhat.com>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>
References: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160620091818.GC27702@krava>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "Yury
 Norov" <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>
From: "Wangnan (F)" <wangnan0@huawei.com>
Message-ID: <5767B6FD.4080708@huawei.com>
Date: Mon, 20 Jun 2016 17:27:25 +0800
MIME-Version: 1.0
In-Reply-To: <20160620091818.GC27702@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016/6/20 17:18, Jiri Olsa wrote:
> On Mon, Jun 20, 2016 at 02:14:01PM +0530, Madhavan Srinivasan wrote:
>> When decoding the perf_regs mask in regs_dump__printf(),
>> we loop through the mask using find_first_bit and find_next_bit functions.
>> "mask" is of type "u64", but sent as a "unsigned long *" to
>> lib functions along with sizeof(). While the exisitng code works fine in
>> most of the case, the logic is broken when using a 32bit perf on a
>> 64bit kernel (Big Endian). We end up reading the wrong word of the u64
>> first in the lib functions.
> hum, I still don't see why this happens.. why do we read the
> wrong word in this case?

If you read a u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1]
you can get wrong value. This is what _find_next_bit() is doing.

In a big endian environment where 'unsigned long' is 32 bits
long, "(u32 *)(&val)[0]" gets upper 32 bits, but without this patch
perf assumes it gets lower 32 bits. The root cause is wrongly convert
u64 value to bitmap.


Thank you.
