Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4891CDE144
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 05:40:41 +1100 (EST)
Message-ID: <49AD796A.90601@freescale.com>
Date: Tue, 03 Mar 2009 12:39:38 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] powerpc/83xx: Add power management support for	MPC837x
	boards
References: <20090303160201.GA3242@oksana.dev.rtsoft.ru>
	<20090303175746.GC8692@ld0162-tx32.am.freescale.net>
	<20090303183407.GA27678@oksana.dev.rtsoft.ru>
In-Reply-To: <20090303183407.GA27678@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Tue, Mar 03, 2009 at 11:57:46AM -0600, Scott Wood wrote:
>> On Tue, Mar 03, 2009 at 07:02:01PM +0300, Anton Vorontsov wrote:
>>>  		mdio@24520 {
>>> @@ -226,6 +244,8 @@
>>>  			interrupt-parent = <&ipic>;
>>>  			tbi-handle = <&tbi0>;
>>>  			phy-handle = <&phy2>;
>>> +			sleep = <&pmc 0xc0000000>;
>>> +			fsl,magic-packet;
>>>  		};
>> Note that this makes it look to the kernel like enet0 can be put to sleep
>> without putting the mdio (which is shared with enet1) to sleep.  This is
>> why I moved mdio under the ethernet node on 8313erdb.
> 
> And that isn't absolutely correct either, since enet1 depends on
> net0... If enet0's mdio goes into sleep mode before enet1, then
> enet1 will fail to send power-down command to its PHY...

But the kernel knows that enet1 depends on mdio0.  Getting the kernel to 
act on that knowledge isn't the device tree's problem.

-Scott
