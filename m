Date: Tue, 16 Jul 2002 08:27:26 -0700
From: Matt Porter <porter@cox.net>
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_alloc() revisited
Message-ID: <20020716082726.B3654@home.com>
References: <20020716021313.GQ22786@zax> <3D3428FF.5090401@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D3428FF.5090401@embeddededge.com>; from dan@embeddededge.com on Tue, Jul 16, 2002 at 10:09:03AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 16, 2002 at 10:09:03AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
> > -	if (in_interrupt())
> > -		BUG();
> > +	BUG_ON(in_interrupt());
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
