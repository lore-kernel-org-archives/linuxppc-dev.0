Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D9E4B7B78
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 01:14:18 +1100 (EST)
Date: Sat, 17 Oct 2009 22:43:02 +0900
To: akinobu.mita@gmail.com
Subject: Re: [PATCH 2/8] bitmap: Introduce bitmap_set, bitmap_clear,
	bitmap_find_next_zero_area
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20091013091017.GA18431@localhost.localdomain>
References: <20091009164100.85a36188.akpm@linux-foundation.org>
	<20091013021818.GA3898@localhost.localdomain>
	<20091013091017.GA18431@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20091017224028V.fujita.tomonori@lab.ntt.co.jp>
Cc: linux-usb@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, hpa@zytor.com,
	sparclinux@vger.kernel.org, LW@KARO-electronics.de,
	x86@kernel.org, linux-altix@sgi.com, mingo@redhat.com,
	fenghua.yu@intel.com, yevgenyp@mellanox.co.il,
	tglx@linutronix.de, tony.luck@intel.com, netdev@vger.kernel.org,
	gregkh@suse.de, linux-kernel@vger.kernel.org,
	fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Oct 2009 18:10:17 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> My user space testing exposed off-by-one error find_next_zero_area
> in iommu-helper. Some zero area cannot be found by this bug.
> 
> Subject: [PATCH] Fix off-by-one error in find_next_zero_area
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  lib/iommu-helper.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
> index 75dbda0..afc58bc 100644
> --- a/lib/iommu-helper.c
> +++ b/lib/iommu-helper.c
> @@ -19,7 +19,7 @@ again:
>  	index = (index + align_mask) & ~align_mask;
>  
>  	end = index + nr;
> -	if (end >= size)
> +	if (end > size)

I think that this is intentional; the last byte of the limit doesn't
work.
