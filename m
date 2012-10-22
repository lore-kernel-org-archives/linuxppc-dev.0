Return-Path: <laurent.pinchart@ideasonboard.com>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [95.142.166.194])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 845592C0080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2012 21:54:49 +1100 (EST)
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 1/1] usb: gadget: Don't attempt to dequeue requests for a
 disabled USB endpoint on Freescale hardware
Date: Mon, 22 Oct 2012 12:47:21 +0200
Message-ID: <1535820.NU10ADjvOZ@avalon>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F094730DB@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1350667166-3559-1-git-send-email-simon.haggett@realvnc.com>
 <20121019173718.GA2738@arwen.pp.htv.fi>
 <94F013E7935FF44C83EBE7784D62AD3F094730DB@039-SN2MPN1-023.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Simon Haggett <simon.haggett@realvnc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "balbi@ti.com" <balbi@ti.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Monday 22 October 2012 03:33:19 Li Yang-R58472 wrote:
> On Saturday, October 20, 2012 1:37 AM Felipe Balbi wrote:
> > On Fri, Oct 19, 2012 at 06:19:26PM +0100, Simon Haggett wrote:
> > > Some gadget drivers may attempt to dequeue requests for an endpoint
> > > that has already been disabled. For example, in the UVC gadget driver,
> > > uvc_function_set_alt() will call usb_ep_disable() when alt setting 0
> > > is selected. When the userspace application subsequently issues the
> > > VIDIOC_STREAMOFF ioctl, uvc_video_enable() invokes usb_ep_dequeue() to
> > 
> > ensure that all requests have been cancelled.
> > 
> > bug is on uvc gadget, then. Laurent ?

We've discussed this topic a couple of months before. I believe that's not a 
bug.

http://68.183.106.108/lists/linux-usb/msg68869.html

> > Also, fsl should be removed from the tree, I'm trying to persuade iMX
> > folks to use drivers/usb/chipidea instead.
> 
> Besides the iMX usage, the driver is also being used by many Freescale
> PowerPC/Coldfire SoCs.  I agree that it's ideal to move to a common driver.
> But it is a large task to make the chipidea driver works for all the
> hardware that fsl_udc had supported and been tested on.
>
> > > For the Freescale High Speed Dual-Role USB controller,
> > > fsl_ep_dequeue() provides the implementation of usb_ep_dequeue(). If
> > > this is called for a disabled endpoint, a kernel oops will occur when
> > 
> > the ep->ep.desc field is dereferenced (by ep_index()).
> > 
> > > fsl_ep_disable() sets this field to NULL, as well as deleting all
> > > pending requests for the endpoint.
> > > 
> > > This patch adds an additional check to fsl_ep_dequeue() to ensure that
> > > the endpoint has not already been disabled before attempting to dequeue
> > 
> > requests.
> > 
> > > Signed-off-by: Simon Haggett <simon.haggett@realvnc.com>
> > > ---
> > > 
> > >  drivers/usb/gadget/fsl_udc_core.c |    5 ++++-
> > >  1 files changed, 4 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/fsl_udc_core.c
> > > b/drivers/usb/gadget/fsl_udc_core.c
> > > index 6ae70cb..acd513b 100644
> > > --- a/drivers/usb/gadget/fsl_udc_core.c
> > > +++ b/drivers/usb/gadget/fsl_udc_core.c
> > > @@ -955,7 +955,10 @@ static int fsl_ep_dequeue(struct usb_ep *_ep,
> > struct usb_request *_req)
> > 
> > >  	int ep_num, stopped, ret = 0;
> > >  	u32 epctrl;
> > > 
> > > -	if (!_ep || !_req)
> > > +	/* Ensure that the ep and request are valid, and the ep is not
> > > +	 * disabled
> > > +	 */
> > > +	if (!_ep || !_req || !ep->ep.desc)
> > >  		return -EINVAL;

Shouldn't that last check be done with a lock taken ?

> > >  	spin_lock_irqsave(&ep->udc->lock, flags);

-- 
Regards,

Laurent Pinchart
