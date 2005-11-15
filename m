Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 075666878E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 06:27:12 +1100 (EST)
Date: Tue, 15 Nov 2005 09:59:55 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051115175955.GA14518@kroah.com>
References: <437A1208.2060804@ru.mvista.com> <20051115165532.GB12968@kroah.com>
	<437A21EA.5020507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437A21EA.5020507@ru.mvista.com>
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

On Tue, Nov 15, 2005 at 08:59:06PM +0300, Vitaly Bordug wrote:
> Greg KH wrote:
> >On Tue, Nov 15, 2005 at 07:51:20PM +0300, Vitaly Bordug wrote:
> >>Hi, Greg!
> >>
> >>While doing "platformization" for one of the Freescale SoC's, I have 
> >>discovered a serious drawback of the model - it prevents registering 
> >>driver with the same name.
> >
> >That's not a "drawback" :)
> >
> >>For instance, cpm2 on either ppc82xx or ppc85xx is very flexible, and 
> >>its device fsl-cpm-scc could (and actually are) utilized in the 
> >>different drivers.
> >>
> >>Those devices will have different bus_id, but pdev->name fields are the 
> >>same for all the fsl-cpm-scc, only id is different there. Hence the 
> >>fsl-cpm-scc could be driver_register'ed only once, while it is required 
> >>several times.
> >
> >A driver is registered only once, but can be bound to multiple devices
> >just fine, right?
> Please let me know, how?

All PCI and USB and I2C drivers are able to bind to multiple devices :)

> I have for instance struct device_driver with name="fsl-cpm-scc" in both 
> fs_enet and cpm_uart(one using SCC1, the other - SCC4, the same device with 
> different id's).
> 
> Once it has been registered in fs_enet, I could not register it in 
> cpm_uart, due to kobject_register fo require unique names in kobject->name. 
> Am I missing something?

You only register the driver once.  The individual devices can be bound
to the same driver, right?

> Not registering it in CPM_UART, how the pdev could be obtained?
> 
> Maybe this is clear, but platform stuff is cumbersome some times...

Then make it cleaner :)

If you have specific code that explains this better, that might help
out.

thanks,

greg k-h
