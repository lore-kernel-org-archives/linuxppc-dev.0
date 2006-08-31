Return-Path: <guinan@bluebutton.com>
Received: from ns4.townisp.com (ns4a.townisp.com [216.195.0.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ns4.townisp.com", Issuer "ns4.townisp.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 70F0167B83
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 02:38:09 +1000 (EST)
Received: from gemini.home.net (dhcp-0-10-57-0-7-57.cpe.townisp.com
	[64.30.85.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ns4.townisp.com (Postfix) with ESMTP id 24D1A29984
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Aug 2006 12:14:13 -0400 (EDT)
Date: Thu, 31 Aug 2006 12:14:12 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
To: linuxppc-embedded@ozlabs.org
Subject: Rattler 8347 and USB 2.0
Message-ID: <Pine.LNX.4.64.0608291535260.23035@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: Jamie Guinan <guinan@bluebutton.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Greetings,

I have an mpc8347 board here (A&M Rattler 8347).  It shipped with a 
2.6.16 patched enough to boot the board, but support for freescale USB 
2.0 (ehci) is not present.

Working my way backwards in the mainline kernel tree (2.6.18-rc5), I 
found drivers/usb/host/ehci-fsl.c, for FreeScale/PPC EHCI support.

In that module, usb_hcd_fsl_probe() requires an initialized "struct 
fsl_usb2_platform_data", which only appears in 
arch/powerpc/sysdev/fsl_soc.c, yet the 2.6.16 patch provided puts the 
board in arch/ppc.

My question is, what would be the best way to go about getting 
ehci-fsl.c working with this board?

1) Nudge the Rattler port from arch/ppc to arch/powerpc.  One problem
with this is that the rattler uses RedBoot, and reading this,

http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/024116.html

it looks like arch/powerpc wants to boot from OpenFirmware-like 
"flattened device tree" (does RedBoot support this?).

2) Support ehci-fsl.c from arch/ppc.  If arch/ppc is deprecated, 
that's a bad long-term solution.  And since fsl_soc.c lives
under arch/powerpc, that doesn't look good either.

Thoughts?

-Jamie
