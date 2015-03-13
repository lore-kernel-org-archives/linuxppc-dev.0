Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 049E41A08EF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 20:19:38 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Fri, 13 Mar 2015 14:49:35 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C4030125804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 14:51:01 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D9JTZS28442818
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 14:49:29 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D9JQZ6004228
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 14:49:29 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH slof] virtio: Fix vring allocation
In-Reply-To: <1426236020-10278-1-git-send-email-aik@ozlabs.ru>
References: <1426236020-10278-1-git-send-email-aik@ozlabs.ru>
Date: Fri, 13 Mar 2015 14:49:24 +0530
Message-ID: <878uf1p84j.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thomas Huth <thuth@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The value returned by virtio_vring_size() is used to allocate memory
> for vring. The used descriptor list (array of vring_used_elem) is
> counted by the header - vring_used struct - is not.
>
> This fixes virtio_vring_size() to return the correct size.
> At the moment rings are quite small (256) and allocated with
> 4096 alignment, this is why we have not been having issues with
> this so far.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  lib/libvirtio/virtio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/libvirtio/virtio.c b/lib/libvirtio/virtio.c
> index b010796..22615c4 100644
> --- a/lib/libvirtio/virtio.c
> +++ b/lib/libvirtio/virtio.c
> @@ -33,7 +33,8 @@
>  unsigned long virtio_vring_size(unsigned int qsize)
>  {
>  	return VQ_ALIGN(sizeof(struct vring_desc) * qsize + 2 * (2 + qsize))

While at it, lets not have the above magic numbers as well ^^^^^^^^^^

sizeof(struct vring_avail) + sizeof(uint16_t) * qsize

> -		+ VQ_ALIGN(sizeof(struct vring_used_elem) * qsize);
> +               + VQ_ALIGN(sizeof(struct vring_used) +
> +                          sizeof(struct vring_used_elem) * qsize);
>  }
>
>
> -- 
> 2.0.0

Regards
Nikunj
