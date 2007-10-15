Return-Path: <glikely@secretlab.ca>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.236])
	by ozlabs.org (Postfix) with ESMTP id E0EECDE0DB
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:13:23 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so1379352hud
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:13:16 -0700 (PDT)
Message-ID: <fa686aa40710151213r670bea49i63fa5f5402aa150d@mail.gmail.com>
Date: Mon, 15 Oct 2007 13:13:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
In-Reply-To: <20071015185340.GB4474@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Oct 15, 2007 at 10:57:48AM -0600, Grant Likely wrote:
> > Segher is recommending that we use an aliases node as per the open
> > firmware example for this.  I think in this case it would look
> > something like this (but I'm not the expert):
> >
> > aliases {
> >      IIC0 = "/path/to/bus/iic@0x2000";
> >      IIC1 = "/path/to/bus/iic@0x2000";
> > };
>
> I think this is overly complicated; something like linux,i2c-index in the
> i2c adapter node would be simpler.

But not perhaps better.  Enumeration is a system-wide thing.  It does
make sense to group all the device enumerations in one place.  It
eliminates two nodes trying to enumerate to the same device number and
since device numbers are something that the user will potentially want
to modify, it separates enumeration from hardware description.

As per your point below; if all the i2c devices are children of the
adapter, then yes you are right that the bus number doesn't matter to
the user.  But it *does* matter for things like serial and ethernet
ports.

>
> Though, I don't see what the problem with the original approach is, as long
> as the numbers are chosen in the same way when registering i2c clients based
> on the children of the adapter node.  There's no concept in the hardware
> itself of a bus number.

Even if you take this approach, the driver still need to know what bus
number to use (as per the i2c infrastructure).  It is not sane for an
i2c bus driver to attempt to assign the bus number itself because it
could conflict with another arbitrarily chosen bus number from another
driver.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
