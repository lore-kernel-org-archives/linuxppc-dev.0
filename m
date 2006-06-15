Return-Path: <jotken@softadvances.com>
Received: from smtpauth04.mail.atl.earthlink.net
	(smtpauth04.mail.atl.earthlink.net [209.86.89.64])
	by ozlabs.org (Postfix) with ESMTP id 6C88267B69
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 22:17:45 +1000 (EST)
Message-ID: <44914FEB.6040704@softadvances.com>
Date: Thu, 15 Jun 2006 07:17:47 -0500
From: John Otken <jotken@softadvances.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: Binding FCC interfaces to device names in reverse order
References: <200606151359.02966.laurent.pinchart@tbox.biz>
In-Reply-To: <200606151359.02966.laurent.pinchart@tbox.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Does it work if you plug a cable into both Ethernets?  If so, then
your PHYs might not be correctly mapped.

Laurent Pinchart wrote:
> Hello,
> 
> I'm trying to change the order in which the MPC8248 FCC devices are bound to 
> network interface names.
> 
> The current behaviour is to handle FCC1, FCC2 and FCC3 in that order. FCC1 is 
> thus mapped to eth0 and FCC2 to eth1 (FCC3 is unused in my design).
> 
> For some reason I'd like to map FCC2 to eth0 and FCC1 to eth1. Interface names 
> are allocated as devices are registered, so I thought I could change the 
> detection order by modifying the ppc_sys_platform_devices array:
> 
>         ppc_sys_platform_devices[MPC82xx_CPM_FCC1].id = 2;
>         ppc_sys_platform_devices[MPC82xx_CPM_FCC2].id = 1;
> 
> FCC devices detection is indeed reversed, and FCC2 is mapped to eth0. Plugging 
> a cable into the FCC2 socket prints a message referencing eth0, and ifconfig 
> confirms that eth0 is running.
> 
> Unfortunately, that's where things stop working. I can't ping FCC1 or FCC2, no 
> data is received by the kernel.
> 
> Does anyone know why changing the device ids breaks the fs_enet driver ?
> 
> Laurent Pinchart
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
