Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BAE911400BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 18:02:49 +1100 (EST)
Received: by mail-wi0-f179.google.com with SMTP id z2so625854wiv.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Apr 2014 00:02:44 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 4 Apr 2014 09:02:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/2] mm: add FAULT_AROUND_ORDER Kconfig paramater for
 powerpc
Message-ID: <20140404070241.GA984@gmail.com>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-3-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396592835-24767-3-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Performance data for different FAULT_AROUND_ORDER values from 4 socket
> Power7 system (128 Threads and 128GB memory) is below. perf stat with
> repeat of 5 is used to get the stddev values. This patch create
> FAULT_AROUND_ORDER Kconfig parameter and defaults it to 3 based on the
> performance data.
> 
> FAULT_AROUND_ORDER      Baseline        1               3               4               5               7
> 
> Linux build (make -j64)
> minor-faults            7184385         5874015         4567289         4318518         4193815         4159193
> times in seconds        61.433776136    60.865935292    59.245368038    60.630675011    60.56587624     59.828271924
>  stddev for time	( +-  1.18% )	( +-  1.78% )	( +-  0.44% )	( +-  2.03% )	( +-  1.66% )	( +-  1.45% )

Ok, this is better, but it is still rather incomplete statistically, 
please also calculate the percentage difference to baseline, so that 
the stddev becomes meaningful and can be compared to something!

As an example I did this for the first line of measurements (all 
errors in the numbers are mine, this was done manually), and it gives:

>  stddev for time   ( +-  1.18% ) ( +-  1.78% ) ( +-  0.44% ) ( +-  2.03% ) ( +-  1.66% ) ( +-  1.45% )
                                        +0.9%         +3.5%         +1.3%         +1.4%         +2.6%

This shows that there is probably a statistically significant 
(positiv) effect from the change, but from these numbers alone I would 
not draw any quantitative (sizing, tuning) conclusions, because in 3 
out of 5 cases the stddev was larger than the effect, so the resulting 
percentages are not comparable.

Please do this calculation for all the other lines as well and also 
close all the numbers with a conclusion section where you *analyze* 
the results, outline the statistics and compare the various workloads 
and how the tuning affects them and don't force the readers of the 
commit guess what it all means and how significant it all is!

Thanks,

	Ingo
