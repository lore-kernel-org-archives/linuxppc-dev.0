Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hBmB2WYLzF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 00:06:01 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id d4-v6so1404885pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 07:06:01 -0700 (PDT)
Date: Fri, 3 Aug 2018 00:05:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
 huntbag@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 3/3] cpuidle/powernv: Conditionally save-restore
 sprs using opal
Message-ID: <20180803000547.08a37175@roar.ozlabs.ibm.com>
In-Reply-To: <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
 <20180802045132.12432-4-akshay.adiga@linux.vnet.ibm.com>
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

On Thu,  2 Aug 2018 10:21:32 +0530
Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> wrote:

> From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
> 
> If a state has "opal-supported" compat flag in device-tree, an opal call
> needs to be made during the entry and exit of the stop state. This patch
> passes a hint to the power9_idle_stop and power9_offline_stop.
> 
> This patch moves the saving and restoring of sprs for P9 cpuidle
> from kernel to opal. This patch still uses existing code to detect
> first thread in core.
> In an attempt to make the powernv idle code backward compatible,
> and to some extent forward compatible, add support for pre-stop entry
> and post-stop exit actions in OPAL. If a kernel knows about this
> opal call, then just a firmware supporting newer hardware is required,
> instead of waiting for kernel updates.

Still think we should make these do-everything calls. Including
executing nap/stop instructions, restoring timebase, possibly even
saving and restoring SLB (although a return code could be used to
tell the kernel to do that maybe if performance advantage is enough).

I haven't had a lot of time to go through it, I'm working on moving
~all of idle_book3s.S to C code, I'd like to do that before this
OPAL idle driver if possible.

A minor thing I just noticed, you don't have to allocate the opal
spr save space in Linux, just do it all in OPAL.

Thanks,
Nick
