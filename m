Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2MW336zkzDvYs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 14:40:31 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id s8so89992209pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 20:40:31 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Use tlbiel only if we ever ran on the current
 cpu
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161024032043.22455-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <9b21edc6-061b-ad66-1bbc-07c7d0048e6c@gmail.com>
Date: Mon, 24 Oct 2016 14:40:24 +1100
MIME-Version: 1.0
In-Reply-To: <20161024032043.22455-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/10/16 14:20, Aneesh Kumar K.V wrote:
> Before this patch, we used tlbiel, if we ever ran only on this core.
> That was mostly derived from the nohash usage of the same. But the
> ISA 3.0 clarifies tlbiel such that
> 
> "All TLB entries that have all of the following properties are made
> invalid on the thread executing the tlbiel instruction"
> 
> Hence use tlbiel, if we only ever ran on just the current cpu.
> 

Could you clarify the impact. The impact I see is that it could
lead to us thinking we invalidated the TLB across the core whereas
we did it only on the current thread? This could leave others threads
in the same core with invalid TLB's, if cpumask reported we ran on
other threads in the same core?

Balbir Singh.
