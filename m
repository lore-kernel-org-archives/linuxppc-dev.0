Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF6EDDDF1D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 05:23:42 +1000 (EST)
Message-ID: <464B585B.10301@freescale.com>
Date: Wed, 16 May 2007 14:15:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [i2c] [PATCH] Make i2c-mpc driver use i2c_add_numbered_adapter
References: <20070514190545.32739.72083.stgit@trillian.secretlab.ca>	<20070515152626.199f9d6b@hyperion.delvare>
	<200705150828.37529.david-b@pacbell.net>
In-Reply-To: <200705150828.37529.david-b@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: rtc-linux@googlegroups.com, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Tuesday 15 May 2007, Jean Delvare wrote:
> 
>>On Mon, 14 May 2007 13:11:23 -0600, Grant Likely wrote:
> 
> 
>>>--- a/drivers/i2c/busses/i2c-mpc.c
>>>+++ b/drivers/i2c/busses/i2c-mpc.c
>>>@@ -327,9 +327,10 @@ static int fsl_i2c_probe(struct platform_device *pdev)
>>> 	platform_set_drvdata(pdev, i2c);
>>> 
>>> 	i2c->adap = mpc_ops;
>>>+	i2c->adap.nr = pdev->id;
> 
> 
> By the way:  mpc_ops is a static i2c_adapter, so given that
> the reason for using pdev->id that way was that there might
> be more than one such platform device ... shouldn't allocation
> of the adapter be moved into allocation of the "i2c->" object?
> 
> Or at least, add a check to ensure that the static mpc_ops
> structure isn't in use before progressing this probe().

The mpc_ops struct is only used as a template; it gets copied into 
i2c->adap for each adapter instance.

-Scott
