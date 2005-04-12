Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4944E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 04:31:34 +1000 (EST)
Date: Tue, 12 Apr 2005 11:31:31 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Message-ID: <20050412183131.GA3851@gate.ebshome.net>
References: <20050412181436.12272.qmail@web60501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050412181436.12272.qmail@web60501.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Warm reboot on 826x targets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 12, 2005 at 11:14:35AM -0700, Paul Gortmaker wrote:
> I've been trying to get a WRS 8265 to do a warm reboot, and found some
> things that I am wondering about.
> 
> Firstly, is anyone having success on having "reboot" restart the machine
> on a similar platform?
> 
> Secondly, the default BOOTROM_RESTART_ADDR is 0x40000104 (sbc82xx.h) and I
> was wondering if this matches any platforms out there.  On this board, the
> place where U-Boot lives is 0xFFF00104 -- and I've verified this by typing
> "g fff00104" at the U-Boot prompt which causes U-Boot to simply restart.
> 
> I've changed the value in sbc82xx.h and now at the reboot, instead of a
> register dump, it simply hangs.  Looking at m8260_gorom (in kernel/head.S)
> it clears the MSR_EE (ext int. enable) bit in the MSR before jumping --
> but I was wondering if there are other bits in MSR that need to be
> cleared; e.g. instruction relocation enable and data relocation enable
> (MSR_IR and MSR_DR). The register bits are on p76 of MPCFPE32B.pdf from
> Freescale.
> 
> I guess if somebody even said "it works for me" then I'd have a better
> feeling thinking that what is done to the MSR currently is sufficient.

I don't have any problems using reboot() on 8248 based board. 
Kernel.org-based 2.4.29 tree.

I have U-Boot at 0xfe00'0000, and I use 0xfe00'0104 as a second 
parameter for m8260_gorom. Also make sure that first parameter is also 
correct:

	m8260_gorom(__pa(__res), 0xfe000104);

-- 
Eugene
