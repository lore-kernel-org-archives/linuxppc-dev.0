Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67EB31007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 10:10:07 +1100 (EST)
In-Reply-To: <1259268528.18084.2.camel@pasglop>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1259210722.16367.256.camel@pasglop>
	<4B0E9A0F.9010203@yahoo.es> <1259268528.18084.2.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A43EF6FD-0906-4723-B007-C9622FE8266D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
Date: Fri, 27 Nov 2009 00:17:02 +0100
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

>> They are a bit special because registers are in reverse little  
>> endian format,
>> must be written in 32-bit chunks, and (all things point to) they  
>> have hardware bugs.
>
> Well.. first what is "reverse little endian" ? :-) Big endian ?

Nah.  Little-endian, with a 32-bit bus swizzle.  This is not the
same thing as big-endian when not all your registers are 32 bits.

Also, you can only write 32 bits, they don't use byte enables.

> As for HW bugs, well, as long as we know them we can define a quirk  
> bit
> and add the necessary workarounds to the driver :-)

The question is if the device is close enough to OHCI to declare it
as that in the device tree.  I would say "yes".


Segher
