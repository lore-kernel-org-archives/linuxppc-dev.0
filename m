Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B31172C033A
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Dec 2013 14:42:53 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 18 Dec 2013 09:12:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 108C4394002D
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Dec 2013 09:12:48 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBI3ghHM65601640
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Dec 2013 09:12:43 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBI3gkxc008454
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Dec 2013 09:12:47 +0530
Message-ID: <52B11972.6030206@linux.vnet.ibm.com>
Date: Wed, 18 Dec 2013 09:11:38 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc, perf: Configure BHRB filter before enabling
 PMU interrupts
References: <1387332893-14407-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1387332893-14407-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/18/2013 07:44 AM, Michael Ellerman wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> Right now the config_bhrb() PMU specific call happens after
> write_mmcr0(), which actually enables the PMU for event counting and
> interrupts. So there is a small window of time where the PMU and BHRB
> runs without the required HW branch filter (if any) enabled in BHRB.
> 
> This can cause some of the branch samples to be collected through BHRB
> without any filter applied and hence affects the correctness of
> the results. This patch moves the BHRB config function call before
> enabling interrupts.
> 
> Here are some data points captured via trace prints which depicts how we
> could get PMU interrupts with BHRB filter NOT enabled with a standard
> perf record command line (asking for branch record information as well).
> 
>     $ perf record -j any_call ls
> 
> Before the patch:-
> 
>     ls-1962  [003] d...  2065.299590: .perf_event_interrupt: MMCRA: 40000000000
>     ls-1962  [003] d...  2065.299603: .perf_event_interrupt: MMCRA: 40000000000
>     ...
> 
>     All the PMU interrupts before this point did not have the requested
>     HW branch filter enabled in the MMCRA.
> 
>     ls-1962  [003] d...  2065.299647: .perf_event_interrupt: MMCRA: 40040000000
>     ls-1962  [003] d...  2065.299662: .perf_event_interrupt: MMCRA: 40040000000
> 
> After the patch:-
> 
>     ls-1850  [008] d...   190.311828: .perf_event_interrupt: MMCRA: 40040000000
>     ls-1850  [008] d...   190.311848: .perf_event_interrupt: MMCRA: 40040000000
> 
>     All the PMU interrupts have the requested HW BHRB branch filter
>     enabled in MMCRA.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> [mpe: Fixed up whitespace and cleaned up changelog]

Thanks Michael for cleaning and resending this out.
