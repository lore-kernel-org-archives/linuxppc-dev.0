Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 2F72FB7C48
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Mar 2010 13:18:00 +1100 (EST)
Date: Tue, 23 Mar 2010 07:46:20 +0530
From: Amit Shah <amit.shah@redhat.com>
To: =?iso-8859-1?Q?Fran=E7ois?= Diakhate <fdiakh@gmail.com>
Subject: Re: Virtio_console usage of early printk
Message-ID: <20100323021620.GA4088@amit-x200.redhat.com>
References: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6ad07c641003221045m10ee5c84x3a92436582600f21@mail.gmail.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Mon) Mar 22 2010 [18:45:47], François Diakhate wrote:
> Hi all,
> 
> As far as I can see, early_put_chars is not used by virtio_console
> because it checks whether there is a port available before using it.
> If I understand correctly, this makes it useless because once we have
> a port, we can use the regular virtio transport to output things to
> the console. Does the attached patch seem valid ? Feedback from s390
> and powerpc users who use this functionality would be appreciated.

Looks OK to me, Christian, others, could you comment on this please?

> Thanks,
> François

> From 3961f380bbe84a1036ddfc823039cbee31b44dcb Mon Sep 17 00:00:00 2001
> From: =?utf-8?q?Fran=C3=A7ois=20Diakhat=C3=A9?= <fdiakh@gmail.com>
> Date: Thu, 18 Mar 2010 14:48:20 +0100
> Subject: virtio: console: Fix early_put_chars usage
> 
> Currently early_put_chars is not used by virtio_console because it can only be used once a port has been found, at which point it's too late because it is no longer needed. This patch should fix it.
> ---
>  drivers/char/virtio_console.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index f404ccf..691ba21 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -645,13 +645,13 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>  {
>  	struct port *port;
>  
> +	if (unlikely(early_put_chars))
> +		return early_put_chars(vtermno, buf, count);
> +
>  	port = find_port_by_vtermno(vtermno);
>  	if (!port)
>  		return 0;
>  
> -	if (unlikely(early_put_chars))
> -		return early_put_chars(vtermno, buf, count);
> -
>  	return send_buf(port, (void *)buf, count);
>  }
>  
> -- 
> 1.6.1.3
> 


		Amit
