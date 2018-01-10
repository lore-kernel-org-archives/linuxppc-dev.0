Return-Path: <pku.leo@gmail.com>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH4123mh7zDqpX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 09:48:21 +1100 (AEDT)
Received: by mail-io0-f196.google.com with SMTP id f6so1179345ioh.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 14:48:21 -0800 (PST)
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com.
 [209.85.223.181])
 by smtp.gmail.com with ESMTPSA id g143sm10309159iog.34.2018.01.10.14.48.19
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jan 2018 14:48:19 -0800 (PST)
Received: by mail-io0-f181.google.com with SMTP id n14so1190875iob.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 14:48:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <DB6PR0401MB2536946B309CD2F95E230CC3F8130@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1515244954-8374-1-git-send-email-festevam@gmail.com>
 <DB6PR0401MB2536946B309CD2F95E230CC3F8130@DB6PR0401MB2536.eurprd04.prod.outlook.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 10 Jan 2018 16:48:18 -0600
Message-ID: <CADRPPNRu6mAYorsZ5BZ9r1=pxgHDF-SJrboV_RfLaP6fgHOk2A@mail.gmail.com>
Subject: Re: [PATCH] soc/fsl/guts: Add a NULL check for devm_kasprintf()
To: "Y.b. Lu" <yangbo.lu@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 7, 2018 at 9:06 PM, Y.b. Lu <yangbo.lu@nxp.com> wrote:
>> -----Original Message-----
>> From: Fabio Estevam [mailto:festevam@gmail.com]
>> Sent: 2018=E5=B9=B41=E6=9C=886=E6=97=A5 21:23
>> To: Leo Li <leoyang.li@nxp.com>
>> Cc: linuxppc-dev@lists.ozlabs.org; Y.b. Lu <yangbo.lu@nxp.com>; Fabio
>> Estevam <fabio.estevam@nxp.com>
>> Subject: [PATCH] soc/fsl/guts: Add a NULL check for devm_kasprintf()
>>
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> devm_kasprintf() may fail, so we should better add a NULL check and
>> propagate an error on failure.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> [Y.b. Lu] It makes sense.
> Acked-by: Yangbo Lu <yangbo.lu@nxp.com>

Merged.  Thanks.

>
>> ---
>>  drivers/soc/fsl/guts.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c index
>> d89a6a8..82251b4 100644
>> --- a/drivers/soc/fsl/guts.c
>> +++ b/drivers/soc/fsl/guts.c
>> @@ -167,10 +167,16 @@ static int fsl_guts_probe(struct platform_device
>> *pdev)
>>       } else {
>>               soc_dev_attr.family =3D devm_kasprintf(dev, GFP_KERNEL, "Q=
orIQ");
>>       }
>> +     if (!soc_dev_attr.family)
>> +             return -ENOMEM;
>>       soc_dev_attr.soc_id =3D devm_kasprintf(dev, GFP_KERNEL,
>>                                            "svr:0x%08x", svr);
>> +     if (!soc_dev_attr.soc_id)
>> +             return -ENOMEM;
>>       soc_dev_attr.revision =3D devm_kasprintf(dev, GFP_KERNEL, "%d.%d",
>>                                              (svr >>  4) & 0xf, svr & 0x=
f);
>> +     if (!soc_dev_attr.revision)
>> +             return -ENOMEM;
>>
>>       soc_dev =3D soc_device_register(&soc_dev_attr);
>>       if (IS_ERR(soc_dev))
>> --
>> 2.7.4
>
