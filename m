Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3SX0lP6zF3Cc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:00 +1000 (AEST)
In-Reply-To: <1535066799-8493-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, clg@kaod.org
Subject: Re: [v2] powerpc/xive: Avoid unitialized variable
Message-Id: <42G3SW5cPRz9sCw@ozlabs.org>
Date: Thu, 20 Sep 2018 14:20:59 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-23 at 23:26:39 UTC, Breno Leitao wrote:
> From: Breno Leitao <breno.leitao@gmail.com>
> 
> Function xive_native_get_ipi() might uses chip_id without it being
> initialized.
> 
> This gives the following error on 'smatch' tool:
> 
> 	error: uninitialized symbol 'chip_id'
> 
> The suggestion is using xc->chip_id instead of consulting the OF for chip id,
> which is safe since xive_prepare_cpu() should have initialized ->chip_id by
> the time xive_native_get_ipi() is called.
> 
> CC: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8ac9e5bfd8cf41ef106ac97267117e

cheers
