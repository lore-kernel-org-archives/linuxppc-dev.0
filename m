Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 984761A0239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:19:49 +1000 (AEST)
Message-ID: <1439889583.31374.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Allow release of contexts which have been OPENED
 but not STARTED
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, dja@axtens.net, benh@kernel.crashing.org,
 mikey@neuling.org, imunsie@au1.ibm.com
Date: Tue, 18 Aug 2015 19:19:43 +1000
In-Reply-To: <1439879415-9925-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1439879415-9925-1-git-send-email-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-18 at 16:30 +1000, Andrew Donnellan wrote:
> If we open a context but do not start it (either because we do not attempt
> to start it, or because it fails to start for some reason), we are left
> with a context in state OPENED. Previously, cxl_release_context() only
> allowed releasing contexts in state CLOSED, so attempting to release an
> OPENED context would fail.
> 
> In particular, this bug causes available contexts to run out after some EEH
> failures, where drivers attempt to release contexts that have failed to
> start.
> 
> Allow releasing contexts in any state other than STARTED, i.e. OPENED or
> CLOSED (we can't release a STARTED context as it's currently using the
> hardware).
> 
> Cc: stable@vger.kernel.org
> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 6a768a9..1c520b8 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -59,7 +59,7 @@ EXPORT_SYMBOL_GPL(cxl_get_phys_dev);
>  
>  int cxl_release_context(struct cxl_context *ctx)
>  {
> -	if (ctx->status != CLOSED)
> +	if (ctx->status == STARTED)
>  		return -EBUSY;

So this doesn't break when you add a new state, is it worth writing it as:

	if (ctx->status >= STARTED)
		return -EBUSY;

?

cheers
