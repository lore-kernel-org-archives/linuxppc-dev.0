Subject: Re: consistent_alloc() revisited
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF0BBC5FBD.B92030DF-ON85256BF8.005917E9@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Tue, 16 Jul 2002 12:14:44 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan and Matt

I agree with you 100%

Chip


---------------------- Forwarded by Ralph Blach/Raleigh/IBM on 07/16/2002
12:13 PM ---------------------------

Matt Porter <porter@cox.net>@lists.linuxppc.org on 07/16/2002 11:27:26 AM

Sent by:    owner-linuxppc-embedded@lists.linuxppc.org


To:    Dan Malek <dan@embeddededge.com>
cc:    David Gibson <david@gibson.dropbear.id.au>,
       linuxppc-embedded@lists.linuxppc.org
Subject:    Re: consistent_alloc() revisited




On Tue, Jul 16, 2002 at 10:09:03AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
> > - if (in_interrupt())
> > -       BUG();
> > + BUG_ON(in_interrupt());
>
> We should be able to call these functions from interrupt, let's push
> the remainder of the changes though get_free_pages() to make this happen.

Yes, not just "should", but "must".  They must be callable from an
interrupt since many generic drivers follow the rules as they have
been laid down and allocate from an interrupt context.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
