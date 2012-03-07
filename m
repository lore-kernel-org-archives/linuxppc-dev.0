Return-Path: <jassisinghbrar@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9F4DB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 05:09:29 +1100 (EST)
Received: by bkwj10 with SMTP id j10so5693060bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2012 10:09:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Date: Wed, 7 Mar 2012 23:39:25 +0530
Message-ID: <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] DMA engine cookie handling cleanups
From: Jassi Brar <jassisinghbrar@gmail.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Vinod Koul <vinod.koul@intel.com>, Barry Song <baohua.song@csr.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 7, 2012 at 4:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> [v2 - more or less same description. =C2=A0Including lakml in cc for the =
full
> set]
>
> This patch series cleans up the handling of cookies in DMA engine drivers=
.
> This is done by providing a set of inline library functions for common
> tasks:
>
> - moving the 'last completed cookie' into struct dma_chan - everyone
> =C2=A0has this in their driver private channel data structure
>
> - consolidate allocation of cookies to DMA descriptors
>
> - common way to update 'last completed cookie' value
>
> - standard way to implement tx_status callback and update the residue
>
> - consolidate initialization of cookies
>
> - update implementations differing from the majority of DMA engine driver=
s
> =C2=A0to behave the same as the majority implementation in respect of coo=
kies
>
> What this means is that we get to the point where all DMA engine drivers
> will hand out cookie value '2' as the first, and incrementing cookie
> values up to INT_MAX, returning to cookie '1' as the next cookie.
>
> Think of this patch series as round 1... =C2=A0I am hoping over time that=
 more
> code can be consolidated between the DMA engine drivers and end up with a
> consistent way to handle various common themes in DMA engine hardware
> (like physical channel<->peripheral request signal selection.)
>
Compilation is broken without the following minor fix.
After that you may add
       Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 49c123f..abf35a3 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -339,7 +339,6 @@ static int pl330_control(struct dma_chan *chan,
enum dma_ctrl_cmd cmd, unsigned
 		/* Mark all desc done */
 		list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
 			desc->status =3D DONE;
-			pch->completed =3D desc->txd.cookie;
 			list_move_tail(&desc->node, &list);
 		}


Thanks.
