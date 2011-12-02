Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8D97BB6F67
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 12:37:09 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jkenisto@linux.vnet.ibm.com>;
 Thu, 1 Dec 2011 18:37:06 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pB21b3RR127948
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2011 18:37:04 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pB21b3s3007755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Dec 2011 18:37:03 -0700
Subject: Re: [PATCH] powerpc/nvram: Add spinlock to oops_to_nvram to
 prevent oops in compression code.
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20111201124645.24c6e54f@kryten>
References: <20111201124645.24c6e54f@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Dec 2011 17:37:02 -0800
Message-ID: <1322789822.3035.2.camel@localhost>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 12:46 +1100, Anton Blanchard wrote:
> When issuing a system reset we almost always oops in the oops_to_nvram
> code because multiple CPUs are using the deflate work area. Add a
> spinlock to protect it.
> 
> To play it safe I'm using trylock to avoid locking up if the NVRAM
> code oopses. This means we might miss multiple CPUs oopsing at exactly
> the same time but I think it's best to play it safe for now. Once we
> are happy with the reliability we can change it to a full spinlock.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Jim Keniston <jkenisto@us.ibm.com>

> ---
> 
> Index: linux-build/arch/powerpc/platforms/pseries/nvram.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/platforms/pseries/nvram.c	2011-12-01 09:44:27.205568463 +1100
> +++ linux-build/arch/powerpc/platforms/pseries/nvram.c	2011-12-01 12:36:49.334478156 +1100
> @@ -634,6 +634,8 @@ static void oops_to_nvram(struct kmsg_du
>  {
>  	static unsigned int oops_count = 0;
>  	static bool panicking = false;
> +	static DEFINE_SPINLOCK(lock);
> +	unsigned long flags;
>  	size_t text_len;
>  	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
>  	int rc = -1;
> @@ -664,6 +666,9 @@ static void oops_to_nvram(struct kmsg_du
>  	if (clobbering_unread_rtas_event())
>  		return;
> 
> +	if (!spin_trylock_irqsave(&lock, flags))
> +		return;
> +
>  	if (big_oops_buf) {
>  		text_len = capture_last_msgs(old_msgs, old_len,
>  			new_msgs, new_len, big_oops_buf, big_oops_buf_sz);
> @@ -679,4 +684,6 @@ static void oops_to_nvram(struct kmsg_du
> 
>  	(void) nvram_write_os_partition(&oops_log_partition, oops_buf,
>  		(int) (sizeof(*oops_len) + *oops_len), err_type, ++oops_count);
> +
> +	spin_unlock_irqrestore(&lock, flags);
>  }
> 
