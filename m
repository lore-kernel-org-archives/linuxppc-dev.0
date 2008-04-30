Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3BB5ADDF1E
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:17:14 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6E2EBEAF-DF1E-4439-91EF-B15EE39CAF61@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: drivers/net/fec_8xx config problem
Date: Wed, 30 Apr 2008 14:19:21 -0500
To: pantelis.antoniou@gmail.com, jengelh@linux01.gwdg.de
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just noticed that the fec_8xx driver is not currently reachable via  
menuconfig because it depends on 8XX instead of 8xx.  It looks like  
this change occurred in commit  
d1c0a65fb597697d1fbce4eadf42b84f70483edc, almost a year ago:

diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
index a84c232..afb34de 100644
--- a/drivers/net/fec_8xx/Kconfig+++ b/drivers/net/fec_8xx/Kconfig
@@ -1,6 +1,6 @@
  config FEC_8XX
         tristate "Motorola 8xx FEC driver"
-       depends on NET_ETHERNET && 8xx
+       depends on 8XX
         select MII


Since nobody has noticed this problem, I'm wondering if this driver  
is still in (infrequent) use, or if it's been superseded and should  
be removed, or if I'm just completely missing something with respect  
to the use of "8XX" instead of "8xx".

I'm happy to submit a patch to correct this, I'm just not sure what  
the right answer is.

Thanks,
Becky
