Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31A301A03D3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 20:41:40 +1100 (AEDT)
Received: by wggy19 with SMTP id y19so4845771wgg.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2015 01:41:35 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 8 Mar 2015 10:41:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
Message-ID: <20150308094128.GA15487@gmail.com>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-5-git-send-email-mgorman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425741651-29152-5-git-send-email-mgorman@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Mel Gorman <mgorman@suse.de> wrote:

> xfsrepair
>                                     4.0.0-rc1             4.0.0-rc1                3.19.0
>                                       vanilla           slowscan-v2               vanilla
> Min      real-fsmark        1157.41 (  0.00%)     1150.38 (  0.61%)     1164.44 ( -0.61%)
> Min      syst-fsmark        3998.06 (  0.00%)     3988.42 (  0.24%)     4016.12 ( -0.45%)
> Min      real-xfsrepair      497.64 (  0.00%)      456.87 (  8.19%)      442.64 ( 11.05%)
> Min      syst-xfsrepair      500.61 (  0.00%)      263.41 ( 47.38%)      194.97 ( 61.05%)
> Amean    real-fsmark        1166.63 (  0.00%)     1155.97 (  0.91%)     1166.28 (  0.03%)
> Amean    syst-fsmark        4020.94 (  0.00%)     4004.19 (  0.42%)     4025.87 ( -0.12%)
> Amean    real-xfsrepair      507.85 (  0.00%)      459.58 (  9.50%)      447.66 ( 11.85%)
> Amean    syst-xfsrepair      519.88 (  0.00%)      281.63 ( 45.83%)      202.93 ( 60.97%)
> Stddev   real-fsmark           6.55 (  0.00%)        3.97 ( 39.30%)        1.44 ( 77.98%)
> Stddev   syst-fsmark          16.22 (  0.00%)       15.09 (  6.96%)        9.76 ( 39.86%)
> Stddev   real-xfsrepair       11.17 (  0.00%)        3.41 ( 69.43%)        5.57 ( 50.17%)
> Stddev   syst-xfsrepair       13.98 (  0.00%)       19.94 (-42.60%)        5.69 ( 59.31%)
> CoeffVar real-fsmark           0.56 (  0.00%)        0.34 ( 38.74%)        0.12 ( 77.97%)
> CoeffVar syst-fsmark           0.40 (  0.00%)        0.38 (  6.57%)        0.24 ( 39.93%)
> CoeffVar real-xfsrepair        2.20 (  0.00%)        0.74 ( 66.22%)        1.24 ( 43.47%)
> CoeffVar syst-xfsrepair        2.69 (  0.00%)        7.08 (-163.23%)        2.80 ( -4.23%)
> Max      real-fsmark        1171.98 (  0.00%)     1159.25 (  1.09%)     1167.96 (  0.34%)
> Max      syst-fsmark        4033.84 (  0.00%)     4024.53 (  0.23%)     4039.20 ( -0.13%)
> Max      real-xfsrepair      523.40 (  0.00%)      464.40 ( 11.27%)      455.42 ( 12.99%)
> Max      syst-xfsrepair      533.37 (  0.00%)      309.38 ( 42.00%)      207.94 ( 61.01%)

Btw., I think it would be nice if these numbers listed v3.19 
performance in the first column, to make it clear at a glance
how much regression we still have?

Thanks,

	Ingo
