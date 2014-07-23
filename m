Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA0451A03E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 22:33:22 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 08:33:20 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 801F5C9002E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 08:33:10 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6NCXHwU5046778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 12:33:17 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6NCXGvJ008400
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 08:33:16 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/powernv: Interface to add opal dump region
In-Reply-To: <20140723092525.5170.25926.stgit@hegdevasant.in.ibm.com>
References: <20140723092506.5170.34633.stgit@hegdevasant.in.ibm.com>
 <20140723092525.5170.25926.stgit@hegdevasant.in.ibm.com>
Date: Wed, 23 Jul 2014 22:33:05 +1000
Message-ID: <m3a980i7b2.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> PowerNV platform is capable of capturing host memory region when system
> crashes (because of host/firmware). We have new OPAL API to register
> memory region to be capture when system crashes.
>
> This patch adds support for new API and also registers kernel log
> buffer.

I think we do need a way to un-register regions, and I think this may be
important around kexec - unless the log buffer is in exactly the same
place, there's a window where we could dump some random memory contents
as kernel log buffer, probably causing some poor support person to
scratch their head for a good long while.

> +void __init opal_dump_region_init(void)
> +{
> +	void *addr;
> +	uint64_t size;
> +	int rc;
> +
> +	/* Register kernel log buffer */
> +	addr = get_log_buf_addr();
> +	size = get_log_buf_len();
> +	rc = add_dump_region_entry(DUMP_REGION_LOG_BUF, addr, size);
> +	if (rc)
> +		pr_warn("DUMP: Failed to register kernel log buffer. "
> +			"rc = %d\n", rc);

This is what's going to be printed in kernel log when running on OPAL
firmware that doesn't support that call. Does this include the first GA
release on POWER8 systems? If so, we probably want a nicer log message
pointing to the fact that firmware is too old to support that function.
