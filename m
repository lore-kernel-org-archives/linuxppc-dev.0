Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4C85068784
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 06:43:40 +1100 (EST)
In-Reply-To: <20051115175955.GA14518@kroah.com>
References: <20051115175955.GA14518@kroah.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <96E15040-E751-475E-8A63-D20F77D69B50@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Tue, 15 Nov 2005 13:43:39 -0600
To: Greg KH <greg@kroah.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform device model drawback
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 15, 2005, at 11:59, Greg KH wrote:


> > I have for instance struct device_driver with name="fsl-cpm-scc"  
> in both
> > fs_enet and cpm_uart(one using SCC1, the other - SCC4, the same  
> device with
> > different id's).
> >
> > Once it has been registered in fs_enet, I could not register it in
> > cpm_uart, due to kobject_register fo require unique names in  
> kobject->name.
> > Am I missing something?
>
> You only register the driver once.  The individual devices can be  
> bound
> to the same driver, right?
>
> > Not registering it in CPM_UART, how the pdev could be obtained?
> >
> > Maybe this is clear, but platform stuff is cumbersome some times...
>
> Then make it cleaner :)
>
> If you have specific code that explains this better, that might help
> out.
>

So the problem Vitaly is referring to is that the CPM is somewhat  
programmable.  The SCC (Serial Communications Controller) is capable  
of being used as a uart, or as an ethernet device, depending on  
software configuration.  Currently, most systems I'm aware of  
configure this at boot time, depending on how the kernel has been  
configured.  So the same SOC may have SCC1 as a uart on one board,  
but as an ethernet controller on another board.

I believe there is work being done to clean this up, and make it more  
flexible.  As a temporary solution, we might want to declare 8  
different devices.  Something like "cpm-scc-uart", and "cpm-scc- 
enet".  And then create SCC1-4 twice, and let the board code delete  
the devices that aren't going to be used.

Andy
