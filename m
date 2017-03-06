Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcNGz2V3TzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 01:59:22 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Peter Zijlstra' <peterz@infradead.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>
CC: Wang Nan <wangnan0@huawei.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "Stephane Eranian" <eranian@google.com>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2 1/6] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Date: Mon, 6 Mar 2017 14:59:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE78C84@AcuExch.aculab.com>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1488796993-25495-2-git-send-email-maddy@linux.vnet.ibm.com>
 <20170306112228.GZ6515@twins.programming.kicks-ass.net>
In-Reply-To: <20170306112228.GZ6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Zijlstra
> Sent: 06 March 2017 11:22
> To: Madhavan Srinivasan
> Cc: Wang Nan; Alexander Shishkin; linux-kernel@vger.kernel.org; Arnaldo C=
arvalho de Melo; Alexei
> Starovoitov; Ingo Molnar; Stephane Eranian; Sukadev Bhattiprolu; linuxppc=
-dev@lists.ozlabs.org
> Subject: Re: [PATCH v2 1/6] powerpc/perf: Define big-endian version of pe=
rf_mem_data_src
>=20
> On Mon, Mar 06, 2017 at 04:13:08PM +0530, Madhavan Srinivasan wrote:
> > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> >
> > perf_mem_data_src is an union that is initialized via the ->val field
> > and accessed via the bitmap fields. For this to work on big endian
> > platforms, we also need a big-endian represenation of perf_mem_data_src=
.
>=20
> Doesn't this break interpreting the data on a different endian machine?

Best to avoid bitfields if you ever care about the bit order.

	David
