Return-Path: <mlcreech@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43A63B6F81
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 02:47:40 +1100 (EST)
Received: by wyj26 with SMTP id 26so4297166wyj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Mar 2011 08:47:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110312090002.7b703e61@wker>
References: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
	<20110219095253.39540a57@wker>
	<AANLkTikvPOak6mamoeBrDBS5j_M3KuPmQi6DR5Ng6vki@mail.gmail.com>
	<AANLkTi=B4O7u3S3qsa_zfDKWp33hXw3Yp5j6szRXDgfJ@mail.gmail.com>
	<20110312090002.7b703e61@wker>
Date: Mon, 14 Mar 2011 11:47:35 -0400
Message-ID: <AANLkTi=p9C+NpwyYCQBE7v1k1H-GW44tPxm7BjKXQB_P@mail.gmail.com>
Subject: Re: fsl_udc_core not initializing properly?
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 12, 2011 at 3:00 AM, Anatolij Gustschin <agust@denx.de> wrote:
>
> Can you please apply the attached patch, then build with your
> linux.config and send me the kernel boot log? It will help to
> fix the issue.
>

Actually, this kernel seems to work:

...
Freescale PowerQUICC MII Bus: probed
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
fsl_usb2_mph_dr_of_probe
Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)
fsl_udc_probe
g_ether gadget: using random self ethernet address
...

Oddly enough, the kernel I tried last week did the same thing (I
hard-coded "obj-y += usb/host/" into drivers/Makefile), but I had a
printk() at the top of fsl_udc_probe() that never got called.

Oh, I see the difference now: you added the usb/host/ entry before
usb/gadget/, while I added it afterward...  I forgot that link order
determines initialization order in the kernel.

Anyway, seems to work fine.  :)  Thanks Antolij!

-- 
Matthew L. Creech
