Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D3DC687D5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2005 16:16:40 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@cyclades.com
In-Reply-To: <1132715647.4707.8.camel@localhost>
References: <1132715288.26560.262.camel@gaston>
	<1132715647.4707.8.camel@localhost>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 16:13:16 +1100
Message-Id: <1132722797.26560.279.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Sounds great. Maybe I'll finally be able to change my first question to
> people with suspend problems from: "Do you have USB built as modules and
> unloaded while suspending."

Heh, I don't know :) I haven't done anything to UHCI at this point, and
there are still other possible issues.

For example, we should probably do the "handoff" trick on resume as well
as on boot. In fact, I suspect that most PCI quirks should be re-run on
resume, with IRQs off if possible, so that stuffs can be put back into
some sane state when coming back from the BIOS before they get a chance
to spam the kernel with bogus IRQs left enabled by that same BIOS (does
this happen ?) or other niceties of that sort... I don't have any of
these problems on powermacs, but x86 might not be yet at the end of the
tunnel...

Ben.
