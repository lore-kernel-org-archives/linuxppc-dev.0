Return-Path: <dan@embeddedalley.com>
Received: from smtp100.biz.mail.mud.yahoo.com (smtp100.biz.mail.mud.yahoo.com
	[68.142.201.176]) by ozlabs.org (Postfix) with SMTP id D0F63DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 05:15:56 +1000 (EST)
In-Reply-To: <46F80049.2030509@freescale.com>
References: <46F6C9DC.90008@scram.de> <46F7DE85.7000401@freescale.com>
	<46F7EE95.1040509@scram.de> <46F80049.2030509@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FF1A2486-BE77-49F8-99F3-B09B4EEAF50D@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
Date: Mon, 24 Sep 2007 12:16:05 -0700
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 24, 2007, at 11:22 AM, Scott Wood wrote:

> cpmp is a physical address on arch/ppc?

No, it's a well known ioremaped() address
into the IMMR space.  The only physical
addresses in any of the CPM/CPM2 are
those required to by the buffer descriptors.
There are DPRAM offsets, but they should
be just that, offsets from either a virtual
or physical base address as required.
Too many people screw around in this
CPM support code without fully understanding
the original implementation or its intended
use with the peripheral drivers.  A "better
idea" often breaks all drivers except the one
that is being changed.

	-- Dan
