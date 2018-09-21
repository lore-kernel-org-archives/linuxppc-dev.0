Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GsbJ1x06zF3QM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 21:59:40 +1000 (AEST)
In-Reply-To: <20180914011411.3184-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?q?Mich?= =?utf-8?q?al_Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: [v4] powerpc: Avoid code patching freed init sections
Message-Id: <42GsbJ0Knkz9sCh@ozlabs.org>
Date: Fri, 21 Sep 2018 21:59:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-14 at 01:14:11 UTC, Michael Neuling wrote:
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
> cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/51c3c62b58b357e8d35e4cc32f7b4e

cheers
