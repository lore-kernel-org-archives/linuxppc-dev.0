Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141])
 by lists.ozlabs.org (Postfix) with ESMTP id C45CD1A0066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 03:51:30 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Cc: jk@ozlabs.org, linuxppc-dev@lists.ozlabs.org, minyard@acm.org
Subject: Re: [PATCH] ipmi/powernv: Fix potential invalid pointer dereference
Date: Wed, 29 Jul 2015 03:51:03 +1000
Message-ID: <2100038.nvIKqFquOH@mexican>
In-Reply-To: <55B7342F.8080703@linux.vnet.ibm.com>
References: <20150716111628.28037.80799.stgit@localhost.localdomain>
 <55A8BFDF.2020601@linux.vnet.ibm.com> <55B7342F.8080703@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Neelesh,

This fix looks reasonable to me, although Jeremy would be the best person to 
comment if he has time. I wonder why we bother polling at all given that our 
event interface should call opal_ipmi_recv() whenever a message is ready?

Also the firmware fix you refer to and this fix are independent of each other 
so there's no ordering issues there.

Reviewed-By: Alistair Popple <alistair@popple.id.au>

On Tue, 28 Jul 2015 13:20:07 Neelesh Gupta wrote:
> 
> On 07/17/2015 02:12 PM, Neelesh Gupta wrote:
> > Hi Corey,
> >
> > On 07/16/2015 08:31 PM, Corey Minyard wrote:
> >> Ok, this looks fine.  A couple of question...
> >>
> >> Do I need to send this upstream right now?  How well has this been 
tested?
> >
> > I would want either Jeremy or Alistair to review this patch before you 
> > send this
> > upstream. There is also firmware piece 
> > http://patchwork.ozlabs.org/patch/496645/
> > awaiting review.
> >
> > In the testing front, I manually made the opal_ipmi_recv() function to 
> > fail for testing
> > the error path and see if the driver recovers from it and subsequent 
> > ipmi commands
> > work all good.
> 
> Hi Jeremy/Alistair,
> 
> Could you please review it and the corresponding skiboot patch...
> 
> Thanks,
> Neelesh.
> 
> >
> >> Do you want this backported to 4.0 stable?
> >
> > Yes, I want this to be be backported to 4.0 stable.
> >
> > Thanks,
> > Neelesh.
> >
> >> -corey
> >>
> >> On 07/16/2015 06:16 AM, Neelesh Gupta wrote:
> >>> If the OPAL call to receive the ipmi message fails, then we free up the
> >>> smi message and return. But, the driver still holds the reference to
> >>> old smi message in the 'cur_msg' which can potentially be accessed later
> >>> and freed again leading to kernel oops. To fix it up,
> >>>
> >>> The kernel driver should reset the 'cur_msg' and send reply to the user
> >>> in addition to freeing the message.
> >>>
> >>> Signed-off-by: Neelesh Gupta<neelegup@linux.vnet.ibm.com>
> >>> ---
> >>>   drivers/char/ipmi/ipmi_powernv.c |   13 ++++++++++---
> >>>   1 file changed, 10 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/char/ipmi/ipmi_powernv.c 
b/drivers/char/ipmi/ipmi_powernv.c
> >>> index 9b409c0..637486d 100644
> >>> --- a/drivers/char/ipmi/ipmi_powernv.c
> >>> +++ b/drivers/char/ipmi/ipmi_powernv.c
> >>> @@ -143,9 +143,16 @@ static int ipmi_powernv_recv(struct 
ipmi_smi_powernv *smi)
> >>>   	pr_devel("%s:   -> %d (size %lld)\n", __func__,
> >>>   			rc, rc == 0 ? size : 0);
> >>>   	if (rc) {
> >>> -		spin_unlock_irqrestore(&smi->msg_lock, flags);
> >>> -		ipmi_free_smi_msg(msg);
> >>> -		return 0;
> >>> +		/* If came via the poll, and response was not yet ready */
> >>> +		if (rc == OPAL_EMPTY) {
> >>> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
> >>> +			return 0;
> >>> +		} else {
> >>> +			smi->cur_msg = NULL;
> >>> +			spin_unlock_irqrestore(&smi->msg_lock, flags);
> >>> +			send_error_reply(smi, msg, IPMI_ERR_UNSPECIFIED);
> >>> +			return 0;
> >>> +		}
> >>>   	}
> >>>
> >>>   	if (size < sizeof(*opal_msg)) {
> >>>
> >
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
