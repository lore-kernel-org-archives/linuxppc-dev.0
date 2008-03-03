Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 7736EDDE17
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 14:43:59 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2 v2] [POWERPC] Ignore disabled serial ports
Date: Mon, 3 Mar 2008 04:43:42 +0100
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301081746.689a0a17@zod.rchland.ibm.com>
In-Reply-To: <20080301081746.689a0a17@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803030443.43346.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 01 March 2008, Josh Boyer wrote:
> --- linux-2.6.orig/drivers/serial/of_serial.c
> +++ linux-2.6/drivers/serial/of_serial.c
> @@ -72,6 +72,11 @@ static int __devinit of_platform_serial_
> =A0=A0=A0=A0=A0=A0=A0=A0int port_type;
> =A0=A0=A0=A0=A0=A0=A0=A0int ret;
> =A0
> +=A0=A0=A0=A0=A0=A0=A0if (!of_device_is_available(ofdev->node)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_info(&ofdev->dev, "Disa=
bled serial port. =A0Ignored\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> +=A0=A0=A0=A0=A0=A0=A0}
> +
> =A0=A0=A0=A0=A0=A0=A0=A0if (of_find_property(ofdev->node, "used-by-rtas",=
 NULL))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;

I wonder whether we should move the check for "used-by-rtas" into the
of_device_is_available function. I understand that used-by-rtas is
another way of expressing the idea that the kernel is not supposed to
access the specific device. In this case, the device is physically
present, but is not available to the OS.

	Arnd <><
