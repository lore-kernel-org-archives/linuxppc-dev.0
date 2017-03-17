Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vktgb0yRHzDqc4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 16:09:46 +1100 (AEDT)
Date: Fri, 17 Mar 2017 14:09:30 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Dakinevich <jan.dakinevich@gmail.com>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
 virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: don't allocate a buffer for console print on
 stack
Message-ID: <20170317050930.GB28075@kroah.com>
References: <1487364165-21882-1-git-send-email-jan.dakinevich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487364165-21882-1-git-send-email-jan.dakinevich@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2017 at 11:42:45PM +0300, Jan Dakinevich wrote:
> The buffer is used by virtio console driver as DMA buffer. Since v4.9
> (if VMAP_STACK is enabled) we shouldn't use the stack for DMA.

You shouldn't use 'static' data either, that's not always guaranteed to
be DMA-able, right?

> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
> ---
>  drivers/tty/hvc/hvc_console.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index 9b5c0fb..1ce6aaf 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -143,10 +143,15 @@ static struct hvc_struct *hvc_get_by_index(int index)
>  static void hvc_console_print(struct console *co, const char *b,
>  			      unsigned count)
>  {
> -	char c[N_OUTBUF] __ALIGNED__;
>  	unsigned i = 0, n = 0;
>  	int r, donecr = 0, index = co->index;
>  
> +	/*
> +	 * Access to the buffer is serialized by console_sem in caller code from
> +	 * kernel/printk/printk.c
> +	 */
> +	static char c[N_OUTBUF] __ALIGNED__;

What about allocating it dynamically?  That's the correct thing to do.

thanks,

greg k-h
