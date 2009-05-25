Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id A5975DE0B2
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 01:59:22 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1543413yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 08:59:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910905250815r4a6fa205s26531f08fe99131a@mail.gmail.com>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013849.3073.96729.stgit@terra>
	<fa686aa40905242316j3e8b46e7mcc71dc34df209003@mail.gmail.com>
	<9e4733910905250815r4a6fa205s26531f08fe99131a@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 25 May 2009 09:59:01 -0600
Message-ID: <fa686aa40905250859v75c504adx8681e7cb78b3f445@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] AC97 driver for mpc5200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 9:15 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Mon, May 25, 2009 at 2:16 AM, Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>> On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>> +static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned sh=
ort reg)
>>> +{
>>> + =A0 =A0 =A0 int timeout;
>>> + =A0 =A0 =A0 unsigned int val;
>>> +
>>> + =A0 =A0 =A0 spin_lock(&psc_dma->lock);
>>> +
>>> + =A0 =A0 =A0 /* Wait for it to be ready */
>>> + =A0 =A0 =A0 timeout =3D 1000;
>>> + =A0 =A0 =A0 while ((--timeout) && (in_be16(&psc_dma->psc_regs->sr_csr=
.status) &
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 MPC52xx_PSC_SR_CMDSEND))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
>>
>> Holy unbounded latency Batman! =A0This code waits up to 10ms for a regis=
ter read!
>>
>> I hate spinning, but if it must be done; I'd like to see it small.
>> What is the worst case latency? 125us for 8000Hz bus speed? =A0If you
>> must spin; can a cpu_relax() be used instead of the udelay() while
>> watch the timebase? =A0Timur recently posted a patch which makes this
>> easier.
>>
>> http://patchwork.ozlabs.org/patch/27414/
>>
>> They *should* be appearing in Ben's -next branch soon.
>
>
> The link always runs at 12.288Mhz. Each frame is 256 bits. Worst case
> you wait for two frames, 42us. If it doesn't respond in 42us the codec
> clock is not ticking ( a recurring problem I am running into). These
> codecs may be going into a sleep mode I don't understand, but this is
> not the right place to try and wake them up. I'll lower the retry
> counts to 10 instead of 1000.

That still leaves the problem of unecessarily burning time.  udelay
shouldn't be passed any value larger than 1.  In fact, I think udelay
itself is too coarse grained.  Plus, I'd rather see the timebase used
as the exit condition (as mentioned in previous email).

> I played around with implementing this on a kernel thread with
> interrupts. It can be done but the code is a lot more complex.

A kernel thread is definitely the wrong approach.  However, if this is
non-atomic context and IRQs are available, then a wait queue can be
used.  42us is about 16k processor clocks.  I'm not sure what the IRQ
and scheduling overhead is so I don't know whether it would be a net
gain or loss in performance.  However, it would be a net gain in worst
case latency.

> BTW, 8000Hz is implemented by slot stuffing. The link always runs at
> 12.288Mhz. The DACs are double buffered. When a sample is transfered
> between buffers it sets a bit on the link back to the host, and the
> host sends the next sample in the appropriate slot.

ok.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
