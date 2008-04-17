Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 66906DE157
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:55:06 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so1068504uge.0
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:55:04 -0700 (PDT)
Message-ID: <480764C3.5040602@genesi-usa.com>
Date: Thu, 17 Apr 2008 15:54:59 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>
	<200804171619.56615.jbe@pengutronix.de>
	<48075D4B.7030501@genesi-usa.com>
	<200804171641.33986.jbe@pengutronix.de>
In-Reply-To: <200804171641.33986.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Juergen Beisert wrote:
> On Thursday 17 April 2008 16:23, Matt Sealey wrote:
>> Hooray! :)
>>
>> Does it work, though, with your board?
>>
>>> -	u16		ccr;		/* PSC + 0x20 */
>>> -	u8		reserved7[14];
>>> +	u32		ccr;		/* PSC + 0x20 */
>>> +	u32		ac97_slots;	/* PSC + 0x24 */
>> I think it should be left noted here that the CCR size changed from
>> 16 bits to 32 bits from 5200 to 5200B in order to reduce confusion.
>> You may have read the manual but that does not mean that an extra
>> small comment would not be appreciated by a lot of people (after
>> all who would want to write code for a legacy 5200 device, write
>> to psc->ccr and wonder why it explodes?)
> 
> Hmm, my board runs an MPC5200B. How can we solve this u16 versus u32 issue for 
> both CPUs?

Use a union like the rest of the bits of the PSC/FIFO structures which
differ per-chip or per-functionality, I'd say.

You can't solve this with the device tree.. you literally have to write
to the right place, which is dictated to you by the chip you run (which
is determined from the device tree) but actually writing to that place
can't be done by writing a 16-bit value into the ccr location (since it
will write into the low-order 16-bits of the 32-bit ccr, which is not
actually the CCR register on 5200).

If running a 5200 or 5200B has been determined, then the driver can then
mangle it's CCR setting code to match. The PSC UART driver already has
a small workaround for this although I am not sure it is the cleanest
method in the world..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
