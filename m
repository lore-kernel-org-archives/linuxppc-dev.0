Return-Path: <dan.j.williams@intel.com>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
 by ozlabs.org (Postfix) with ESMTP id 9A2CB1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 20:22:47 +1100 (EST)
Received: by iabz7 with SMTP id z7so477899iab.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 01:12:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DBB740589CE8814680DECFE34BE197AB166593@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1324967446-28939-1-git-send-email-b29237@freescale.com>
 <DBB740589CE8814680DECFE34BE197AB166593@039-SN1MPN1-006.039d.mgd.msft.net>
Date: Thu, 26 Jan 2012 01:12:11 -0800
Message-ID: <CABE8wwv+iA_apPUCrLHgG-QiyHTuOfvZwPbJ7=zbTEQ3TgKQCw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: async_xor, fix zero address issue when xor
 highmem page
From: Dan Williams <dan.j.williams@intel.com>
To: Shi Xuelin-B29237 <B29237@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2012/1/10 Shi Xuelin-B29237 <B29237@freescale.com>:
> Hello Dan Williams,
>
> Do you have any comment about this patch?

Hi, sorrry for the delay.

>
> Thanks,
> Forrest
>
> -----Original Message-----
> From: Shi Xuelin-B29237
> Sent: 2011=E5=B9=B412=E6=9C=8827=E6=97=A5 14:31
> To: vinod.koul@intel.com; dan.j.williams@intel.com; linuxppc-dev@lists.oz=
labs.org; linux-kernel@vger.kernel.org; Li Yang-R58472
> Cc: Shi Xuelin-B29237
> Subject: [PATCH] dmaengine: async_xor, fix zero address issue when xor hi=
ghmem page
>
> From: Forrest shi <b29237@freescale.com>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0we may do_sync_xor high mem pages, in this cas=
e, page_address will
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return zero address which cause a failure.

In what scenarios do we xor highmem?

In the case of raid we currently always xor on kmalloc'd memory.

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0this patch uses kmap_atomic before xor the pag=
es and kunmap_atomic
> =C2=A0 =C2=A0 =C2=A0 =C2=A0after it.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: b29237@freescale.com <xuelin.sh=
i@freescale.com>
> ---
> =C2=A0crypto/async_tx/async_xor.c | =C2=A0 16 ++++++++++++----
> =C2=A01 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c in=
dex bc28337..5b416d1 100644
> --- a/crypto/async_tx/async_xor.c
> +++ b/crypto/async_tx/async_xor.c
> @@ -26,6 +26,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/mm.h>
> +#include <linux/highmem.h>
> =C2=A0#include <linux/dma-mapping.h>
> =C2=A0#include <linux/raid/xor.h>
> =C2=A0#include <linux/async_tx.h>
> @@ -126,7 +127,7 @@ do_sync_xor(struct page *dest, struct page **src_list=
, unsigned int offset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int src_cnt, size_t len, struct =
async_submit_ctl *submit) =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> - =C2=A0 =C2=A0 =C2=A0 int xor_src_cnt =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int xor_src_cnt =3D 0, kmap_cnt=3D0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int src_off =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *dest_buf;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void **srcs;
> @@ -138,11 +139,13 @@ do_sync_xor(struct page *dest, struct page **src_li=
st, unsigned int offset,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* convert to buffer pointers */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < src_cnt; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (src_list[i])
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 srcs[xor_src_cnt++] =3D page_address(src_list[i]) + offset;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (src_list[i]) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 srcs[xor_src_cnt++] =3D kmap_atomic(src_list[i], KM_USER1) + offset;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 kmap_cnt =3D xor_src_cnt;

I guess this works now that we have stack based kmap_atomic, but on
older kernels you could not simultaneously map that many buffers with
a single kmap slot.  So if you resend, drop the second parameter to
kmap_atomic.

...but unless you have a non md/raid456 use case in mind, or have
patches to convert md/raid to xor straight out of the incoming biovecs
I don't think this patch is needed right?
