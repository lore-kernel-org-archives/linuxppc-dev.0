Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-f196.google.com (mail-ot0-f196.google.com
 [74.125.82.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ztw54xBLzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 22:07:01 +1000 (AEST)
Received: by mail-ot0-f196.google.com with SMTP id l12-v6so37294757oth.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 05:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180604115842.7c4vzge3igjbnblt@kili.mountain>
In-Reply-To: <20180604115842.7c4vzge3igjbnblt@kili.mountain>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 4 Jun 2018 14:06:45 +0200
Message-ID: <CA+7wUszWKm+qZQ7CQu3Kn7-aYeM-hSet03_PEh8EswNn141nyw@mail.gmail.com>
Subject: Re: [PATCH] fsl/qe: ucc: copy and paste bug in
 ucc_get_tdm_sync_shift()
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: qiang.zhao@nxp.com, kernel-janitors@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, leoyang.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Where did the original go ?

https://patchwork.ozlabs.org/patch/868158/


On Mon, Jun 4, 2018 at 2:02 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> There is a copy and paste bug so we accidentally use the RX_ shift when
> we're in TX_ mode.
>
> Fixes: bb8b2062aff3 ("fsl/qe: setup clock source for TDM mode")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static analysis work.  Not tested.  This affects the success path, so
> we should probably test it.
>
> diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
> index c646d8713861..681f7d4b7724 100644
> --- a/drivers/soc/fsl/qe/ucc.c
> +++ b/drivers/soc/fsl/qe/ucc.c
> @@ -626,7 +626,7 @@ static u32 ucc_get_tdm_sync_shift(enum comm_dir mode, u32 tdm_num)
>  {
>         u32 shift;
>
> -       shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : RX_SYNC_SHIFT_BASE;
> +       shift = (mode == COMM_DIR_RX) ? RX_SYNC_SHIFT_BASE : TX_SYNC_SHIFT_BASE;
>         shift -= tdm_num * 2;
>
>         return shift;
