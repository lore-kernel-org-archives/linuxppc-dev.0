Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9886C1A021A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 15:53:17 +1100 (EST)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E00E41400D2
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 15:53:16 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 6 Oct 2014 22:53:15 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3030619D803D
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Oct 2014 22:41:56 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s974rC5Q48300226
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2014 06:53:12 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s974rBrd002265
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Oct 2014 22:53:11 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Fallback to old HMI handling behavior
 for old firmware
In-Reply-To: <20141006093358.1828.36741.stgit@mars>
References: <20141006093358.1828.36741.stgit@mars>
Date: Tue, 07 Oct 2014 15:53:08 +1100
Message-ID: <m3vbnwfpl7.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> Recently we moved HMI handling into Linux kernel instead of taking
> HMI directly in OPAL. This new change is dependent on new OPAL call
> for HMI recovery which was introduced in newer firmware. While this new
> change works fine with latest OPAL firmware, we broke the HMI handling
> if we run newer kernel on old OPAL firmware that results in system hang.
>
> This patch fixes this issue by falling back to old HMI behavior on older
> OPAL firmware.
>
> This patch introduces a check for opal token OPAL_HANDLE_HMI to see
> if we are running on newer firmware or old firmware. On newer firmware
> this check would return OPAL_TOKEN_PRESENT, otherwise we are running on
> old firmware and fallback to old HMI behavior.
>
> This patch depends on opal check token patch posted at ppc-devel
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120224.html

(just reviewed that patch before this one...)

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
> +	 * OPAL_HANDLE_HMI token. If yes, then don't ask opal to patch
> +	 * HMI interrupt and we catch it directly in Linux kernel.
> +	 *
> +	 * For older firmware we will fallback to old behavior and
> +	 * let OPAL patch the HMI vector and handle it inside OPAL
> +	 * firmware.
> +	 */
> +	if (opal_check_token(OPAL_HANDLE_HMI) != OPAL_TOKEN_PRESENT) {
> +		/* We are on old firmware. fallback to old behavior. */
> +		pr_info("%s: Falling back to old HMI handling behavior.\n",
> +			__func__);
> +		opal_register_exception_handler(
> +				OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
> +				0, glue);
> +		glue += 128;
> +	}
>  	opal_register_exception_handler(OPAL_SOFTPATCH_HANDLER, 0,
> glue);

So.. that all looks fine, but another note: why are we doing the
OPAL_SOFTPATCH_HANDLER and why is it all #if 0 out in skiboot?

for this patch:

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
