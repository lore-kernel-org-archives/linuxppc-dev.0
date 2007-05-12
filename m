Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id B1B5BDDE45
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 09:11:18 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] pasemi: electra IDE/pata_platform glue
Date: Sun, 13 May 2007 01:11:02 +0200
References: <20070512145041.GA13025@lixom.net>
In-Reply-To: <20070512145041.GA13025@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705130111.03153.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-ide@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 12 May 2007, Olof Johansson wrote:
> 
> We unfortunately need to modify the resources before calling the generic
> platform driver, since the device tree only has one register window in
> it and the driver expects two. Adding this as an of_platform driver
> instead doesn't give us any benefit, it just adds one more layer of
> register/probe functions.

Why not provide a proper pata_of.c driver based on ata_generic? That
will help the next person that has a builtin ata controller and wants
to get it running as an of_device.

If you simply export generic_sht (rename that to ata_generic_sht)
and generic_port_ops (-> ata_generic_port_ops), then the resulting
of_platform_driver should be no more complicated than the one
you are proposing here.

	Arnd <><  
