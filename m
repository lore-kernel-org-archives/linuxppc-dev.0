Return-Path: <adolnikov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B1DA6DDEBE
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 04:28:18 +1100 (EST)
Message-ID: <47558E59.4040107@ru.mvista.com>
Date: Tue, 04 Dec 2007 20:28:57 +0300
From: Andrei Dolnikov <adolnikov@ru.mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
References: <20071129152836.GB13751@ru.mvista.com>
	<1196715170.13230.228.camel@pasglop>
	<20071204012329.GA18903@mag.az.mvista.com>
In-Reply-To: <20071204012329.GA18903@mag.az.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David.Jenkins@emerson.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
> On Tue, Dec 04, 2007 at 07:52:50AM +1100, Benjamin Herrenschmidt wrote:
>   
>>> 	#address-cells = <1>;
>>> +	#size-cells = <1>;
>>> +	model = "Katana-Qp"; /* Default */
>>> +	compatible = "emerson,Katana-Qp";
>>> +	coherency-off;
>>> +
>>>       
>> What do that mean (coherency-off) ?
>>
>> Somebody is trying again to use a 74xx with non cache coherent DMA ?
>>     
>
> Hi Ben.
>
> I suspect Andrei got that from the prpmc2800 dts which I made so I'll
> jump in.  (BTW, this is the same debate we have every year or two. :)
>
> By looking at the dts, that board has an mv64460 which has a couple
> issues when it comes to coherency (depending on the rev of the chip).
>
> One is about not being able to use DCBST instructions with coherency on
> and the other is about limiting the length of one of the traces (which
> at least one board manufacturer that I know of refuses to implement).
> The first one is supposed to be fixed by rev A1 of the part and the second
> is supposed to be fixed by rev B0 of the part.  I don't know what rev(s)
> are on the board(s) Andrei is using.  If its B0 or later, in theory, the
> part should work with coherency on.
>
> Andrei, have you tested with coherency on?
>   
Yes, I tested it with "coherency on", but it didn't work.

I checked chip revisions on all boards I have and they all are >= 
mv64_4_60 B0.
Emerson team working on U-Boot for KatanaQP (David Jenkins copied in cc) 
notified that they have newer firmware version which makes "coherency 
on" functional.
At the moment I have no more details on it, but I'll investigate this 
issue soon and let you know all the details.
> --
> [snip errata]
> --
>
> So, the answer depends on what part & what rev of the part you have
> (e.g., the pegasos doesn't use the MPSC and apparently has the other
> issues worked around so it can turn on coherency but the prpmc2800
> doesn't so it needs coherency off).
>
> BTW, I haven't forgotten the inherent bug you described when coherency
> is off (/me too lazy to find link to the email) but AFAIK I've never run
> into it.  However, if I turn on coherency and stress the PCI bus, it
> hangs (I can't even look at memory thru a bdi).
>
> Mark
>   
Thanks,
Andrei.
