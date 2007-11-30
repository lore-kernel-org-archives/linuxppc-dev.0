Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 865B9DDE21
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 02:19:28 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lAUFJNbb006798
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 08:19:24 -0700 (MST)
Date: Fri, 30 Nov 2007 09:19:28 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] Add MPC837xEMDS PCIE RC mode support
Message-ID: <20071130151928.GB29484@loki.buserror.net>
References: <1196394334.29683.5.camel@Guyver>
	<4544168D-5E95-44E8-9128-6F343283EC82@freescale.com>
	<1196412491.31962.9.camel@Guyver>
	<7DF684FC-A53A-4F4D-903F-D50F1E0A486A@freescale.com>
	<1196415470.2371.28.camel@Guyver>
	<6FF36777-D91C-4B80-968B-CAEF11BC98ED@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6FF36777-D91C-4B80-968B-CAEF11BC98ED@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Li Li <r64360@freescale.com>,
	Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 30, 2007 at 08:57:33AM -0600, Kumar Gala wrote:
> On Nov 30, 2007, at 3:37 AM, Li Li wrote:
> > If do it standard, a 256M config space, at least 256M mem space and  
> > 16M
> > io space are needed for each PCIE controller.
> > To allocate PCIE window, the window size only can be 512M or 1G.
> > If we choose 1G space, two PCIE controller needs 2G space.
> > We do not have 2G free physical space now. Usually, we use upper 128M
> > configure space. So, we have to cut down the config space.

That decision should be made in the kernel, not the dts.

> Is it possible to make the outbound window for cfg space 4k and change  
> the region of config space its looking at?

Yes, that'd be best.

> > Here is a little complex. The MPC837xE board needs a carrier board to
> > extend PCIE slot. If user does not populate carrier board onto MPC837xE
> > board and do PCIE scan, the system will halt. I just want to provide a
> > easy way to disable the PCIe other than modify and recompile the dts.
> 
> So I have to recompile the kernel for this case, that seems even more  
> painful to the user.  Can we not detect if this board isn't there and  
> not hang?

Assuming it's similar to PCI on other 83xxMDS, yes -- there's a bit in the
reset control words that can be checked.

We don't currently do it on any 83xx that I'm aware of, though. :-P

-Scott
