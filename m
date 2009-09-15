Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 80E2DB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 00:31:42 +1000 (EST)
Date: Tue, 15 Sep 2009 10:31:36 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org, jwboyer@linux.vnet.ibm.com
Subject: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090915143135.GA7015@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One of the guys here was getting a messed up console on a bamboo board
(on linux boot), which he traced to the fact that the default dts has a
9600 baudrate coded into it (board was running 115k2, not 9600).  Either
deleting the line, or replacing the 9600 with zero fixed the problem.

Looking at the Fsl boards, it seems that 99% of them don't list any
current-speed at all.  I'm willing to whip up a patch to delete them
from the various boards, but I thought I'd check 1st to see if there was
some other reasoning/input.  I suppose one could argue that u-boot
should be replacing the 9600 with 115k2 on the fly, but if the explicit
specification isn't helping anyone, then it probably just makes sense to
delete them anyway, I figured.

Here is the subset of boards I was considering deleting the lines from:

   bamboo.dts ebony.dts hcu4.dts holly.dts katmai.dts sam440ep.dts
   sequoia.dts taishan.dts walnut.dts yosemite.dts

Thanks,
Paul.
