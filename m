Return-Path: <pku.leo@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Df0N2ytczF0fg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 07:10:11 +1000 (AEST)
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so20278846oiw.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 14:10:11 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com.
 [209.85.210.51])
 by smtp.gmail.com with ESMTPSA id u68-v6sm5205293otb.81.2018.09.17.14.10.09
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Sep 2018 14:10:09 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id j9-v6so12832888otl.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 14:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180915111005.10028-1-yuehaibing@huawei.com>
In-Reply-To: <20180915111005.10028-1-yuehaibing@huawei.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 17 Sep 2018 16:09:57 -0500
Message-ID: <CADRPPNSQp78jioP8Eao3ku_vqYCddRTuz1sydskUiPWTfmSUGQ@mail.gmail.com>
Subject: Re: [PATCH -next] fsl/qe: Fix copy-paste error in
 ucc_get_tdm_sync_shift
To: yuehaibing@huawei.com
Cc: Zhao Qiang <qiang.zhao@nxp.com>, lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Sep 15, 2018 at 6:11 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> if 'mode' is COMM_DIR_TX, 'shift' should use TX_SYNC_SHIFT_BASE
>
> Fixes: bb8b2062aff3 ("fsl/qe: setup clock source for TDM mode")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for submitting the patch, but there is already the same fix in
the queue from Zhao Qiang and Dan Carpenter.

> ---
>  drivers/soc/fsl/qe/ucc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qe/ucc.c b/drivers/soc/fsl/qe/ucc.c
> index c646d87..681f7d4 100644
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
> --
> 1.8.3.1
>
>
