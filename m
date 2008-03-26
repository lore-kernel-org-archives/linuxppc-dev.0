Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 762DBDE2FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 00:08:36 +1100 (EST)
Date: Wed, 26 Mar 2008 09:08:03 -0400
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: ppc platform for AMCC-440EPx - ELDK to the rescue
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080326130837.762DBDE2FB@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I finally resolved my nightmare of getting linux-2.6.24/5... to work 
on my AMCC-440Epx - Sequoia spinoff board. Following a clue I derived 
from a reply from Wolfgang Denx, I went to the DENX Engineering site 
where I discoved and downloaded the ELDK for the ppc_4xxFP. the ELDK 
uses the ppc platform instead of the powerpc platform.  FINALLY the 
early debugging console output worked, which doesn't work at all 
using the powerpc platform (and yes, I had the correct port address 
configured).  After that, I was able to see that it was the 
"setup_hose" function called from /arch/ppc/platforms/4xx/sequoia.c 
that caused my board to hang. This Sequoia spinoff board has the PCI 
Host Bridge disabled which I didn't realize until that point.

Looking back at the powerpc platform, I don't see how to disable the 
Host Bridge initialization without disabling the entire PCI 
bus.  This board does have 2 devices hooked on the PCI bus, just no 
need for a Host Bridge.

Also, I fail to see what the DTS virtualization layer of the hardware 
buys us. When debugging, it's so much harder to use than the ppc 
platform's straight forward and standard methodologies.  I can't 
understand to goal to eliminate the ppc platform, especially given 
the fact that DENX's ELDK is still using it with Linux 2.6.24.2 !!

Best Regards to all,
Special Thanks to Wolfgang Denx,
Steve Heflin
