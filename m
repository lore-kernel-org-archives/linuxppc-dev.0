Return-Path: <linwoes@gmail.com>
Received: from sccrmhc11.comcast.net (sccrmhc14.comcast.net [204.127.202.59])
	by ozlabs.org (Postfix) with ESMTP id 47E1B67A7B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2005 00:32:31 +1100 (EST)
From: Linwoes <linwoes@gmail.com>
To: linuxppc-dev@ozlabs.org, Nicolas DET <det.nicolas@free.fr>,
	James Chapman <jchapman@katalix.com>
Date: Mon, 7 Mar 2005 08:23:25 -0500
References: <20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
In-Reply-To: <20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503070823.25642.linwoes@gmail.com>
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> About arch/ppc/syslibs/ mv64x60 code. Well, it's a bit evil as it has
> hardcoded IRQ, hardcoded register base, it changes
> chipset configuration... whereas all of these is already done by the
> Pegasos II OpenFirmWare.
>
All of the hardcoded IRQs are not really hardcoded. They are easily 
overridable in you platform file using a fixup routine as seen in katana.c 
flags can be added also. 

As far as the register base being hardcoded, I don't see it. The config 
options:
CONFIG_MV64X60_BASE=0xf1000000
CONFIG_MV64X60_NEW_BASE=0xf1000000
will allow you register base to be anywhere you would like it.

If you don't need to reinitialize the chip, then don't call mv64x60_init(). 
The only part of mv64x60_init() I see that is not chip related is the 
pci_alloc_hoses(). I guess you could make a new function for that part and 
maybe others you need so the code does not get duplicated in your platform 
files.
Again, mv64x60_early_init() does very little non-chipset stuff and you could 
probably just place the:
        mv64x60_bridge_pbase = bh->p_base;
        mv64x60_bridge_vbase = bh->v_base;
initializers into your platform files.

Thanks
Brian
