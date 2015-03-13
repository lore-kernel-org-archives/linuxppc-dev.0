Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E76B01A11D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 21:15:34 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Fri, 13 Mar 2015 20:15:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 61591357805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 21:15:30 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2DAFL1o32833662
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 21:15:30 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2DAEuAK029070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 21:14:56 +1100
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH slof v2] virtio: Fix vring allocation
In-Reply-To: <1426239723-25789-1-git-send-email-aik@ozlabs.ru>
References: <878uf1p84j.fsf@abhimanyu.in.ibm.com>
 <1426239723-25789-1-git-send-email-aik@ozlabs.ru>
Date: Fri, 13 Mar 2015 15:44:38 +0530
Message-ID: <8761a5p5kh.fsf@abhimanyu.in.ibm.com>
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

Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

> ---
> Changes:
> v2:
> * remove magic numbers
> ---
>  lib/libvirtio/virtio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/libvirtio/virtio.c b/lib/libvirtio/virtio.c
> index b010796..f9c00a6 100644
> --- a/lib/libvirtio/virtio.c
> +++ b/lib/libvirtio/virtio.c
> @@ -32,8 +32,10 @@
>   */
>  unsigned long virtio_vring_size(unsigned int qsize)
>  {
> -	return VQ_ALIGN(sizeof(struct vring_desc) * qsize + 2 * (2 + qsize))
> -		+ VQ_ALIGN(sizeof(struct vring_used_elem) * qsize);
> +	return VQ_ALIGN(sizeof(struct vring_desc) * qsize +
> +                        sizeof(struct vring_avail) + sizeof(uint16_t) * qsize) +
> +               VQ_ALIGN(sizeof(struct vring_used) +
> +                        sizeof(struct vring_used_elem) * qsize);
>  }
>
>
> -- 
> 2.0.0
