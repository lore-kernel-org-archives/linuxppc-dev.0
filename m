Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 757022BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 12:19:51 +1000 (EST)
In-Reply-To: <20041007224220.GV14773@smtp.west.cox.net>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
	<20041007173023.GK14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071354340.6526@dell.enoriver.com>
	<20041007184840.GN14773@smtp.west.cox.net>
	<0927BD6D-18A9-11D9-9049-003065F9B7DC@embeddededge.com>
	<Pine.LNX.4.60.0410071817420.8278@dell.enoriver.com>
	<20041007224220.GV14773@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CF1BBAC1-18D0-11D9-9049-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 7 Oct 2004 22:21:49 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 7, 2004, at 6:42 PM, Tom Rini wrote:

> Oh, that.  console=ttyCPM1 is the answer if both SMC1 and SMC2 are
> UARTs.

Yeah, that's normally the way it's done.

> Anticipating Dan screaming about this,

What kind of a person do you think I am?  I don't scream about
anything.  I just point out facts and if others choose to ignore it
I'll just remind everyone later.

The original CPM uart drivers had lots of hard coded things
because the 'console=' option wasn't available at the time it
was developed.  It just was never updated when the command
line options appeared because the old config options were around.
It's also required information to the boards that use the 'simple'
zImage boot loader because there usually isn't any way for it
to know what to use as the console port.

The console= option is fine, it's used on many embedded boards,
including 8xx and 82xx when U-boot is used.  Just remember,
removing these console selection options from config will break
some things.  Be prepared to fix it, not just ignore it.

I'm most concerned with the Alternate SMC pin configurations, although
the new IO support functions that Kumar and I are looking at will
correct that.  Until those are done, you have to ensure there is
some way to 8xx parts with the small pin counts and the SMC pins
moved to work properly.


	-- Dan
