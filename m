Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF0D5DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 04:46:57 +1100 (EST)
Date: Mon, 18 Feb 2008 11:47:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: How to describe FPGA-based devices in the device tree ?
Message-ID: <20080218174701.GA3835@loki.buserror.net>
References: <200802181343.54989.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802181343.54989.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2008 at 01:43:52PM +0100, Laurent Pinchart wrote:
>                 bcsr@3,0 {
>                         device_type = "board-control";
>                         reg = <3 0 00000020>;
>                 };

No device_type.  Needs a compatible.

> 
>                 fpga@4,0 {
>                         reg = <4 0 00010000>;
>                 };
>         };
> 
> The fourth device is a FPGA that contains several IP cores such as an 
> interrupt controller and a SD/MMC host controller. If I understand things 
> correctly, each IP core should have its own node in the device tree to allow 
> proper binding with device drivers. 

Correct.

> As booting-without-of.txt describes the localbus node ranges as
> corresponding to a single chipselect and covering the entire chipselect
> access window, I can't have nodes for each IP core as children of the
> localbus node.

That does not follow.  The ranges entry has to cover the whole chipselect,
but there's no one-to-one correspondence between nodes and ranges entries.

There's nothing wrong with doing this:

fpga@4,0 {
	compatible = "foo,bar";
	reg = <4 0 00010000>;
};

fpga@4,10000 {
	compatible = "foo,baz";
	reg = <4 00010000 00010000>;
};

fpga@4,20000 {
	compatible = "foo,blah";
	reg = <4 00020000 00010000>;
};

> Should I put IP core nodes as children of the FPGA node ?

You could do that as well.

> If so, how do I map addresses at the FPGA level ? A ranges property in the
> FPGA node would let me map addresses in the FPGA scope to the localbus
> scope. However, as the localbus scope use the chipselect number as its
> first address cell and 0 as its second address cell,

The second cell is the address within the chipselect.  If it were always
zero, it wouldn't be there at all.

-Scott
