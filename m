Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A173B6EEC
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2012 13:34:44 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] drivers/video: compile fixes for fsl-diu-fb.c
Date: Mon, 16 Jan 2012 02:34:37 +0000
Message-ID: <4F138CBB.1080901@freescale.com>
References: <19504.1326673788@neuling.org> <4F1370C9.9010400@freescale.com>
 <21913.1326675139@neuling.org>
In-Reply-To: <21913.1326675139@neuling.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> In message<4F1370C9.9010400@freescale.com>  you wrote:
>> Michael Neuling wrote:
>>> Fix a bunch of compiler errors and warnings introduced in:
>>>     commit ddd3d905436b572ebadc09dcf2d12ca5b37020a0
>>>     Author: Timur Tabi<timur@freescale.com>
>>>     drivers/video: fsl-diu-fb: merge all allocated data into one block
>>>
>>> Signed-off-by: Michael Neuling<mikey@neuling.org>
>>> ---
>>> Timur: you do compile test your patches, right? :-P
>>
>> I have a script that tests each commit in a set to make sure it compiles=
,
>> so that git-bisect isn't broken.
>
> May I suggest you actually run the script next time :-P

Tomorrow, when I get into the office, I'll take a look.  But my code has=20
always compiled.  Can you give me the output of your compiler?

> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index acf292b..3006b2b 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
> @@ -1432,7 +1432,7 @@ static int fsl_diu_suspend(struct platform_device *=
ofdev, pm_message_t state)
>   	struct fsl_diu_data *data;
>
>   	data =3D dev_get_drvdata(&ofdev->dev);
> -	disable_lcdc(data->fsl_diu_info[0]);
> +	disable_lcdc(&(data->fsl_diu_info[0]));
>
>   	return 0;
>   }
> @@ -1442,7 +1442,7 @@ static int fsl_diu_resume(struct platform_device *o=
fdev)
>   	struct fsl_diu_data *data;
>
>   	data =3D dev_get_drvdata(&ofdev->dev);
> -	enable_lcdc(data->fsl_diu_info[0]);
> +	enable_lcdc(&(data->fsl_diu_info[0]));

I prefer this:

	disable_lcdc(data->fsl_diu_info);

Your change makes sense.  I don't understand why it compiles on my system.=
=20
  Something strange is going on.

--=20
Timur Tabi
Linux kernel developer at Freescale=
