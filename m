Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id EB9C12C0333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 13:52:52 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powernv: don't attempt to refetch the FSP dump until
 the user has explicitly acked it.
In-reply-to: <1392941701-2871-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <20140116121411.624.55662.stgit@hegdevasant.in.ibm.com>
 <1392941701-2871-1-git-send-email-stewart@linux.vnet.ibm.com>
Date: Fri, 21 Feb 2014 13:52:52 +1100
Message-ID: <21091.1392951172@ale.ozlabs.ibm.com>
Cc: hegdevasant@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stewart Smith <stewart@linux.vnet.ibm.com> wrote:

> This fixes a bug where we would get two events from OPAL with DUMP_AVAIL
> set (which is valid for OPAL to do) and in the second run of extract_dump()
> we would fail to free the memory previously allocated for the dump
> (leaking ~6MB+) as well as on the second dump_read_data() call OPAL
> would not retrieve the dump, leaving us with a dump in linux that was
> the correct size but all zeros.
> 
> Changes since v1: fixed typo
> 
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Should we CC stable on this?

Mikey

> ---
>  arch/powerpc/platforms/powernv/opal-dump.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
> index 4447027..53c2675 100644
> --- a/arch/powerpc/platforms/powernv/opal-dump.c
> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
> @@ -238,6 +238,14 @@ static int extract_dump(void)
>  {
>  	int rc;
>  
> +	/* We can get notified that a dump is available multiple times
> +	 * (dump_read_info clears the bit in the event from OPAL).
> +	 * But we should not re-read the dump from OPAL as we
> +	 * don't get the next dump until we've explicitly acked this one.
> +	 */
> +	if (dump_avail)
> +		return OPAL_SUCCESS;
> +
>  	/* Get dump ID, size */
>  	rc = dump_read_info();
>  	if (rc != OPAL_SUCCESS)
> -- 
> 1.7.10.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
