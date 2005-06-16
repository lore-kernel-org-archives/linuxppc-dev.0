Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B710A679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 05:33:04 +1000 (EST)
In-Reply-To: <678305db5ee1488bb48a26a4a89c121a@freescale.com>
References: <0fc7d3f2fe1266cdd0beaf44a71bc27c@embeddededge.com>
	<678305db5ee1488bb48a26a4a89c121a@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ccd0a576b8d78c2c4f5a174953eff0cd@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 16 Jun 2005 15:33:00 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 16, 2005, at 11:33 AM, Kumar Gala wrote:

> If I understand you correctly this is not any different than how we 
> handle the TSEC (gianfar) on 85xx.  The platform device structure just 
> gives us physical address (start & end) and IRQs and we use a 
> structure in the driver that maps to the start address.

Yes, that's correct.  However, some of the other devices may be more
challenging, since the set up SCC ports involves accessing multiple
areas of the CPM (parameter ram, device control, BRGs, serial mux,
TDM, etc), for example.  This is why I created the whole immap structure
in the first place.  With a single pointer to it, plus knowing the usage
of the device, I could easily get to all of the necessary spaces.
Using the resource reservation isn't always appropriate either, because
there are lots of shared registers or device spaces in the CPM.  It
may keep you from multiply using a specific SCC, but there are many
other places requiring configuration that are more likely to be
improperly configured by other drivers.

Also, I'm not a fan of the gfar_read/write functions because I never
know their implementation :-)  They use the in/out macros which I
never know if they are for PCI IO or not.  We aren't using any
pipeline synchronization, which we may need.  By the way, I do like
using separate synchronization, not hidden in the in/out functions.

Thanks.


	-- Dan
