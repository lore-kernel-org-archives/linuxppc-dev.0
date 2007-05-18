Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 83C22DDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 04:03:45 +1000 (EST)
Message-ID: <464DEA7B.1000403@smiths-aerospace.com>
Date: Fri, 18 May 2007 14:03:39 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
References: <1179245829.8132.100.camel@rhino>
	<1179247809.8132.138.camel@rhino>	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>	<1179417813.8132.250.camel@rhino>	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>	<1179421139.8132.256.camel@rhino>
	<464CA302.9060707@freescale.com>	<20070518005641.GA27350@localhost.localdomain>	<464DB986.20205@freescale.com>
	<20070518164628.GA16825@ld0162-tx32.am.freescale.net>
	<464DE2D3.3090805@smiths-aerospace.com>
	<464DE4C7.7030906@freescale.com> <464DE5D2.5000301@freescale.com>
	<464DE6C1.2010108@freescale.com> <464DE7F7.3030302@freescale.com>
	<464DE8BB.5040601@freescale.com>
In-Reply-To: <464DE8BB.5040601@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Scott Wood wrote:
> 
>> That's your model.  Mine involves merging a fragment that corresponds 
>> to an active hwoption, with no complex conditional evaluation or 
>> deletion of anything from the main tree.
> 
> I think my model (which is also Jon's, I think) is easier to read and 
> implement.
> 
>> How would you express the alternate setting of phy_type in a 
>> subtractive model?  You can't have two nodes with the same name and 
>> different phy_types, and you can't have two phy_type properties in one 
>> node.
> 
> The conditionals would have to be correct:
> 
> 
> phy-node [ if j22 = on ]
> {
>     phy-type = 1
> }
> 
> phy-node [ if j22 = off ]
> {
>     phy-type = 2
> }
> 
> Obviously, j22 can be either on or off, but never both.  If the DTS is 
> coded incorrectly, then it will have problems, but I think that's a fair 
> trade-off for the easier implementation.

OK, your syntax implies fairly significant changes to the dtc/dtb/u-boot 
(and possibly linux, depending on what detritus is left after u-boot 
does the selections).  Scott's syntax fits into the current fdt 
definition, tools, and blob-users with the exception that u-boot would 
have board specific selection code added, but that needs to be added 
regardless.

Best regards,
gvb
