Return-Path: <p_gortmaker@yahoo.com>
Received: from web60501.mail.yahoo.com (web60501.mail.yahoo.com
	[216.109.116.122]) by ozlabs.org (Postfix) with SMTP id 170E167B38
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 04:14:38 +1000 (EST)
Message-ID: <20050412181436.12272.qmail@web60501.mail.yahoo.com>
Date: Tue, 12 Apr 2005 11:14:35 -0700 (PDT)
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Warm reboot on 826x targets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've been trying to get a WRS 8265 to do a warm reboot, and found some
things that I am wondering about.

Firstly, is anyone having success on having "reboot" restart the machine
on a similar platform?

Secondly, the default BOOTROM_RESTART_ADDR is 0x40000104 (sbc82xx.h) and I
was wondering if this matches any platforms out there.  On this board, the
place where U-Boot lives is 0xFFF00104 -- and I've verified this by typing
"g fff00104" at the U-Boot prompt which causes U-Boot to simply restart.

I've changed the value in sbc82xx.h and now at the reboot, instead of a
register dump, it simply hangs.  Looking at m8260_gorom (in kernel/head.S)
it clears the MSR_EE (ext int. enable) bit in the MSR before jumping --
but I was wondering if there are other bits in MSR that need to be
cleared; e.g. instruction relocation enable and data relocation enable
(MSR_IR and MSR_DR). The register bits are on p76 of MPCFPE32B.pdf from
Freescale.

I guess if somebody even said "it works for me" then I'd have a better
feeling thinking that what is done to the MSR currently is sufficient.

Paul.


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/
