Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D2F1CDDEE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:23:19 +1100 (EST)
Message-ID: <45D22C38.10803@freescale.com>
Date: Tue, 13 Feb 2007 15:23:04 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>	<45CCDEFB.5050504@ru.mvista.com>
	<45CCDFBC.1090104@freescale.com>	<45CCE07F.9040107@ru.mvista.com>
	<45D1F46C.4050901@freescale.com>	<5B1BBAE9-00FC-454B-8855-7D362DF59850@kernel.crashing.org>	<45D1F92B.3000000@freescale.com>	<774F090A-27E6-4271-ABFE-FBFA7855D5AD@kernel.crashing.org>
	<45D21688.8090009@freescale.com>
In-Reply-To: <45D21688.8090009@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> I just had an idea.  The mac-address change should really be extended to all 
> OF-enabled Ethernet drivers.  How about I put get_mac_address() in 
> arch/powerpc/kernel/prom.c, right after get_property(), instead of making it an 
> inline function just for fsl_soc.c?

Hmmm... if I do that, then get_mac_address() is no longer an init-only function. 
  That probably is a good thing, because then device trees can call it when 
they're loaded.  In that case, should I make null_mac_address[] static again?

And what about the name?  Should I call it of_get_mac_address()?  Plain old 
"get_mac_address" sounds like a namespace collision waiting to happen.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
