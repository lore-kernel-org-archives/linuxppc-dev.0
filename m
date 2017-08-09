Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSBfJ6CqRzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 23:18:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH 13/16] perf: Add a speculative page fault sw events
In-Reply-To: <1502202949-8138-14-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1502202949-8138-14-git-send-email-ldufour@linux.vnet.ibm.com>
Date: Wed, 09 Aug 2017 23:18:15 +1000
Message-ID: <87lgmsnalk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> Add new software events to count succeeded and failed speculative page
> faults.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/perf_event.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b1c0b187acfe..fbfb03dff334 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -111,6 +111,8 @@ enum perf_sw_ids {
>  	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
>  	PERF_COUNT_SW_DUMMY			= 9,
>  	PERF_COUNT_SW_BPF_OUTPUT		= 10,
> +	PERF_COUNT_SW_SPF_DONE			= 11,
> +	PERF_COUNT_SW_SPF_FAILED		= 12,

Can't you calculate:

  PERF_COUNT_SW_SPF_FAILED = PERF_COUNT_SW_PAGE_FAULTS - PERF_COUNT_SW_SPF_DONE

ie. do you need a separate event for it?

cheers
