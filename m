Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 6150C6875C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 04:34:49 +1100 (EST)
Date: Tue, 15 Nov 2005 08:55:32 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051115165532.GB12968@kroah.com>
References: <437A1208.2060804@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437A1208.2060804@ru.mvista.com>
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

On Tue, Nov 15, 2005 at 07:51:20PM +0300, Vitaly Bordug wrote:
> Hi, Greg!
> 
> While doing "platformization" for one of the Freescale SoC's, I have 
> discovered a serious drawback of the model - it prevents registering 
> driver with the same name.

That's not a "drawback" :)

> For instance, cpm2 on either ppc82xx or ppc85xx is very flexible, and 
> its device fsl-cpm-scc could (and actually are) utilized in the 
> different drivers.
> 
> Those devices will have different bus_id, but pdev->name fields are the 
> same for all the fsl-cpm-scc, only id is different there. Hence the 
> fsl-cpm-scc could be driver_register'ed only once, while it is required 
> several times.

A driver is registered only once, but can be bound to multiple devices
just fine, right?

> Could you please suggest possible solutions for this situation? This is 
> relatively common case among freescale chips, so I guess inventing a 
> workaround is odd, and writing an additional shim to handle CPM device 
> multiplexing  is odd either.

I don't see the problem here.  Are you looking at the new stuff in
2.6.15-rc1?

thanks,

greg k-h
