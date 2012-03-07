Return-Path: <jassisinghbrar@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA736B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 05:44:56 +1100 (EST)
Received: by bkwj10 with SMTP id j10so5725919bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2012 10:44:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120307182155.GD18787@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
 <20120307182155.GD18787@n2100.arm.linux.org.uk>
Date: Thu, 8 Mar 2012 00:14:52 +0530
Message-ID: <CABb+yY0SpuOqFP396Q7me3Em=1OYD9Ndt47EXAs6Aem0q-goQA@mail.gmail.com>
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

On Wed, Mar 7, 2012 at 11:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 07, 2012 at 11:39:25PM +0530, Jassi Brar wrote:
>> Compilation is broken without the following minor fix.
>> After that you may add
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Acked-by: Jassi Brar <jassisinghbrar@gmail.co=
m>
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 49c123f..abf35a3 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -339,7 +339,6 @@ static int pl330_control(struct dma_chan *chan,
>> enum dma_ctrl_cmd cmd, unsigned
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Mark all desc done *=
/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_saf=
e(desc, _dt, &pch->work_list , node) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 desc->status =3D DONE;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
pch->completed =3D desc->txd.cookie;
>
> I'm not sure just removing this is sufficient. =C2=A0Presumably it's
> there for some reason - maybe it needs replacing with a call to
> dma_cookie_complete() to preserve existing behaviour?
>
That was anyway a redundant save in DMA_TERMINATE_ALL, so it should be ok.
