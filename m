Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id D5494DDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 07:40:26 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so459518anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 12:40:25 -0800 (PST)
Message-ID: <fa686aa40801281240s5af3272bg7953e6a3d6022531@mail.gmail.com>
Date: Mon, 28 Jan 2008 13:40:25 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
In-Reply-To: <200801230953.05921.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121103434.397382000@sunsite.dk>
	<87sl0qzxos.fsf@macbook.be.48ers.dk>
	<fa686aa40801230912m2314209fp2545898949ed3b24@mail.gmail.com>
	<200801230953.05921.david-b@pacbell.net>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/23/08, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 23 January 2008, Grant Likely wrote:
> > The question is about the device structure which used to be provided
> > by the platform device instances and now there just uses the c67x00's
> > device struct.  I was under the impression that each USB HCD needs to
> > have it's own struct device.  I take it that's not true?
>
> Each root hub necessarily is a unique device, representing a set
> of downstream links.  Unless Peter didn't test something relevant,
> it would seem we have observational proof that two root hubs can
> share the same device node for an upstream link.
>
> I can't think of a reason to demand multiple upstream links, though
> sharing them between root hubs like that isn't a common structure.

I've now merged the driver into my tree and tested it.

The good news is that using only one device node is absolutely no
problem.  It works without error or complaint and sysfs looks sane.

The bad news is that I discovered a race condition on initialization.
The problem is that IRQs are enabled before the SIEs are configured.
The interrupt handler is firing immediately and tries to get the
status of each SIE.  Since the SIE probe has not yet occured, sie->dev
is NULL and we get a kernel oops when c67x00_ll_get_siemsg() tries to
dereference it.

However, register_irq() cannot be easily moved to after the SIE probe
because the current probe code depends on interrupts being enabled.
Below is an ugly workaround that solves the problem to me, but there
is probably a better solution.

Cheers,
g.


diff --git a/drivers/usb/c67x00/c67x00-drv.c
b/drivers/usb/c67x00/c67x00-drv.c index 360bae5..4051502 100644
--- a/drivers/usb/c67x00/c67x00-drv.c
+++ b/drivers/usb/c67x00/c67x00-drv.c
@@ -105,6 +105,8 @@ static irqreturn_t c67x00_irq(int irq, void *__dev)
                        }
                        if (sie->irq)
                                sie->irq(sie, int_status, msg);
+                       else if (int_status & SOFEOP_FLG(sie->sie_num))
+                               c67x00_ll_usb_clear_status(sie,
SOF_EOP_IRQ_FLG);
                }
                int_status = c67x00_ll_hpi_status(c67x00);
        }
@@ -168,6 +170,11 @@ static int __devinit c67x00_drv_probe(struct
platform_device *pdev)
                goto request_irq_failed;
        }

+       for (i = 0; i < C67X00_SIES; i++) {
+               c67x00->sie[i].sie_num = i;
+               c67x00->sie[i].dev = c67x00;
+       }
+
        ret = c67x00_ll_reset(c67x00);
        if (ret) {
                dev_err(&pdev->dev, "Device reset failed\n");

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
