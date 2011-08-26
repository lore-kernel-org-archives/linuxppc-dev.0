Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9CBA6B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Aug 2011 06:08:43 +1000 (EST)
Received: from mail100-am1 (localhost.localdomain [127.0.0.1])	by
	mail100-am1-R.bigfish.com (Postfix) with ESMTP id 200CB180467	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 20:08:37 +0000 (UTC)
Message-ID: <4E57FD3D.6090809@freescale.com>
Date: Fri, 26 Aug 2011 15:08:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <smitha.vanga@wipro.com>
Subject: Re: Kernel boot up
References: <07ACDFB8ECA8EF47863A613BC01BBB22035E3D59@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <07ACDFB8ECA8EF47863A613BC01BBB22035E3D59@HYD-MKD-MBX02.wipro.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/26/2011 01:00 AM, smitha.vanga@wipro.com wrote:
>  
> Thanks scott.
> 
> There was an issue with the file system. Now my board is up with the
> linux boot prompt .
> But ping is not working. 

You still haven't set your MAC address.  U-Boot should be fixing this up
in the device tree.

> The local loopback ping works. My phy chip
> BCM5221 is connected on port A

Your device tree describes a connection on port C.  You need to update
the mdio node's reg to point to port A's registers (0x10d00), and
fsl,mdio-pin and fsl,mdc-pin need to be set to the particular pins your
board uses.

-Scott
