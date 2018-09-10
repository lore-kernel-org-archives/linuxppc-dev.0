Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42811j4FZGzF3C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:10:10 +1000 (AEST)
Date: Mon, 10 Sep 2018 10:10:01 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Neuling <mikey@neuling.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Haren Myneni
 <haren@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Avoid code patching freed init sections
Message-ID: <20180910101001.71a31102@naga.suse.cz>
In-Reply-To: <20180910054405.32422-1-mikey@neuling.org>
References: <20180910054405.32422-1-mikey@neuling.org>
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

On Mon, 10 Sep 2018 15:44:05 +1000
Michael Neuling <mikey@neuling.org> wrote:

> This stops us from doing code patching in init sections after they've
> been freed.
> 
> In this chain:
>   kvm_guest_init() ->
>     kvm_use_magic_page() ->
>       fault_in_pages_readable() ->
> 	 __get_user() ->
> 	   __get_user_nocheck() ->
> 	     barrier_nospec();
> 
> We have a code patching location at barrier_nospec() and
> kvm_guest_init() is an init function. This whole chain gets inlined,
> so when we free the init section (hence kvm_guest_init()), this code
> goes away and hence should no longer be patched.
> 
> We seen this as userspace memory corruption when using a memory
> checker while doing partition migration testing on powervm (this
> starts the code patching post migration via
> /sys/kernel/mobility/migration). In theory, it could also happen when
> using /sys/kernel/debug/powerpc/barrier_nospec.
> 
> With this patch there is a small change of a race if we code patch
> between the init section being freed and setting SYSTEM_RUNNING (in
> kernel_init()) but that seems like an impractical time and small
> window for any code patching to occur.
> 
> cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> ---
> For stable I've marked this as v4.13+ since that's when we refactored
> code-patching.c but it could go back even further than that. In
> reality though, I think we can only hit this since the first
> spectre/meltdown changes.

Which means it affects all maintained stable trees because the
spectre/meltdown changes are backported.

Thanks

Michal
