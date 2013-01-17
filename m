Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BAA6E2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 22:42:05 +1100 (EST)
Message-ID: <20727.57269.347099.324284@ipc1.ka-ro>
Date: Thu, 17 Jan 2013 12:25:41 +0100
From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Fabio Estevam <festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
 <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
 <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
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

Hi,

Fabio Estevam writes:
> On Thu, Jan 17, 2013 at 8:01 AM, Peter Chen <peter.chen@freescale.com> wrote:
> 
> >         /* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
> > -       if (!cpu_is_mx51()) {
> > +       if (!strcmp(pdev->id_entry->name, "imx-udc-mx27")) {]]
> 
> Shouldn't this be:
>  if (!strcmp(pdev->id_entry->name, "imx-udc-mx51"))
>
The equivalent of !cpu_is_mx51() would be
strcmp(pdev->id_entry->name, "imx-udc-mx51") (without the '!') meaning
id_entry->name is different from "imx-udc-mx51".

I personally hate the '!strcmp()' notation and prefer 'strcmp() == 0'
though they are technically equivalent. Using '==' makes it much
clearer to the reader what is intended.
!strcmp() lets one assume that it is true when the comparison fails,
though actually the opposite is true.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
