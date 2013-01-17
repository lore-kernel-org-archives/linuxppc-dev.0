Return-Path: <festevam@gmail.com>
Received: from mail-vb0-f41.google.com (mail-vb0-f41.google.com
 [209.85.212.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 506CD2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2013 01:43:27 +1100 (EST)
Received: by mail-vb0-f41.google.com with SMTP id l22so2529272vbn.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 06:43:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20727.57269.347099.324284@ipc1.ka-ro>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
 <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
 <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
 <20727.57269.347099.324284@ipc1.ka-ro>
Date: Thu, 17 Jan 2013 12:43:23 -0200
Message-ID: <CAOMZO5DNVMAG3btGR7DeukgWaEaPe2zqm=EKAHQ5ovawq+BiWw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Content-Type: text/plain; charset=UTF-8
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 balbi@ti.com, Peter Chen <peter.chen@freescale.com>, kernel@pengutronix.de,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2013 at 9:25 AM, Lothar Wa=C3=9Fmann <LW@karo-electronics.d=
e> wrote:

> The equivalent of !cpu_is_mx51() would be
> strcmp(pdev->id_entry->name, "imx-udc-mx51") (without the '!') meaning
> id_entry->name is different from "imx-udc-mx51".

Yes, agree.

strcmp(pdev->id_entry->name, "imx-udc-mx51") is also better than
!strcmp(pdev->id_entry->name, "imx-udc-mx27"))

because in the case of another soc entry gets added, let's say
"imx-udc-mxyy" then

!strcmp(pdev->id_entry->name, "imx-udc-mx27")) will not correspond to
!cpu_is_mx51() anymore.
