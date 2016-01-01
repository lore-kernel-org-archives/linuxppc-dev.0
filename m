Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lf0-x230.google.com (mail-lf0-x230.google.com
 [IPv6:2a00:1450:4010:c07::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11D4E1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jan 2016 04:23:51 +1100 (AEDT)
Received: by mail-lf0-x230.google.com with SMTP id y184so249879408lfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jan 2016 09:23:51 -0800 (PST)
Subject: Re: [PATCH v2 32/32] virtio_ring: use virt_store_mb
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-33-git-send-email-mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5686B622.6070600@cogentembedded.com>
Date: Fri, 1 Jan 2016 20:23:46 +0300
MIME-Version: 1.0
In-Reply-To: <1451572003-2440-33-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 12/31/2015 10:09 PM, Michael S. Tsirkin wrote:

> We need a full barrier after writing out event index, using
> virt_store_mb there seems better than open-coding.  As usual, we need a
> wrapper to account for strong barriers.
>
> It's tempting to use this in vhost as well, for that, we'll
> need a variant of smp_store_mb that works on __user pointers.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/linux/virtio_ring.h  | 12 ++++++++++++
>   drivers/virtio/virtio_ring.c | 15 +++++++++------
>   2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index f3fa55b..3a74d91 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -45,6 +45,18 @@ static inline void virtio_wmb(bool weak_barriers)
>   		wmb();
>   }
>
> +static inline void virtio_store_mb(bool weak_barriers,
> +				   __virtio16 *p, __virtio16 v)
> +{
> +	if (weak_barriers)
> +		virt_store_mb(*p, v);
> +	else
> +	{

    The kernel coding style dictates:

	if (weak_barriers) {
		virt_store_mb(*p, v);
	} else {

> +		WRITE_ONCE(*p, v);
> +		mb();
> +	}
> +}
> +
[...]

MBR, Sergei
