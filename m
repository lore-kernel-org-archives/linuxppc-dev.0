Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyt1hbNzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:14 +1100 (AEDT)
In-Reply-To: <20170922235800.19348-1-wak@google.com>
To: "William A. Kennington III" <wak@google.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rlippert@google.com, wak@google.com
Subject: Re: powerpc/opal: Fix EBUSY bug in acquiring tokens
Message-Id: <3yWlys4dWXz9s7G@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-22 at 23:58:00 UTC, "William A. Kennington III" wrote:
> The current code checks the completion map to look for the first token
> that is complete. In some cases, a completion can come in but the token
> can still be on lease to the caller processing the completion. If this
> completed but unreleased token is the first token found in the bitmap by
> another tasks trying to acquire a token, then the __test_and_set_bit
> call will fail since the token will still be on lease. The acquisition
> will then fail with an EBUSY.
> 
> This patch reorganizes the acquisition code to look at the
> opal_async_token_map for an unleased token. If the token has no lease it
> must have no outstanding completions so we should never see an EBUSY,
> unless we have leased out too many tokens. Since
> opal_async_get_token_inrerruptible is protected by a semaphore, we will
> practically never see EBUSY anymore.
> 
> Signed-off-by: William A. Kennington III <wak@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/71e24d7731a2903b1ae2bba2b2971c

cheers
