Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
	by ozlabs.org (Postfix) with ESMTP id 12F6D67A6D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 19:59:21 +1100 (EST)
Received: from sun5.it.da.ut.ee (sun5.it.da.ut.ee [193.40.5.164])
	by smtp2.it.da.ut.ee (Postfix) with ESMTP id 19E7C4C05AC1
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 10:38:23 +0200 (EET)
Received: from sun5.it.da.ut.ee (localhost [127.0.0.1])
	by sun5.it.da.ut.ee (8.12.10+Sun/8.12.10) with SMTP id j1M8blNS009855
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 10:37:54 +0200 (EET)
Received: from sun5.it.da.ut.ee ([127.0.0.1])
	by sun5.it.da.ut.ee (SMSSMTP 4.0.0.59) with SMTP id
	M2005022210370926747
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 10:37:52 +0200
Received: from math.ut.ee (math.ut.ee [193.40.5.125])
	by sun5.it.da.ut.ee (8.12.10+Sun/8.12.10) with ESMTP id j1M8b8rx009740
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 10:37:09 +0200 (EET)
Date: Tue, 22 Feb 2005 10:36:36 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041206185416.GE7153@smtp.west.cox.net>
Message-ID: <Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
References: <20041206185416.GE7153@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Kujau <evil@g-house.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah)
 PCI IRQ map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
> incorrect, but this breakage wasn't exposed until 2.5, and finally fixed
> until recently by Sebastian Heutling <sheutlin@gmx.de>.

Yesterday I finally got around to testing it. It seems the patch has 
been applied in Linus's tree so I downloaded the latest BK and tried it.

Still does not work for me but this time it's different. Before the 
patch SCSI worked fine but PCI NICs caused hangs. Now I can't test PCI 
NICs because even the onboard 53c825 SCSI hangs - seems it gets no 
interrupts.

It detects the HBA, tries device discovery, gets a timeout, ABORT, 
timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and there 
it hangs.

Does it work for anyone else on Powerstack II Pro4000 (Utah)?

-- 
Meelis Roos (mroos@linux.ee)
