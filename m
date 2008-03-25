Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 62A07DE180
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 03:41:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports
	onCPM2-based platforms.
Date: Tue, 25 Mar 2008 11:41:27 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04276FD5@ismail.innsys.innovsys.com>
In-Reply-To: <200803251732.32569.laurentp@cse-semaphore.com>
References: <20080325160331.GB15093@ld0162-tx32.am.freescale.net>
	<200803251720.24667.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B04276FB4@ismail.innsys.innovsys.com>
	<200803251732.32569.laurentp@cse-semaphore.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> On Tuesday 25 March 2008 17:27, Rune Torgersen wrote:
>>> Laurent Pinchart wrote:
>>> On Tuesday 25 March 2008 17:03, Scott Wood wrote:
>>>> Yes, I've answered questions on the lists from at least one person
>>>> using a custom board with cpm2 smc.
>>>=20
>>> Are you sure it wasn't me ? ;-)
>>=20
>> Probably me, actually. We have a 8280 with SMC's in use (SMC1 and 2)
> Do you have any opinion about the proposed patch ?

That is about time... :)
I've never really liked that the smc driver in the kernel relies on
parts of the SMC port to be set up by the boot-loader.
It really bit us when we were porting to 2.6.24, and was trying to
enable SMC2, since it was not used by u-boot as a console port, the pram
was uninitialized, and the linux driver then completely borked both
smc's.

This should take care of that, it looks like.

No driver should rely on the boot loader to initialize the device...
(With the exception of pin mappinmgs, PCI and memory...)
