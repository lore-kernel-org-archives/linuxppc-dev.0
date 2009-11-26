Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E3071007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:23:24 +1100 (EST)
In-Reply-To: <1259209283.16367.241.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<1259209283.16367.241.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <370059AE-682E-4392-8AEE-E467EFF0E9ED@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
Date: Thu, 26 Nov 2009 23:30:20 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +       soc {
>>
>> It would be better to rename this as IMMR or the bus type.  This node
>> doesn't actually describe the entire chip, but describes the internal
>> memory mapped registers.
>
> I would really just call it "flipper" :-)

Yeah, I came to the same conclusion.

>> Since you're only doing 1:1 mappings; you could replace this with an
>> empty "ranges;" property instead.
>
> On the other hand it is a useful "documentation" to specify the exact
> range decoded when you know it :-)

Not the "decoded" range in this case, that is 0..4G :-)  The "canonical"
ranges is nice doc, yes.

>> Hint:  If you move the interrupt-parent property up to the root node,
>> then you don't need to specify it in every single device node; it  
>> will
>> just inherit from the parent.
>
> Note that this is a linux-ism no ? (aka ePAPRism).

Nope, it is from the standard interrupt mapping recommended practice.
It is fine.

> If they aim toward having a real OF which I think they do

We do.


Segher
