Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 973C2DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:40:08 +1000 (EST)
In-Reply-To: <46709A84.7030307@am.sony.com>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<46709A84.7030307@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6ef2a5debaf78e8f2fa7de8b72653203@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Thu, 14 Jun 2007 09:39:59 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I will use model = "SonyPS3";

Okie.

>>> +	compatible = "PS3";
>>
>> name = "sony,ps3"
>
>
> As Ben H. said, the top level 'name' cannot be set,

Bug in the flat device tree stuff.

> and
> I found dtc exits with an error if you include one.
>
> The compatible entry is generally used to test for machine
> type, so I think that needs to remain, and I will use
> compatible = "sony,ps3".

"compatible" is a set of alternates for "name", so you can
use it if you have to.

>>> +	 * Need to keep linux,platform for a while, not used by kernel.
>>> +	 */
>>
>> Why that?
>
> Newer dtc seems to be OK with this removed, old ones exited with error.

Ok.  So you'll remove it?

>>> +		CBE,PPE {
>>
>> PowerPC,CBE@0 or cpu@0 -- the important thing is you need
>> the @0 unit address.
>
> OK, I set it up as cpu@0, since the actual type seems to be probed for.

PowerPC CPUs have a defined way of identifying themselves
exactly, and this PVR value is supposed to be in the
device tree too (although Linux probes it directly from
the CPU).  You could still put the name in the "compatible"
property, but CPU nodes are a bit special, I don't think
that would gain anything.

>>> +			d-cache-size = <8000>;
>>
>> I thought DL1 was 64kB, I might be wrong though?
>
> The BE handbook says 32.

Ok, good.


Segher
