Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRvFF5Zp6zDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 11:44:01 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v791hV7E018584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 21:43:58 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7pjrxm38-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 21:43:57 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 9 Aug 2017 11:43:55 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v791hrVa11731012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 11:43:53 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v791hpOM028550
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Aug 2017 11:43:52 +1000
Subject: Re: [PATCH 16/16] perf tools: Add support for SPF events
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1502202949-8138-17-git-send-email-ldufour@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 9 Aug 2017 07:13:36 +0530
MIME-Version: 1.0
In-Reply-To: <1502202949-8138-17-git-send-email-ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c6468c4e-d704-d71a-6b00-e72977fbf68f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2017 08:05 PM, Laurent Dufour wrote:
> Add support for the new speculative faults events.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  tools/include/uapi/linux/perf_event.h | 2 ++
>  tools/perf/util/evsel.c               | 2 ++
>  tools/perf/util/parse-events.c        | 8 ++++++++
>  tools/perf/util/parse-events.l        | 2 ++
>  tools/perf/util/python.c              | 2 ++
>  5 files changed, 16 insertions(+)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index b1c0b187acfe..fbfb03dff334 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -111,6 +111,8 @@ enum perf_sw_ids {
>  	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
>  	PERF_COUNT_SW_DUMMY			= 9,
>  	PERF_COUNT_SW_BPF_OUTPUT		= 10,
> +	PERF_COUNT_SW_SPF_DONE			= 11,
> +	PERF_COUNT_SW_SPF_FAILED		= 12,
>  

PERF_COUNT_SW_SPF_FAULTS makes sense but not the FAILED one. IIRC,
there are no error path counting in perf SW events at the moment.
SPF_FAULTS and SPF_FAILS are VM internal events like THP collapse
etc. IMHO it should be added as a VM statistics counter or as a
trace point event instead.
