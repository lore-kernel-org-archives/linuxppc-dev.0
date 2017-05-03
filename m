Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHP4LZHzDqG2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:57 +1000 (AEST)
In-Reply-To: <20170419073927.29224-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aik@ozlabs.ru, Russell Currey <ruscur@russell.cc>
Subject: Re: [v3,
 1/2] powerpc/eeh: Avoid use after free in eeh_handle_special_event()
Message-Id: <3wJCHP3ZByz9s0g@ozlabs.org>
Date: Thu,  4 May 2017 08:18:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 07:39:26 UTC, Russell Currey wrote:
> eeh_handle_special_event() is called when an EEH event is detected but
> can't be narrowed down to a specific PE.  This function looks through
> every PE to find one in an erroneous state, then calls the regular event
> handler eeh_handle_normal_event() once it knows which PE has an error.
> 
> However, if eeh_handle_normal_event() found that the PE cannot possibly
> be recovered, it will free it, rendering the passed PE stale.
> This leads to a use after free in eeh_handle_special_event() as it attempts to
> clear the "recovering" state on the PE after eeh_handle_normal_event() returns.
> 
> Thus, make sure the PE is valid when attempting to clear state in
> eeh_handle_special_event().
> 
> Cc: <stable@vger.kernel.org> #3.10+
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/daeba2956f32f91f3493788ff6ee02

cheers
