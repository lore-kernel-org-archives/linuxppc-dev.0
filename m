Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id EA887DDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 04:12:55 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so685151anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:12:54 -0800 (PST)
Message-ID: <fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
Date: Wed, 23 Jan 2008 10:12:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
In-Reply-To: <87sl0qzxos.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121103434.397382000@sunsite.dk>
	<200801211201.41142.david-b@pacbell.net>
	<fa686aa40801211214u31581036m2ea2cf11d82c3f75@mail.gmail.com>
	<87sl0qzxos.fsf@macbook.be.48ers.dk>
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

On 1/21/08, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>
>  Grant> Personally, I'd prefer to see the v3 series picked up now (as I
>  Grant> believe all outstanding comments from the list have been addressed)
>  Grant> and have new patches build on top of that, but that's just my
>  Grant> preference.
>
> Here's the v3->v4 without gadget diff:

Okay, I've had a chance to read through this.  I haven't tested it,
but I don't see anything I strongly disagree with.  I've just got a
few editorial comments below and a question.

The question is about the device structure which used to be provided
by the platform device instances and now there just uses the c67x00's
device struct.  I was under the impression that each USB HCD needs to
have it's own struct device.  I take it that's not true?

Otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Cheers,
g.
>
> diff --git a/drivers/usb/c67x00/c67x00-drv.c b/drivers/usb/c67x00/c67x00-drv.c
> index 0f0720a..c2ea3b6 100644
> --- a/drivers/usb/c67x00/c67x00-drv.c
> +++ b/drivers/usb/c67x00/c67x00-drv.c
> @@ -203,19 +175,19 @@ static int __devinit c67x00_drv_probe(struct platform_device *pdev)
>         }
>
>         for (i = 0; i < C67X00_SIES; i++)
> -               c67x00_probe_sie(&c67x00->sie[i]);
> +               c67x00_probe_sie(&c67x00->sie[i], c67x00, i);
>
>         platform_set_drvdata(pdev, c67x00);
>
>         return 0;
>
> - reset_failed:
> +reset_failed:
>         free_irq(res2->start, c67x00);
> - request_irq_failed:
> +request_irq_failed:
>         iounmap(c67x00->hpi.base);
> - map_failed:
> +map_failed:
>         release_mem_region(res->start, res->end - res->start + 1);
> - request_mem_failed:
> +request_mem_failed:

A single space should be preserved in front of the labels.  Doing so
means that git-diff picks up the function name instead of the label
when generating output.

> diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
> index 3d0b77e..4afb291 100644
> --- a/drivers/usb/c67x00/c67x00-hcd.c
> +++ b/drivers/usb/c67x00/c67x00-hcd.c
> @@ -368,23 +383,26 @@ int c67x00_hcd_probe(struct c67x00_sie *sie)
>                 goto err2;
>         }
>
> +       spin_lock_irqsave(&sie->lock, flags);
> +       sie->private_data = c67x00;
> +       sie->irq = c67x00_hcd_irq;
> +       spin_unlock_irqrestore(&sie->lock, flags);
> +
>         return retval;
> - err2:
> +err2:
>         c67x00_sched_stop_scheduler(c67x00);
> - err1:
> +err1:
>         usb_put_hcd(hcd);
> - err0:
> +err0:

Ditto on the labels

> diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
> index 5b35f01..daee4cd 100644
> --- a/drivers/usb/c67x00/c67x00-hcd.h
> +++ b/drivers/usb/c67x00/c67x00-hcd.h
> @@ -132,6 +147,6 @@ void c67x00_sched_kick(struct c67x00_hcd *c67x00);
>  int c67x00_sched_start_scheduler(struct c67x00_hcd *c67x00);
>  void c67x00_sched_stop_scheduler(struct c67x00_hcd *c67x00);
>
> -#define c67x00_hcd_dev(x)      (c67x00_hcd_to_hcd(x)->self.controller)
> +#define c67x00_dev(x)  (c67x00_hcd_to_hcd(x)->self.controller)

Can the name c67x00_hcd_dev() be used instead?  This macro is used
with 'struct c67x00_hcd', not 'struct c67x00' and I find the code less
confusing if the macro name reflects that.

>
>  #endif                         /* _USB_C67X00_HCD_H */
> diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
> index 35d7318..3140d89 100644
> --- a/drivers/usb/c67x00/c67x00-sched.c
> +++ b/drivers/usb/c67x00/c67x00-sched.c
> -       /* Something went wrong; unwind the allocations */
> - err_epdata:
> +err_epdata:
>         kfree(urbp);
> - err_urbp:
> +err_urbp:
>         usb_hcd_unlink_urb_from_ep(hcd, urb);
> - err_not_linked:
> +err_not_linked:

ditto

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
