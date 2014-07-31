Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5DBB81A07B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Aug 2014 08:23:01 +1000 (EST)
Date: Thu, 31 Jul 2014 15:22:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] printk: Add function to return log buffer
 address and size
Message-Id: <20140731152255.37e675870dfdf77d9dbaff70@linux-foundation.org>
In-Reply-To: <20140731153447.27134.44225.stgit@hegdevasant.in.ibm.com>
References: <20140731153447.27134.44225.stgit@hegdevasant.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 31 Jul 2014 21:05:48 +0530 Vasant Hegde <hegdevasant@linux.vnet.ibm.com> wrote:

> Platforms like IBM Power Systems supports service processor
> assisted dump. It provides interface to add memory region to
> be captured when system is crashed.
> 
> During initialization/running we can add kernel memory region
> to be collected.
> 
> Presently we don't have a way to get the log buffer base address
> and size. This patch adds support to return log buffer address
> and size.
> 
> ...
>
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -10,6 +10,9 @@
>  extern const char linux_banner[];
>  extern const char linux_proc_banner[];
>  
> +extern void *get_log_buf_addr(void);
> +extern u32 get_log_buf_len(void);
> +
>  static inline int printk_get_level(const char *buffer)
>  {
>  	if (buffer[0] == KERN_SOH_ASCII && buffer[1]) {
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 13e839d..4049f7b 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -270,6 +270,18 @@ static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
>  static char *log_buf = __log_buf;
>  static u32 log_buf_len = __LOG_BUF_LEN;
>  
> +/* Return log buffer address */
> +void *get_log_buf_addr(void)
> +{
> +	return log_buf;
> +}
> +
> +/* Return log buffer size */
> +u32 get_log_buf_len(void)
> +{
> +	return log_buf_len;
> +}
> +
>  /* human readable text of the record */
>  static char *log_text(const struct printk_log *msg)
>  {

Looks OK to me, although I think log_buf_addr_get() and
log_buf_len_get() would be better names.  The kernel uses some
big-endian names and some little-endian-names and some middle-endian
names.  It's all rather a mess.  These symbols are already big-endian
(ie: decreasing significance):

	log_buf -> addr -> get
	log_buf -> len -> get


The world wouldn't end if we simply made log_buf and log_buf_len global
symbols.  The pros and cons are all minor.

It's probably better to make get_log_buf_addr() tell the truth and
return a char *.


Please include this in whatever tree carries "powerpc/powernv:
Interface to register/unregister opal dump region".
