Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXZ6Nj5zDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:26 +1100 (AEDT)
In-Reply-To: <20171116174537.duz4x6vfzhp44lfh@treble>
To: Josh Poimboeuf <jpoimboe@redhat.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v4.2] powerpc/modules: Don't try to restore r2 after a sibling
 call
Message-Id: <3ywyXY71NTz9t3m@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-11-16 at 17:45:37 UTC, Josh Poimboeuf wrote:
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH v4.2] powerpc/modules: Don't try to restore r2 after a sibling call
> 
> When attempting to load a livepatch module, I got the following error:
> 
>   module_64: patch_module: Expect noop after relocate, got 3c820000
> 
> The error was triggered by the following code in
> unregister_netdevice_queue():
> 
>   14c:   00 00 00 48     b       14c <unregister_netdevice_queue+0x14c>
>                          14c: R_PPC64_REL24      net_set_todo
>   150:   00 00 82 3c     addis   r4,r2,0
> 
> GCC didn't insert a nop after the branch to net_set_todo() because it's
> a sibling call, so it never returns.  The nop isn't needed after the
> branch in that case.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b9eab08d012fa093947b230f9a8725

cheers
