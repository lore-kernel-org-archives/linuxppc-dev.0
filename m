Return-Path: <michael.neuling@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E6871A1A37
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 13:25:17 +1000 (AEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id E0039140D19
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 13:25:16 +1000 (AEST)
Message-ID: <1436325916.13169.23.camel@au1.ibm.com>
Subject: Re: [PATCH] rtc/rtc-opal: Disable rtc-alarms when opal doesn't
 support tpo
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Wed, 08 Jul 2015 13:25:16 +1000
In-Reply-To: <1433307087-11503-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1433307087-11503-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> [PATCH] rtc/rtc-opal: Disable rtc-alarms when opal doesn't support tpo

I'd prefer to avoid the double negative and extra words.  ie.

  rtc/opal: Enable alarms only when opal supports tpo

But looks good other than that.

Acked-by: Michael Neuling <mikey@neuling.org>


On Wed, 2015-06-03 at 10:21 +0530, Vaibhav Jain wrote:
> rtc-opal driver provides support for rtc alarms via
> times-power-on(tpo). However some platforms like BML use a fake rtc
> clock and don't support tpo. Such platforms are indicated by the missing
> 'has-tpo' property in the device tree.
>=20
> Current implementation however enables callback for
> rtc_class_ops.read/set alarm irrespective of the tpo support from the
> platform. This results in a failed opal call when kernel tries to read
> an existing alarms via opal_get_tpo_time during rtc device registration.
>=20
> This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
> callback pointers only when tpo is supported.
>=20
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/rtc/rtc-opal.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
> index 7061dca..1125641 100644
> --- a/drivers/rtc/rtc-opal.c
> +++ b/drivers/rtc/rtc-opal.c
> @@ -190,11 +190,9 @@ exit:
>  	return rc;
>  }
> =20
> -static const struct rtc_class_ops opal_rtc_ops =3D {
> +static struct rtc_class_ops opal_rtc_ops =3D {
>  	.read_time	=3D opal_get_rtc_time,
>  	.set_time	=3D opal_set_rtc_time,
> -	.read_alarm	=3D opal_get_tpo_time,
> -	.set_alarm	=3D opal_set_tpo_time,
>  };
> =20
>  static int opal_rtc_probe(struct platform_device *pdev)
> @@ -202,8 +200,11 @@ static int opal_rtc_probe(struct platform_device *pd=
ev)
>  	struct rtc_device *rtc;
> =20
>  	if (pdev->dev.of_node && of_get_property(pdev->dev.of_node, "has-tpo",
> -						 NULL))
> +						 NULL)) {
>  		device_set_wakeup_capable(&pdev->dev, true);
> +		opal_rtc_ops.read_alarm	=3D opal_get_tpo_time;
> +		opal_rtc_ops.set_alarm =3D opal_set_tpo_time;
> +	}
> =20
>  	rtc =3D devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
>  				       THIS_MODULE);
