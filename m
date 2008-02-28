Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C911DDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Feb 2008 10:21:14 +1100 (EST)
Date: Thu, 28 Feb 2008 18:21:38 -0500
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: 2.6.25-rc3 Sequoia build - section mismatch(es)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080228232115.6C911DDEC1@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Upon building the default Sequoia (AMCC-440EPx) configuration, the 
MODPOST step warns about section mismatches:
    WARNING: modpost: Found 5 section mismatch(es).
    To see full details build your kernel with:
    'make CONFIG_DEBUG_SECTION_MISMATCH=y'

After using the CONFIG_DEBUG_SECTION_MISMATCH option, the section 
mismatches are cases in one of the following:
  1) functions in the device initialization (.devinit) 
calls  routines which are contained in the .text section;
  2) functions in the device init section calls routines in the 
device exit section;
  3) data structures in the .data section contain pointers to 
functions in the .devinit section or .devexit section; (note that 
these data structures are used during initialization)

My question is, will this cause the code to malfunction?

thanks,
Steve
