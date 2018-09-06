Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425gtb2PchzF31D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 23:11:03 +1000 (AEST)
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so5208867pgp.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2018 06:11:02 -0700 (PDT)
Date: Thu, 6 Sep 2018 23:10:39 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Matteo Croce <mcroce@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Leon
 Romanovsky <leonro@mellanox.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org (op)
Subject: Re: [PATCH 3/3] tty: hvc: hvc_write() fix break condition
Message-ID: <20180906231039.7b71186a@roar.ozlabs.ibm.com>
In-Reply-To: <20180905121439.23809-4-npiggin@gmail.com>
References: <20180905121439.23809-1-npiggin@gmail.com>
 <20180905121439.23809-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  5 Sep 2018 22:14:39 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Commit 550ddadcc758 ("tty: hvc: hvc_write() may sleep") broke the
> termination condition in case the driver stops accepting characters.
> This can result in unnecessary polling of the busy driver.
> 
> Restore it by testing the hvc_push return code.
> 
> Fixes: 550ddadcc758 ("tty: hvc: hvc_write() may sleep")
> Tested-by: Matteo Croce <mcroce@redhat.com>
> Tested-by: Leon Romanovsky <leonro@mellanox.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  drivers/tty/hvc/hvc_console.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
> index bacf9b73ec98..c09a38fb0d66 100644
> --- a/drivers/tty/hvc/hvc_console.c
> +++ b/drivers/tty/hvc/hvc_console.c
> @@ -522,6 +522,8 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
>  		return -EIO;
>  
>  	while (count > 0) {
> +		int ret;
> +
>  		spin_lock_irqsave(&hp->lock, flags);
>  
>  		rsize = hp->outbuf_size - hp->n_outbuf;

That needs to be 'int ret = 0;' to avoid used uninitialized.

Let me know if I should resend the patches.

Thanks,
Nick
