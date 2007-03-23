Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 2515DDDE07
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Mar 2007 03:00:13 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1863869nfc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 09:00:12 -0700 (PDT)
Message-ID: <528646bc0703230900m461758c5if8e3d996ce00198d@mail.gmail.com>
Date: Fri, 23 Mar 2007 10:00:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sylvain Munaut" <tnt@246tnt.com>,
	"Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 3/5 v2] mpc52xx suspend: USB
In-Reply-To: <4603C07F.4000007@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104228.GD22215@moe.telargo.com>
	<528646bc0703150624i2bac5ce4n7beebc88d8acbafe@mail.gmail.com>
	<20070322074443.GB4620@moe.telargo.com> <4603C07F.4000007@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/23/07, Sylvain Munaut <tnt@246tnt.com> wrote:
> Domen Puncer wrote:
> > +     struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
> > +     if (machine_is_compatible("generic-mpc5200")) {
> > +             struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> >
> >
> Not good, what if you have a Ohci PCI card on a 5200 board ...
>
> You somehow need to check the compatible list of the of_node associated
> with the particular instance you're putting to sleep.

Also, I don't think the device tree should be queried at runtime
inside the suspend/resume functions.  All device tree queries should
probably go into the probe() routine and the results cached.

However, I'm no longer convinced that this is the correct approach.
I've gone and looked at the 5200b usb documentation, and it looks to
me like the handling of port power is really a board/system specific
thing.  For example, a new system might require port power to be
forced on when the processor is suspended.

I think this code should be moved to the board support code in
arch/powerpc/platforms/52xx.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
