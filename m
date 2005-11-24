Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DCD6687C7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 12:27:11 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <200511240122.46125.rjw@sisk.pl>
References: <1132715288.26560.262.camel@gaston>
	<200511240122.46125.rjw@sisk.pl>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 12:23:15 +1100
Message-Id: <1132795396.26560.382.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
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


> Unfortunately with this patch the EHCI controller in my box (Asus L5D,
> x86-64 kernel) does not resume from suspend.  Appended is the relevant
> snippet from the serial console log (EHCI is the only device using IRQ #5).

Hrm... let me see... You are getting an interrupt for EHCI after it has
been resumed, so it should work.

 /me double-checks the patch

> ehci_hcd 0000:00:02.2: lost power, restarting

Hrm... I can't find that line in the code...

 /me rechecks with david's other patches

Ah ... I see it. There might have been some screwup between david's
patch and mine.

Make sure that 

       set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);

Is still done before anything else in ehci_pci_resume(). It may be worth
following it with a memory barrier actually... just in case (due to the
absence of locks in that area).

Ben.
