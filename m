Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id C9AC2DDF8C
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:20:22 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so92301anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 15:20:21 -0700 (PDT)
Message-ID: <fa686aa40807161520rfaf056elcd2116b70371d95d@mail.gmail.com>
Date: Wed, 16 Jul 2008 16:20:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfram Sang" <w.sang@pengutronix.de>
Subject: Re: [i2c] [PATCH] of/i2c: don't pass -1 to irq_dispose_mapping,
	otherwise kernel will oops
In-Reply-To: <20080712080004.GA16739@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080711174859.GA24260@polina.dev.rtsoft.ru>
	<20080711182323.GB15321@secretlab.ca>
	<20080712080004.GA16739@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2008 at 2:00 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Fri, Jul 11, 2008 at 12:23:23PM -0600, Grant Likely wrote:
>> On Fri, Jul 11, 2008 at 09:48:59PM +0400, Anton Vorontsov wrote:
>> > Firstly kernel warns at set_irq_chip, and then dies completely:
>> >
>> > Trying to install chip for IRQ-1
>> >
>> > diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
>> > index b2ccdcb..95a24de 100644
>> > --- a/drivers/of/of_i2c.c
>> > +++ b/drivers/of/of_i2c.c
>> > @@ -93,10 +93,8 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
>> >             if (info.irq == NO_IRQ)
>> >                     info.irq = -1;
>>
>> What is the reason that info.irq is set to -1 in the first place?  This
>> looks like another bug to me.  Does something in the i2c layer depend on
>> the -1 value?
>>
>
> You already acked a fix to this :) I wasn't sure if my patch would
> make it on its own, as Jon Smirl was also working on fixes to of_i2c.c
> and he seemed to pick up this issue, too.

Ugh, I have trouble remembering what I've done from one day to the next.  :-/

After looking at it again, I'm inclined to prefer the NO_IRQ fix.
There is a smaller user base of of_i2c and so it will have a much
smaller impact if it breaks stuff.  It also has the added advantage of
encouraging people to actually fix the drivers that assume -1.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
