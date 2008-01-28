Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by ozlabs.org (Postfix) with ESMTP id 7B1E4DDF02
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 08:01:36 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so1050237mue.1
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 13:01:33 -0800 (PST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080121103434.397382000@sunsite.dk>
	<87sl0qzxos.fsf@macbook.be.48ers.dk>
	<fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
	<200801230953.05921.david-b@pacbell.net>
	<fa686aa40801281240s5af3272bg7953e6a3d6022531@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 28 Jan 2008 22:01:30 +0100
In-Reply-To: <fa686aa40801281240s5af3272bg7953e6a3d6022531@mail.gmail.com>
	(Grant Likely's message of "Mon\, 28 Jan 2008 13\:40\:25 -0700")
Message-ID: <87ir1dfyvp.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> I've now merged the driver into my tree and tested it.

 Grant> The good news is that using only one device node is absolutely
 Grant> no problem.  It works without error or complaint and sysfs
 Grant> looks sane.

Great.

 Grant> The bad news is that I discovered a race condition on
 Grant> initialization.  The problem is that IRQs are enabled before
 Grant> the SIEs are configured.  The interrupt handler is firing
 Grant> immediately and tries to get the status of each SIE.  Since
 Grant> the SIE probe has not yet occured, sie->dev is NULL and we get
 Grant> a kernel oops when c67x00_ll_get_siemsg() tries to dereference
 Grant> it.

Not so great. I unfortunately don't see it here.

 Grant> However, register_irq() cannot be easily moved to after the
 Grant> SIE probe because the current probe code depends on interrupts
 Grant> being enabled.  Below is an ugly workaround that solves the
 Grant> problem to me, but there is probably a better solution.

Wouldn't it be simpler to just add a if (sie->dev) check to
_ll_get_siemsg()? Or doesn't the hcd init properly reinitialize the
device?

-- 
Bye, Peter Korsgaard
