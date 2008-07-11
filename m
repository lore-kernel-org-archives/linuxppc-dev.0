Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1FEA0DDED7
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 04:55:49 +1000 (EST)
Date: Fri, 11 Jul 2008 22:55:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
Message-ID: <20080711185546.GA17371@polina.dev.rtsoft.ru>
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080711182323.GB15321@secretlab.ca>
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 11, 2008 at 12:23:23PM -0600, Grant Likely wrote:
> On Fri, Jul 11, 2008 at 09:48:59PM +0400, Anton Vorontsov wrote:
> > Firstly kernel warns at set_irq_chip, and then dies completely:
> > 
> > Trying to install chip for IRQ-1
> >
> > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
> > index b2ccdcb..95a24de 100644
> > --- a/drivers/of/of_i2c.c
> > +++ b/drivers/of/of_i2c.c
> > @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
> >  		if (info.irq == NO_IRQ)
> >  			info.irq = -1;
> 
> What is the reason that info.irq is set to -1 in the first place?

I believe this is because of this checking mess:

grep irq -r drivers/rtc/ drivers/i2c/chips/ | grep if
grep "define NO_IRQ" -r include/

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
