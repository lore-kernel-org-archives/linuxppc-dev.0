Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F888DDEC5
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 06:15:52 +1000 (EST)
In-Reply-To: <20070802151513.12e9caf7@weaponx.rchland.ibm.com>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<20070802151513.12e9caf7@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a9100305ca02c8609458c72edb99342c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Mon, 6 Aug 2007 22:15:39 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	UIC0: interrupt-controller0 {
>>> +		compatible = "ibm,uic-440gp","ibm,uic";
>>
>> The first compatible entry should always be the precise model, so in
>> this case "ibm,uic-440epx".  If it is (supposed to be) identical to
>> the UIC in the 440GP, it can also have an "ibm,uic-440gp" entry, but
>> since I believe all the UICs are supposed to operate the same, I think
>> that's implicit in the "ibm,uic" entry.
>
> Most UICs are the same.  There are some oddball chips that either hide
> particular registers because they are unused, or they change the
> addressing stride.  I'm not sure that is a common enough case to worry
> about now though.

You only need to worry about the oddball cases in the device
trees for a device that uses one off those.

It is prudent to put the exact name of the device you're
working with in there whenever possible, in case you later
discover it has some quirks.  If that doesn't happen, the
kernel can happily keep probing on the more generic name.


Segher
