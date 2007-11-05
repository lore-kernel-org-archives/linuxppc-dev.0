Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 90D3ADDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 09:46:46 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id d23so246192and
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 14:46:45 -0800 (PST)
Message-ID: <fa686aa40711051446q1abe886dh6225fa1ec675ef9b@mail.gmail.com>
Date: Mon, 5 Nov 2007 15:46:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F8267.8070106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> Jon Smirl wrote:
> > On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> >> Jon Smirl wrote:
> >>> This is my first pass at reworking the Freescale i2c driver. It
> >>> switches the driver from being a platform driver to an open firmware
> >>> one. I've checked it out on my hardware and it is working.
> >> We may want to hold off on this until arch/ppc goes away (or at least
> >> all users of this driver in arch/ppc).
> >
> > How about renaming the old driver file and leaving it hooked to ppc?
> > Then it would get deleted when ppc goes away. That would let work
> > progress on the powerpc version.
>
> Or we could have one driver that has two probe methods.  I don't like
> forking the driver.

I agree.  This driver can and should have multiple bus bindings.

> >>>       cell-index = <1>;
> >> What is cell-index for?
> >
> > I was using it to control the bus number, is that the wrong attribute?
>
> It shouldn't be specified at all -- the hardware has no concept of a
> device number.

cell-index is important.  It describes the hardware, or more
specifically the layout of the SoC.  The SoC has 2 i2c busses which
are numbered 0 and 1.  This property should stay for the 5200.
However, that is the only purpose of it.  cell-index does *not*
describe the system level bus number.

> > I was allowing control of the bus number with "cell-index" and
> > i2c_add_numbered_adapter().
> > Should I get rid of this and switch to i2c_add_adapter()?
>
> Yes.

Yes, the purpose of cell-index is not to give an i2c bus number enumeration.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
