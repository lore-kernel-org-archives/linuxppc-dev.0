Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id EA25BDE007
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 02:57:50 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so857927wri
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 09:57:49 -0700 (PDT)
Message-ID: <fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
Date: Mon, 15 Oct 2007 10:57:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Eugene Surovegin" <ebs@ebshome.net>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
In-Reply-To: <20071015163216.GA8127@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
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

On 10/15/07, Eugene Surovegin <ebs@ebshome.net> wrote:
> On Mon, Oct 15, 2007 at 03:29:11PM +0200, Stefan Roese wrote:
>
> <snip>
>
> > +#ifdef CONFIG_PPC_MERGE
> > +static int device_idx = -1;
> > +#endif
> > +
>
> <snip>
>
> > +     dev->idx = ++device_idx;
> > +     adap->nr = dev->idx;
>
> Hmm, this doesn't look right. That mighty powerpc device everybody
> was so excited about for the last years doesn't provide a device
> instance number/index?
>
> I think this approach is wrong, because I want i2c bus numbers for the
> on-chip i2c to be fixed. This code makes it dependent on the order
> devices were described in the device tree; how do you handle a
> situation when only the second i2c adapter is connected? For OCP I
> would just remove ocp_def for the IIC0.

Segher is recommending that we use an aliases node as per the open
firmware example for this.  I think in this case it would look
something like this (but I'm not the expert):

aliases {
     IIC0 = "/path/to/bus/iic@0x2000";
     IIC1 = "/path/to/bus/iic@0x2000";
};

Which seems to make sense to me.  And it keeps it easy to have
multiple iic bus types sharing the same IIC bus number space (each
device does not try to maintain it's own little 'next index' value).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
