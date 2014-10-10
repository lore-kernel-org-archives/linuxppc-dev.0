Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87DE91A06FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Oct 2014 17:23:19 +1100 (EST)
In-Reply-To: <20141006093358.1828.36741.stgit@mars>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/powernv: Fallback to old HMI handling behavior for old
 firmware
Message-Id: <20141010062319.6000B1400DE@ozlabs.org>
Date: Fri, 10 Oct 2014 17:23:19 +1100 (EST)
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-10 at 09:34:19 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Hi Mahesh,

> Recently we moved HMI handling into Linux kernel instead of taking
> HMI directly in OPAL. This new change is dependent on new OPAL call
> for HMI recovery which was introduced in newer firmware. While this new
> change works fine with latest OPAL firmware, we broke the HMI handling
> if we run newer kernel on old OPAL firmware that results in system hang.
> 
> This patch fixes this issue by falling back to old HMI behavior on older
> OPAL firmware.

It sounds like "older" firmware is actually "the currently released firmware".
The "newer" firmware is still in development, is that right?

If so please update the comment and changelog to better reflect that.

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index b44eec3..2768cd3 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -194,6 +194,24 @@ static int __init opal_register_exception_handlers(void)
>  	 * fwnmi area at 0x7000 to provide the glue space to OPAL
>  	 */
>  	glue = 0x7000;
> +
> +	/* Check if we are running on newer firmware that exports

Please format your long comments like:

/*
 * Check if we are ..
 */

I know some of our code uses the other style but this is the commonly accepted
style.

> +	 * OPAL_HANDLE_HMI token. If yes, then don't ask opal to patch
> +	 * HMI interrupt and we catch it directly in Linux kernel.
> +	 *
> +	 * For older firmware we will fallback to old behavior and
> +	 * let OPAL patch the HMI vector and handle it inside OPAL
> +	 * firmware.
> +	 */
> +	if (opal_check_token(OPAL_HANDLE_HMI) != OPAL_TOKEN_PRESENT) {

OPAL_TOKEN_PRESENT was dropped from the API. Just use:

	if (!opal_check_token(OPAL_HANDLE_HMI)) {

> +		/* We are on old firmware. fallback to old behavior. */
> +		pr_info("%s: Falling back to old HMI handling behavior.\n",
> +			__func__);

Please just use "opal: " rather than __func__.

And rather than the user having to know what the old vs new behaviour is, can
you make it explicit in the message, eg:

"opal: Old firmware detected, letting OPAL handle HMIs."

> +		opal_register_exception_handler(
> +				OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
> +				0, glue);
> +		glue += 128;
> +	}

Newline here please.

>  	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0, glue);
>  #endif


cheers
