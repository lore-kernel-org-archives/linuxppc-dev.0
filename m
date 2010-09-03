Return-Path: <emillbrandt@dekaresearch.com>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
	[208.65.175.196]) by ozlabs.org (Postfix) with ESMTP id 3F62AB714D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 02:37:10 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: 'Wolfram Sang' <w.sang@pengutronix.de>
Date: Fri, 3 Sep 2010 12:40:08 -0400
Subject: RE: [PATCH] powerpc/5200: tighten up ac97 reset timing
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3254AA09E8F@dekaexchange07.deka.local>
References: <1283528722-15644-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100903160209.GE4813@pengutronix.de>
	<0A40042D85E7C84DB443060EC44B3FD3254AA09E8E@dekaexchange07.deka.local>
	<20100903162224.GF4813@pengutronix.de>
In-Reply-To: <20100903162224.GF4813@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 3 Sep 2010 at 12:22:24 Wolfram Sang wrote:
>>>> -       udelay(2);
>>>> +       udelay(1);
>>>>
>>>>         /* Deassert reset */
>>>>         setbits8(&wkup_gpio->wkup_dvo, reset);
>>>>
>>>> +       /* wait at least 200ns */
>>>> +       __delay(7);
>>>
>>> ndelay(200)?
>>  Is ndelay defined for powerpc?  I was under the impression that it was
>> being redefined to udelay in linux/delay.h.
>>
>> #ifndef ndelay
>> static inline void ndelay(unsigned long x)
>> {
>>         udelay(DIV_ROUND_UP(x, 1000));
>> }
>> #define ndelay(x) ndelay(x)
>> #endif
>
> Yes, but it is way more readable. Does the extra delay hurt? The value
> of 7 looks a bit magic to me. Are you sure it will do for various
> clock frequencies?
>

The reset is happening in the gpio spinlock, so I am trying to keep busy
waiting to a minimum.  The magic value of 7 calculates to *roughly* 200ns
with a system timebase of 33mhz.  This timebase drives the mpc5200(b) at
its max clock speed of 400mhz, so slower frequencies should just extend the
delay, which is acceptable.  If you strongly object to the use of __delay
I can change it to ndelay.


-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are=
 intended to be a confidential communication only to the person or entity t=
o whom it is addressed and may contain information that is privileged. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that any dissemination, distribution or copying of this communication=
 is strictly prohibited. If you have received this communication in error, =
please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
