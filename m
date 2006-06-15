Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 91DEA67B75
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 22:53:44 +1000 (EST)
Date: Thu, 15 Jun 2006 16:53:44 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: Binding FCC interfaces to device names in reverse order
Message-ID: <20060615165344.7db8444e@vitb.ru.mvista.com>
In-Reply-To: <200606151359.02966.laurent.pinchart@tbox.biz>
References: <200606151359.02966.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 15 Jun 2006 13:59:02 +0200
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

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

Obviously, because board-specific platform_data fixup use that id field to detect what soc device is that - fcc1 or fcc2 this case. So the phy's will be wrong-assigned, as well as other stuff. 

To change order pdevs are registered, you may try to disable all the fccs at the startup, and then enable them after ppc_sys_init, or just shoot enable-disable seq (this was't tested at all, but supposed to work).
> 
> Laurent Pinchart
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
