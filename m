Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 10D23DDF9E
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 02:01:18 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1539943ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 09:01:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910905250821nf433121s6c161d3f2104b453@mail.gmail.com>
References: <20090525013849.3073.96729.stgit@terra>
	<20090525102647.GD18290@sirena.org.uk>
	<9e4733910905250821nf433121s6c161d3f2104b453@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 10:00:57 -0600
Message-ID: <fa686aa40905250900g25ad3e34q7535a8ebb1197962@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 9:21 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Mon, May 25, 2009 at 6:26 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&psc_dma->lock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&psc_dma->psc_regs->ac97_slots, psc_=
dma->slots);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&psc_dma->lock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> This locking looks wrong - I'd expect it to also cover the modification
>> of psc_dma->slots? =A0Otherwise it's hard to see what it buys you.
>
> Grant, why are you spin locking around register access?

This lock/unlock is definitely bogus since a single register access is
already atomic.  Are there places in the code that I wrote where a
spin_lock/unlock is done around a single register access?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
