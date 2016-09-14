Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYznf209XzDsW5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 21:28:38 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id pp5so634095pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 04:28:38 -0700 (PDT)
Date: Wed, 14 Sep 2016 21:28:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, Carlos Eduardo Seo
 <cseo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, mikey@neuling.org,
 wei.guo.simon@gmail.com, anton@samba.org
Subject: Re: [PATCH 0/2] Enable MSR_TM lazily
Message-ID: <20160914212824.4936a9a2@roar.ozlabs.ibm.com>
In-Reply-To: <20160914080216.13833-1-cyrilbur@gmail.com>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc'ing Carlos

On Wed, 14 Sep 2016 18:02:14 +1000
Cyril Bur <cyrilbur@gmail.com> wrote:

> Currently the kernel checks to see if the hardware is transactional
> memory capable and always enables the MSR_TM bit. The problem with
> this is that the TM related SPRs become available to userspace,
> requiring them to be switched between processes. It turns out these
> SPRs are expensive to read and write and if a thread doesn't use TM
> (or worse yet isn't even TM aware) then context switching incurs this
> penalty for nothing.
> 
> The solution here is to leave the MSR_TM bit disabled and enable it
> more 'on demand'. Leaving MSR_TM disabled cause a thread to take a
> facility unavailable fault if and when it does decide to use TM. As
> with recent updates to the FPU, VMX and VSX units the MSR_TM bit will
> be enabled upon taking the fault and left on for some time afterwards
> as the assumption is that if a thread used TM ones it may well use it
> again. The kernel will turn the MSR_TM bit off after some number of
> context switches of that thread.
> 
> Performance numbers haven't been completely gathered as yet but early
> runs of tools/testing/selftests/powerpc/benchmarks/context_switch
> (which doesn't use TM) yields a jump from ~160000 switches per second
> to ~180000 switches per second with patch 3/3 applied.

Cool!

Question: glibc when built with lock elision seems like it will
execute tabort. before every syscall, to work around old kernel
behaviour. That's always going to fault TM on, isn't it?

How common it is for glibc to be built with elision?

We should probably be testing PPC_FEATURE2_HTM_NOSC to skip the
tabort.

(BTW, this is a pretty good writeup, would you consider adding
a bit more of it to patch 2 so it gets into the changelog?)

Thanks,
Nick
