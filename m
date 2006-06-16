Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx008.isp.belgacom.be (outmx008.isp.belgacom.be
	[195.238.5.235])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDC9B67B69
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Jun 2006 00:49:09 +1000 (EST)
Received: from outmx008.isp.belgacom.be (localhost [127.0.0.1])
	by outmx008.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5GEmxhQ012389
	for <linuxppc-embedded@ozlabs.org>; Fri, 16 Jun 2006 16:49:00 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: Binding FCC interfaces to device names in reverse order
Date: Fri, 16 Jun 2006 16:50:50 +0200
References: <200606151359.02966.laurent.pinchart@tbox.biz>
	<20060615165344.7db8444e@vitb.ru.mvista.com>
In-Reply-To: <20060615165344.7db8444e@vitb.ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606161650.51229.laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Does anyone know why changing the device ids breaks the fs_enet driver ?
>
> Obviously, because board-specific platform_data fixup use that id field to
> detect what soc device is that - fcc1 or fcc2 this case. So the phy's will
> be wrong-assigned, as well as other stuff.
>
> To change order pdevs are registered, you may try to disable all the fccs
> at the startup, and then enable them after ppc_sys_init, or just shoot
> enable-disable seq (this was't tested at all, but supposed to work).

Enabling the FCCs in a device_initcall() call instead of arch_initcall() 
works. I had to call ppc_sys_device_fixup manually.

Thanks for your help.

Laurent Pinchart
