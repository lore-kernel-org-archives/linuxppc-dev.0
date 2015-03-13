Return-Path: <thuth@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A75C1A074A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 21:25:58 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <thuth@linux.vnet.ibm.com>;
 Fri, 13 Mar 2015 10:25:53 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 16EE617D805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 10:26:14 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2DAPpZa65142846
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 10:25:51 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2DAPoXW030383
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 04:25:50 -0600
Date: Fri, 13 Mar 2015 11:25:48 +0100
From: Thomas Huth <thuth@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH slof v2] virtio: Fix vring allocation
Message-ID: <20150313112548.06e2c378@oc7435384737.ibm.com>
In-Reply-To: <1426239723-25789-1-git-send-email-aik@ozlabs.ru>
References: <878uf1p84j.fsf@abhimanyu.in.ibm.com>
 <1426239723-25789-1-git-send-email-aik@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 13 Mar 2015 20:42:03 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

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

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>

That should be at least ok for the current status that we support in
SLOF. I think I might have written the original version of that
function with a very old version of the virtio spec (v0.8.10), when
ther was no "used_event" event field in the struct vring_avail defined
yet.
But if SLOF ever supports VIRTIO_F_EVENT_IDX, we've got to keep in mind
to add some additional bytes here, too.

 Thomas
