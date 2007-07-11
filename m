Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32887DDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:07:07 +1000 (EST)
In-Reply-To: <1184176531.32199.81.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
	<1184176531.32199.81.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F9FD5473-5BC4-4C01-8B65-EB890428A1BC@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Wed, 11 Jul 2007 20:07:00 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	plb {
>>> +		ranges;
>>
>> Please make the valid address ranges explicit here.
>
> Meaning what exactly?  I thought just specifying "ranges;" simply said
> "the addresses from this node don't have any translation from the  
> parent
> node" (or something like that).

Just list the actual ranges that sit on the PLB bus.  It is
good to be more explicit with these things (for example, the
kernel will have more information to work from when deciding
whether to apply a certain workaround for broken device trees
or not).

>>> +		SDRAM0: memory-controller {
>>> +			compatible = "ibm,sdram-405gp", "ibm,sdram-440gp";
>>
>> It's a bit weird to mention 440 here, since 405 is older.
>> Not a real problem, but if you still can change all relevant
>> OS code and device trees, I'd swap it around (make 440 trees
>> include the 405 "compatible" value).  Can you still do that
>> or is there a too big installed base already?
>
> The installed base for 440 exists of exactly 1 completely non- 
> functional
> board ;).  I can change it.

Yes exactly, let's do that while we still can.

>>> +			UART0: serial@ef600300 {
>>> +				current-speed = <2580>;
>>
>> Write this in decimal?
>
> In a comment?  Or?

Just in the code.  The syntax is <d#9600> I believe?

>> Quite a nice tree btw :-)
>
> Thanks!  Easy to do when there's nothing in it ;)

Well I didn't want to put it like that, but since you bring it
up yourself... :-)


Segher
