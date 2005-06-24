Return-Path: <kylej@aiinet.com>
Received: from aiexchange.ai.aiinet.com (ai181-229.aiinet.com
	[205.245.181.229]) by ozlabs.org (Postfix) with ESMTP id AA76B67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Jun 2005 22:44:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 24 Jun 2005 08:32:37 -0400
Message-ID: <C0170D0AF1277849A4B4518034F855DD0F9190@aiexchange.ai.aiinet.com>
From: "Jordan, Kyle" <kylej@aiinet.com>
To: <j.lu@tiesse.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: isp1362 usb driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> The driver works quite good for control/bulk/interrupts, but we=20
> can't make it work with our eagle-usb driver for isochronous. We=20
> are still debugging it. If you have some informations about=20
> isochronous that may help us we'll be grateful for it.


The function fnvProcessSofItlInt is called every 1 ms.  It handles the
scheduling of isochronous data.  This is where you should start looking
(if you haven't already).  This is the same function that schedules
isochronous data in the driver from Denx, however it also schedules
control/bulk/interrupt endpoints in that driver.  My intent was to rip
out the way control/bulk/interrupt endpoints were handled in that driver
and have them handled differently.  I was hoping I did not affect the
way isochronous endpoints were handled, but I must have.  Take a look at
the fnvProcessSofItlInt function in the driver from Denx.  The driver I
modified should be very similar in the way the driver from Denx handles
isochronous endpoints, but I obviously changed something.  Could you let
me know if you get it working?
=20
Thanks,
  Kyle Jordan
