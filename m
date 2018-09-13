Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B4rc5107zF3Ry
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 03:09:36 +1000 (AEST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20180913170235euoutp0217f68479f245034cd8729b8e35724d99~UBFl8iOVU0444804448euoutp02h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 17:02:35 +0000 (GMT)
Subject: Re: [PATCH v2 02/24] drivers/video/fbdev: use ioremap_wc/wt()
 instead of __ioremap()
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski
 <linux@dominikbrodowski.net>, Geoff Levand <geoff@infradead.org>, Jens Axboe
 <axboe@kernel.dk>, Kumar Gala <galak@kernel.crashing.org>, Li Yang
 <leoyang.li@nxp.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>, Scott Wood
 <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 13 Sep 2018 19:02:31 +0200
MIME-Version: 1.0
In-Reply-To: <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
Message-Id: <20180913170233eucas1p19e6cd20020f27bb4db0cd927bb9a3302~UBFkQTUaX2145421454eucas1p1M@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
 <CGME20180912155824epcas5p17cd1e14fa1cb246362ec47b15248cf71@epcas5p1.samsung.com>
 <2f980cf32a05415662272cf052c2b9e2a94c756f.1536692743.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09/12/2018 05:58 PM, Christophe Leroy wrote:
> _PAGE_NO_CACHE is a platform specific flag. In addition, this flag
> is misleading because one would think it requests a noncached page
> whereas a noncached page is _PAGE_NO_CACHE | _PAGE_GUARDED
> 
> _PAGE_NO_CACHE alone means write combined noncached page, so lets
> use ioremap_wc() instead.
> 
> _PAGE_WRITETHRU is also platform specific flag. Use ioremap_wt()
> instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

After reading patch #1 this one LGTM.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/video/fbdev/chipsfb.c    |  3 +--
>  drivers/video/fbdev/controlfb.c  |  5 +----
>  drivers/video/fbdev/platinumfb.c |  5 +----
>  drivers/video/fbdev/valkyriefb.c | 12 ++++++------
>  4 files changed, 9 insertions(+), 16 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
