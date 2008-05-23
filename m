Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1404BDE026
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 13:28:58 +1000 (EST)
Subject: Re: [PATCH 2/2] USB: isp1760: Support board-specific hardware
	configurations
From: Nathaniel Case <ncase@xes-inc.com>
To: Sebastian Siewior <sebastian@breakpoint.cc>
In-Reply-To: <20080522153555.GB26410@Chamillionaire.breakpoint.cc>
References: <1211405331.13845.628.camel@localhost.localdomain>
	<20080522153555.GB26410@Chamillionaire.breakpoint.cc>
Content-Type: text/plain
Date: Thu, 22 May 2008 22:28:37 -0500
Message-Id: <1211513317.22457.14.camel@satellite>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-05-22 at 17:35 +0200, Sebastian Siewior wrote:
> If you don't mind, I would prefer having ISP1760_FLAG_BUS_WIDTH_32 and
> or conditionally HW_DATA_BUS_32BIT.

It doesn't matter much to me -- I just reasoned that a 32-bit bus width
was the norm since it's the hardware default and so having a flags=0
would be desirable for that case.  Did you have something else in mind?

> Why do you have to read the chip id here? Is this a dummy read to ensure
> something?

The idea is to force the data bus lines to change states to protect
against a false success.  E.g., you read back 0xdeadbabe but it was due
to the line states from the previous write rather than coming from the
chip itself (I've seen this when you get the bus chip select or timing
configuration wrong). 

> I'm sorry, you can't solve this way. My ISP1760 claims to be an ISP1761
> this way :) So I end up with one functional port... The only way to
> distinguish between 1760 & 1761 would be at the probing level.

Yikes -- you're right.  I would have never guessed that the 1760 would
have returned 0x1761, but sure enough that's what the datasheet says.

Thanks for the feedback.

--
Nate Case <ncase@xes-inc.com>
