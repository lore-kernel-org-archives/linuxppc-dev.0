Return-Path: <zhlcindy@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 117801A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 13:06:45 +1100 (AEDT)
Received: by mail-yw0-x243.google.com with SMTP id s188so1938795ywe.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Mar 2016 18:06:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1457429794.31524.1.camel@ellerman.id.au>
References: <1457409354-10867-1-git-send-email-zhlcindy@gmail.com>
 <1457409354-10867-3-git-send-email-zhlcindy@gmail.com>
 <1457429794.31524.1.camel@ellerman.id.au>
Date: Wed, 9 Mar 2016 10:06:41 +0800
Message-ID: <CAD8of+q952t2WfocGf5biN2AnSY-w0PLyC+EjL2pEGLVj02AUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/mm: Enable page parallel initialisation
From: Li Zhang <zhlcindy@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: akpm@linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 mgorman@techsingularity.net,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 aneesh.kumar@linux.vnet.ibm.com,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Li Zhang <zhlcindy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 8, 2016 at 5:36 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Hi Li,
>
> On Tue, 2016-03-08 at 11:55 +0800, Li Zhang wrote:
>
>> From: Li Zhang <zhlcindy@linux.vnet.ibm.com>
>>
>> Parallel initialisation has been enabled for X86, boot time is
>> improved greatly. On Power8, it is improved greatly for small
>> memory. Here is the result from my test on Power8 platform:
>>
>> For 4GB memory: 57% is improved, boot time as the following:
>> with patch: 10s, without patch: 24.5s
>
> This isn't worded quite right, and the numbers are a bit off.
>
> old = 24.5
> new = 10
>
> So the improvement is 14.5 (seconds).
>
> That means the improvement (14.5) as a percentage of the original boot time is:
>
>  = 14.5 / 24.5 * 100
>  = 59.183673469387756
>  = 59%

Oh, sorry. It seems that I made a mistake.
>
> So you would say:
>
>   For 4GB of memory, boot time is improved by 59%, from 24.5s to 10s.

Got it. :)

>
>> For 50GB memory: 22% is improved, boot time as the following:
>> with patch: 43.8s, without patch: 56.8s
>
>   For 50GB memory, boot time is improved by 22%, from 56.8s to 43.8s.
>
>> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Li Zhang <zhlcindy@linux.vnet.ibm.com>
>> ---
>>  * Add boot time details in change log.
>>  * Please apply this patch after [PATCH 1/2] mm: meminit: initialise
>>     more memory for inode/dentry hash tables in early boot, because
>>    [PATCH 1/2] is to fix a bug which can be reproduced on Power.
>
> Given that, I think it would be best if Andrew merged both of these patches.
> Because this patch is pretty trivial, whereas the patch to mm/ is less so.
>
> Is that OK Andrew?
>
> For this one:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> cheers
>



-- 

Best Regards
-Li
