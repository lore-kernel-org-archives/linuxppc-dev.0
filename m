Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by ozlabs.org (Postfix) with ESMTP id 7B10FDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 08:18:24 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so2616529mue.1
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 13:18:21 -0800 (PST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
References: <20080121103434.397382000@sunsite.dk>
	<200801211201.41142.david-b@pacbell.net>
	<fa686aa40801211214u31581036m2ea2cf11d82c3f75@mail.gmail.com>
	<87sl0qzxos.fsf@macbook.be.48ers.dk>
	<fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 23 Jan 2008 22:18:17 +0100
In-Reply-To: <fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
	(Grant Likely's message of "Wed\, 23 Jan 2008 10\:12\:53 -0700")
Message-ID: <877ii0fdgm.fsf@macbook.be.48ers.dk>
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

 Grant> Okay, I've had a chance to read through this.  I haven't
 Grant> tested it, but I don't see anything I strongly disagree with.
 Grant> I've just got a few editorial comments below and a question.

Ok, great.

 Grant> The question is about the device structure which used to be provided
 Grant> by the platform device instances and now there just uses the c67x00's
 Grant> device struct.  I was under the impression that each USB HCD needs to
 Grant> have it's own struct device.  I take it that's not true?

Not afaik. In fact, I changed this based on feedback from David back
when I first time posted the patch series:

http://article.gmane.org/gmane.linux.usb.devel/53496

But I don't have a board with host connectors on both SIEs, so I
haven't actually been able to test it.

 Grant> Otherwise:

 Grant> Acked-by: Grant Likely <grant.likely@secretlab.ca>

 Grant> Cheers,
 Grant> g.
 >> 
 >> diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
 >> index 0f0720a..c2ea3b6 100644
 >> --- a/drivers/usb/c67x00/c67x00-drv.c
 >> +++ b/drivers/usb/c67x00/c67x00-drv.c
 >> @@ -203,19 +175,19 @@ static int __devinit c67x00_drv_probe(struct platform_device *pdev)
 >> }
 >> 
 >> for (i = 0; i < C67X00_SIES; i++)
 >> -               c67x00_probe_sie(&c67x00->sie[i]);
 >> +               c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
 >> 
 >> platform_set_drvdata(pdev, c67x00);
 >> 
 >> return 0;
 >> 
 >> - reset_failed:
 >> +reset_failed:
 >> free_irq(res2->start, c67x00);
 >> - request_irq_failed:
 >> +request_irq_failed:
 >> iounmap(c67x00->hpi.base);
 >> - map_failed:
 >> +map_failed:
 >> release_mem_region(res->start, res->end - res->start + 1);
 >> - request_mem_failed:
 >> +request_mem_failed:

 Grant> A single space should be preserved in front of the labels.  Doing so
 Grant> means that git-diff picks up the function name instead of the label
 Grant> when generating output.

Ok. Emacs doesn't seem to do this by default.

 >> diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
 >> index 3d0b77e..4afb291 100644
 >> --- a/drivers/usb/c67x00/c67x00-hcd.c
 >> +++ b/drivers/usb/c67x00/c67x00-hcd.c
 >> @@ -368,23 +383,26 @@ int c67x00_hcd_probe(struct c67x00_sie *sie)
 >> goto err2;
 >> }
 >> 
 >> +       spin_lock_irqsave(&sie->lock, flags);
 >> +       sie->private_data = c67x00;
 >> +       sie->irq = c67x00_hcd_irq;
 >> +       spin_unlock_irqrestore(&sie->lock, flags);
 >> +
 >> return retval;
 >> - err2:
 >> +err2:
 >> c67x00_sched_stop_scheduler(c67x00);
 >> - err1:
 >> +err1:
 >> usb_put_hcd(hcd);
 >> - err0:
 >> +err0:

 Grant> Ditto on the labels

 >> diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
 >> index 5b35f01..daee4cd 100644
 >> --- a/drivers/usb/c67x00/c67x00-hcd.h
 >> +++ b/drivers/usb/c67x00/c67x00-hcd.h
 >> @@ -132,6 +147,6 @@ void c67x00_sched_kick(struct c67x00_hcd *c67x00);
 >> int c67x00_sched_start_scheduler(struct c67x00_hcd *c67x00);
 >> void c67x00_sched_stop_scheduler(struct c67x00_hcd *c67x00);
 >> 
 >> -#define c67x00_hcd_dev(x)      (c67x00_hcd_to_hcd(x)->self.controller)
 >> +#define c67x00_dev(x)  (c67x00_hcd_to_hcd(x)->self.controller)

 Grant> Can the name c67x00_hcd_dev() be used instead?  This macro is used
 Grant> with 'struct c67x00_hcd', not 'struct c67x00' and I find the code less
 Grant> confusing if the macro name reflects that.

Well, we can. I didn't copy your name change over as the hcds don't
have their own struct device in my series, but I don't feel strongly
about the issue.

 >> 
 >> #endif                         /* _USB_C67X00_HCD_H */
 >> diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
 >> index 35d7318..3140d89 100644
 >> --- a/drivers/usb/c67x00/c67x00-sched.c
 >> +++ b/drivers/usb/c67x00/c67x00-sched.c
 >> -       /* Something went wrong; unwind the allocations */
 >> - err_epdata:
 >> +err_epdata:
 >> kfree(urbp);
 >> - err_urbp:
 >> +err_urbp:
 >> usb_hcd_unlink_urb_from_ep(hcd, urb);
 >> - err_not_linked:
 >> +err_not_linked:

 Grant> ditto

 Grant> Cheers,
 Grant> g.

Thanks for the feedback, I'll post an updated series.

-- 
Bye, Peter Korsgaard
