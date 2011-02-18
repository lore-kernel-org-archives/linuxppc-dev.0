Return-Path: <mlcreech@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1447FB711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Feb 2011 09:03:17 +1100 (EST)
Received: by wyi11 with SMTP id 11so4104323wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Feb 2011 14:03:12 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 18 Feb 2011 17:03:12 -0500
Message-ID: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
Subject: fsl_udc_core not initializing properly?
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm upgrading from 2.6.36 to 2.6.37 on a MPC8313 ERDB-like board.  On
the new kernel, it seems like the USB gadget driver (fsl_usb2_udc) is
never initialized, so USB no longer works.

Adding some printks to the code shows that udc_init() is being run,
which calls platform_driver_probe().  However, fsl_udc_probe() is
never actually called afterward.  As a result, 'udc_controller' is
left NULL, and the subsequent call to usb_gadget_probe_driver()
returns -ENODEV.

I'm not familiar with the USB driver model, and tracing backward
through the call chains didn't reveal much, so I was hoping someone
here would have a better idea what could've changed between 2.6.36 and
2.6.37 that broke fsl_udc_core/fsl_usb2_udc.  Thanks!

-- 
Matthew L. Creech
