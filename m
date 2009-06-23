Return-Path: <Kari.Davidsson@marel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E147DB70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 02:31:16 +1000 (EST)
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 270D5DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 02:31:15 +1000 (EST)
Message-ID: <4A410351.4050508@marel.com>
Date: Tue, 23 Jun 2009 16:31:13 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4] powerpc/5200: Add mpc5200-spi (non-PSC) device driver
References: <20090618025030.12363.69402.stgit@localhost.localdomain>
	<4A40E940.10201@marel.com>
	<fa686aa40906230853t5db35b11wae09cf46634d4758@mail.gmail.com>
In-Reply-To: <fa686aa40906230853t5db35b11wae09cf46634d4758@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lowered my SPI clock down to 1MHz (from 50MHz (in steps of 10MHz).
At 1Mhz the driver stops starving the rest of the kernel.

What is interesting is that due to the low duty cycle of the SPI port
the transfer rate at 1MHz and 50Mhz is almost the same.

I suggest that the driver simply limits max frequency to 1Mhz.

This (very limited) SPI pherperial does not handle any more anyways.

rg
kd


Grant Likely wrote:
> On Tue, Jun 23, 2009 at 8:40 AM, K=E1ri Dav=ED=F0sson<kari.davidsson@mare=
l.com> wrote:
>> Hi,
>>
>> I have been testing this driver a little bit (on 2.6.29.3)
>>
>> What happens for me is that the driver starves the system while sending
>> data over the SPI interface.
>>
>> I think the problem is in the function (interrupt handler)
>> mpc52xx_spi_irq() that calls the function mpc52xx_spi_fsm_process()
>> which again is an loop that iterates over the whole data to be sent.
>=20
> Hmmm, the state machine is supposed to yield after each byte sent, but
> on fast transfers I could see it becoming ready to run again
> immediately.
>=20
> Unfortunately it is not an easy problem.  The SPI device can only
> handle 1 byte at a time.  Maybe it would be better for CPU fairness if
> all the work was done in a thread.  I didn't originally because I
> didn't want to introduce a huge amount of scheduling overhead every
> time a byte was transfered, and I wanted to keep transfers fast.  I
> need to think about this some more.
>=20
> g.
>=20
