Return-Path: <ncunningham@cyclades.com>
Received: from cunningham.myip.net.au (b3162.static.pacific.net.au
	[203.143.238.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 549C368734
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2005 15:58:08 +1100 (EST)
From: Nigel Cunningham <ncunningham@cyclades.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1132715288.26560.262.camel@gaston>
References: <1132715288.26560.262.camel@gaston>
Content-Type: text/plain
Message-Id: <1132715647.4707.8.camel@localhost>
Mime-Version: 1.0
Date: Wed, 23 Nov 2005 14:14:07 +1100
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
Reply-To: ncunningham@cyclades.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

On Wed, 2005-11-23 at 14:08, Benjamin Herrenschmidt wrote:
> This is my latest patch against current linus -git, it closes the IRQ
> race and makes various other OHCI & EHCI code path safer vs.
> suspend/resume. I've been able to (finally !) successfully suspend and
> resume various Mac models, with or without USB mouse plugged, or
> plugging while asleep, or unplugging while asleep etc... all without a
> crash. There are still some races here or there in the USB code, but at
> least the main cause of crash is now fixes by this patch (access to a
> controller that has been suspended, due to either shared interrupts or
> other code path).
> 
> I haven't fixed UHCI as I don't have any HW to test, though I hope I
> haven't broken it neither. Alan, I would appreciate if you could have a
> look.
> 
> This patch applies on top of the patch that moves the PowerMac specific
> code out of ohci-pci.c to hcd-pci.c where it belongs. This patch isn't
> upstream yet for reasons I don't fully understand (why does USB stuffs
> has such a high latency for going upstream ?), I'm sending it as a reply
> to this email for completeness.
> 
> Without this patch, you cannot reliably sleep/wakeup any recent Mac, and
> I suspect PCs have some more sneaky issues too (they don't frankly crash
> with machine checks because x86 tend to silently swallow PCI errors but
> that won't last afaik, at least PCI Express will blow up in those
> situations, but the USB code may still misbehave).

Sounds great. Maybe I'll finally be able to change my first question to
people with suspend problems from: "Do you have USB built as modules and
unloaded while suspending."

Regards,

Nigel
