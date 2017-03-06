Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcNxB2PByzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 02:29:02 +1100 (AEDT)
Date: Mon, 6 Mar 2017 16:28:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Stephane Eranian <eranian@google.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20170306152856.GO6500@twins.programming.kicks-ass.net>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
 <063D6719AE5E284EB5DD2968C1650D6DCFE78C84@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFE78C84@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 06, 2017 at 02:59:07PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 06 March 2017 11:22
> > To: Madhavan Srinivasan
> > Cc: Wang Nan; Alexander Shishkin; linux-kernel@vger.kernel.org; Arnaldo Carvalho de Melo; Alexei
> > Starovoitov; Ingo Molnar; Stephane Eranian; Sukadev Bhattiprolu; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of perf_mem_data_src
> > 
> > On Mon, Mar 06, 2017 at 04:13:08PM +0530, Madhavan Srinivasan wrote:
> > > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > >
> > > perf_mem_data_src is an union that is initialized via the ->val field
> > > and accessed via the bitmap fields. For this to work on big endian
> > > platforms, we also need a big-endian represenation of perf_mem_data_src.
> > 
> > Doesn't this break interpreting the data on a different endian machine?
> 
> Best to avoid bitfields if you ever care about the bit order.

Too late for that. But perf tool has quite a bit of code to muck fields
between different endians. With the full intent that generation on one
machine is readable by another.
