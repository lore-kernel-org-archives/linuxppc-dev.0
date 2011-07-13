Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-qy0-f170.google.com (mail-qy0-f170.google.com
	[209.85.216.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4EC0B6F74
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 17:20:51 +1000 (EST)
Received: by qyg14 with SMTP id 14so148179qyg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 00:20:48 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <20110712.051316.1963034055315982365.davem@davemloft.net>
References: <1310465411.3314.6.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
	<CAMJ=MEeC1hoqufs7AfFRn3yJoC8mdw7v+14N+7e=wQuJefm4_w@mail.gmail.com>
	<20110712.050817.1253941735409335652.davem@davemloft.net>
	<20110712.051316.1963034055315982365.davem@davemloft.net>
Date: Wed, 13 Jul 2011 09:20:47 +0200
Message-ID: <CAAXf6LXddZUHEz738DDTi-XqENRYT7dTODw+1C4RTYsCdyro7g@mail.gmail.com>
Subject: Re: softirqs are invoked while bottom halves are masked
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, ronny.meeus@gmail.com,
	eric.dumazet@gmail.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2011 at 2:13 PM, David Miller <davem@davemloft.net> wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 12 Jul 2011 05:08:17 -0700 (PDT)
>
>> From: Ronny Meeus <ronny.meeus@gmail.com>
>> Date: Tue, 12 Jul 2011 14:03:04 +0200
>>
>>> but we still see the issue "BUG: sleeping function called from invalid =
context":
>>>
>>> [ =A0 91.015989] BUG: sleeping function called from invalid context at
>>> include/linux/skbuff.h:786
>>> [ =A0 91.117096] in_atomic(): 1, irqs_disabled(): 0, pid: 1865, name: N=
MTX_T1842
>>> [ =A0 91.200461] Call Trace:
>>> [ =A0 91.229672] [ec58bbd0] [c000789c] show_stack+0x78/0x18c (unreliabl=
e)
>>> [ =A0 91.305791] [ec58bc10] [c0022900] __might_sleep+0x100/0x118
>>> [ =A0 91.372524] [ec58bc20] [c029f8d8] dpa_tx+0x128/0x758
>>
>> Because this dpa driver's transmit method is doing something else that
>> is not allowed in software interrupt context.
>>
>> You must remove all things that might sleep in this driver's
>> ->ndo_start_xmit method, and I do mean everything.
>
> Also this whole HW QOS feature bit facility is beyond bogus.
>
> What if the user enables a qdisc that the hardware can't handle, or a
> configuration of a hw supported qdisc that the hardware can't support?
>
> What if I have packet classification and packet actions enabled in the
> packet scheduler?
>
> These changes are terrible, and we really need you guys to sort out
> your problems with these changes yoursleves because your wounds are
> entirely self-inflicted and totally not our problem.
>

Of course, you make very valid points.

I just want to mention that, although you seem to think that we
shouldn't have created this thread in the first place, your and Eric's
remarks have actually helped us in identifying the problem and
increasing our understanding.

So, thanks for that.

Thomas
