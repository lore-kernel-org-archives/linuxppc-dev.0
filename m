Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by ozlabs.org (Postfix) with ESMTP id D33D9DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 07:42:22 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j67so2104558rne.16
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 12:42:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090204195506.GA32613@pengutronix.de>
References: <20090204181907.616.52132.stgit@localhost.localdomain>
	<20090204195506.GA32613@pengutronix.de>
Date: Wed, 4 Feb 2009 13:42:20 -0700
Message-ID: <fa686aa40902041242j490e1ee0sf3916edd5804e89d@mail.gmail.com>
Subject: Re: [PATCH v4] powerpc/5200: Rework GPT driver to also be an IRQ
	controller
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Wolfram, thanks for the review.

On Wed, Feb 4, 2009 at 12:55 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
> I have been told to move such a changelog below the dashed lines,
> because it is not so important for the git-history.

This is only in my email for review purposes.  It won't be in the git commit.

>> +     status = in_be32(&gpt->regs->status) | MPC52xx_GPT_STATUS_IRQMASK;
>
> Like I mentioned in my first review, the following if-clause is always
> true. You probably mean "& MPC52xx_GPT_STATUS_IRQMASK"?

You're right.  I missed this from your first review.  Fixed.

>> +/* ---------------------------------------------------------------------
>> + * GPIOLIB hooks
>> + */
>> +#if defined(CONFIG_GPIOLIB)
>> +static inline struct mpc52xx_gpt_priv *gc_to_mpc52xx_gpt(struct gpio_chip *gc)
>> +{
>> +     return container_of(to_of_gpio_chip(gc), struct mpc52xx_gpt_priv,of_gc);
>
> Space after ','. As it is now, this is a checkpatch-error. Lines over 80
> chars are a warning.

This is on purpose as I described earlier.  Checkpatch is not God, and
the cure is worse than the disease.  (Granted, the disease is
equivalent to a running nose, and the cure to cheap kleenex, but hey,
it's still my decision).

>> +#else /* defined(CONFIG_SYSFS) */
>> +static void mpc52xx_gpt_create_attribs(struct mpc52xx_gpt_priv *) { return 0; }
>> +#endif /* defined(CONFIG_SYSFS) */
>
> Hmmm, I still have problems with this sysfs-entry. If you say that this
> is good for debugging, then please make it #DEBUG at least. Imagine
> every driver doing such things, this adds bloat. I'd still rather
> suggest using
>
> ~ memedit /dev/mem
> -> map <MBAR> 0x4000
> -> md 0x600
>
> which does the same and even allows for more (writing for example).

I understand your argument, but I'm still going to leave it in and
leave it enabled for now.  I will consider removing it after a release
or too.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
