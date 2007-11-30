Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 66294DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 02:04:57 +1100 (EST)
Message-ID: <47502679.2000303@freescale.com>
Date: Fri, 30 Nov 2007 09:04:25 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: fabien <fabien.fb@gmail.com>
Subject: Re: ppcboot and powerpc branch question
References: <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>	<fa686aa40711300543i47991fa6m9812231625205026@mail.gmail.com>
	<f8f856500711300645p13dc4cb7m10d3361e1393632b@mail.gmail.com>
In-Reply-To: <f8f856500711300645p13dc4cb7m10d3361e1393632b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

fabien wrote:
> Ok, thanks
> So do I need to define a dts file or the bd_t struct only will be
> sufficient to boot with cuImage ?

You need to define a dts file (see the existing ones in 
arch/powerpc/boot/dts for examples), and set CONFIG_DEVICE_TREE to tell 
the wrapper which one to include.

Note that this dts must have linux,network-index properties in the 
network nodes for the MAC addresses to be filled in, and must have 
/chosen/linux,stdout-path if you want output from the wrapper (useful if 
something goes wrong (such as insufficient memory to relocate the 
kernel) or if you want to edit the command line).

You also need to do make zImage rather than make uImage for cuImage to 
be built.

-Scott
