Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5402DDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 01:52:47 +1000 (EST)
In-Reply-To: <92b3319be989145b0191cf9693ddd90c@kernel.crashing.org>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154675.3420.22.camel@zod.rchland.ibm.com>
	<92b3319be989145b0191cf9693ddd90c@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <345f23c36f44912708e8c42d3f432013@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Bamboo DTS
Date: Mon, 14 May 2007 17:52:15 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +		  	ranges = <00000000 0 00000000 80000000
>> +			          80000000 0 80000000 80000000>;
>
> You can avoid having two ranges by using #size-cells = 2
> in the root node.

Erm ignore this, size in a "ranges" property is encode
with the "#size-cells" of the child bus, not the parent
bus.  #size-cells = 2 does fix similar problems, just
not this one :-)

>   Having two ranges is a problem if any
> mapping straddles the boundary between the two.

You can get around this problem by making one range's
top or bottom boundary identical to that same boundary
of a bus range or reg range of a direct child of this
bus.  Since you don't have any kids for this node yet
it doesn't matter for now, but keep it in mind.


Segher
