Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF5C51A0D34
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 15:29:09 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 20 Jan 2015 21:29:05 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D474D3E40041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:29:06 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0L4TEHe42991636
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:29:14 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0L4T2FT017841
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 21:29:03 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Pranith Kumar <bobby.prani@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Rob Herring <robh@kernel.org>,
 "open list\:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] powerpc/powernv: Skip registering log region when
 CONFIG_PRINTK=n
In-Reply-To: <1421797911-23650-2-git-send-email-bobby.prani@gmail.com>
References: <1421797911-23650-1-git-send-email-bobby.prani@gmail.com>
 <1421797911-23650-2-git-send-email-bobby.prani@gmail.com>
Date: Wed, 21 Jan 2015 15:28:52 +1100
Message-ID: <m3sif4u58b.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pranith Kumar <bobby.prani@gmail.com> writes:
> When CONFIG_PRINTK=n, log_buf_addr_get() returns NULL and log_buf_len_get()
> return 0. Check for these return values and skip registering the dump buffer.
>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> CC: Michael Ellerman <mpe@ellerman.id.au>

(investigating what would occur on systems with current firmware..)

Looking at hw/fsp/fsp-mdst-table.c in skiboot it appears that we'd end
up logging an error log about being passed the size 0 and return
OPAL_PARAMETER back to Linux.

While harmless, this is, naturally, not awesome to log an error about
being unable to grab kernel log on crash every time you boot.

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powernv/opal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index f10b9ec..1db119f0 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -667,7 +667,13 @@ static void __init opal_dump_region_init(void)
>  
>  	/* Register kernel log buffer */
>  	addr = log_buf_addr_get();
> +	if (addr == NULL)
> +		return;
> +
>  	size = log_buf_len_get();
> +	if (size == 0)
> +		return;
> +
>  	rc = opal_register_dump_region(OPAL_DUMP_REGION_LOG_BUF,
>  				       __pa(addr), size);
>  	/* Don't warn if this is just an older OPAL that doesn't
> -- 
> 1.9.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
