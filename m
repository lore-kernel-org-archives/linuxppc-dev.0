Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 2FAE7DE0F9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:16:19 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3942351pyi
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 12:16:18 -0700 (PDT)
Message-ID: <fa686aa40710151216k48d021cfo4302b8e9001fea9a@mail.gmail.com>
Date: Mon, 15 Oct 2007 13:16:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Eugene Surovegin" <ebs@ebshome.net>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
In-Reply-To: <20071015191118.GA9733@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
	<20071015191118.GA9733@gate.ebshome.net>
Cc: Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Eugene Surovegin <ebs@ebshome.net> wrote:
> On Mon, Oct 15, 2007 at 01:53:40PM -0500, Scott Wood wrote:
> > Though, I don't see what the problem with the original approach is, as long
> > as the numbers are chosen in the same way when registering i2c clients based
> > on the children of the adapter node.  There's no concept in the hardware
> > itself of a bus number.
>
> Huh? As far as I can tell, there is. Also, I want messages from the
> kernel mention something I can map to the real hw, e.g. fixed IIC
> device index, not some random number.

Yes, in the same way that there may be more than one on-chip serial or
ethernet controllers.  However, it does not necessarily follow that
the *logical* bus number will match the way on chip devices are
numbered.

Example: Suppose you have a board with 2 chips which each include 2
i2c controllers.  Each chip numbers them 1 & 2.  So, which chip gets
1-2 and which one gets 3-4?

>
> This already works with the current OCP code, so if you want change
> it to a "superior" technology, please, make sure it provides the same
> functionality as trivial OCP one.

agreed

> I find it rather puzzling that instead people are trying to make
> this a non-issue as soon as it cannot be implemented easily with
> their new and shiny infrastructure.

No, it is a real problem; and not just for i2c.  We need a solution for it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
