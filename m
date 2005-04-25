Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id 8398367A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 05:22:49 +1000 (EST)
Received: from zaphod.acdstar.com (zaphod.int.acdstar.com [192.168.2.100])
	by mail.acdstar.com (8.13.0/8.13.0) with ESMTP id j3PJQZax002086
	for <linuxppc-embedded@ozlabs.org>; Mon, 25 Apr 2005 14:26:35 -0500
Message-Id: <6.2.1.2.1.20050425130606.030aa288@mail.int.acdstar.com>
Date: Mon, 25 Apr 2005 14:22:56 -0500
To: linuxppc-embedded@ozlabs.org
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: New MPC5200 Eratta/ATA Bugs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Freescale just realeased a new version of the eratta (hardware bugs) 
document for the MPC5200.  It was posted last week, and adds some pretty 
significant problems to the FEC Ethernet and IDE/ATA sections.

Specifically, I'm wonder if Eratta ID 485 may be the cause of some of the 
IDE issues we've been attributing to Bestcomm:

  "During the concurrent access of ATA DMA READ and PCI or LPC the
   ATA_ISOLATION signal can be incorrectly driven when ATA is paused."

Unfortunately, their proposed workaround isn't appropriate for many 
cases.  They suggest that you not use "ATA_ISOLATION" and connect the ATA 
device directly to the LP bus without any buffering.  This could lead to 
serious bus integrity issues, especially if the ATA device is connected by 
a ribbon cable.

Eric
------------------------------------
Eric Johnson, Electrical Engineer
Advanced Communication Design
   7901 12th Avenue South
   Bloomington, MN 55425
Ph: 952-854-4000  Fax: 952-854-5774
