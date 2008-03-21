Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66324DDE41
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:45:50 +1100 (EST)
In-Reply-To: <47E3DA40.6000007@ru.mvista.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<47E3B189.6060002@ru.mvista.com>
	<75a17dc1bd4e99a473ed679ccf9b210f@kernel.crashing.org>
	<47E3DA40.6000007@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0a442bfb97492bd8d687678480c6217a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
Date: Fri, 21 Mar 2008 17:45:35 +0100
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>    The proposed use clearly would treat them as generic, since in the 
> context of the Xilinx UART they're just not needed -- it's known 
> beforehand and most probably fixed how/where the registers are mapped. 
> There's just no need for such info in the device tree -- unless you're 
> going to teach the *generic* driver to handle this specific (and 
> possibly others alike) kind of a device.

I was under the impression that the "xilinx uart" was just a 16550 (or 
so)
with its registers wired up in a slightly unusual way.  If it's a 
completely
different device, of course you need a separate binding, and you might 
not
want reg-shift properties etc. there.

>> "reg-*" has nothing to do with Linux device driver implementation
>> issues: it describes how a device is physically wired up!
>
>    Hm... wasn't that you who were telling that use of "range" 
> properties guarantees 1:1 correspondence of the upstream/downstream 
> bus addresses (in their LSB part of course -- meaning that the device 
> registers 0..x are seen by the CPU at addresses base+0..base+X?

I have no idea what "ranges" has to do with this.  This device is not
a memory-mapped bus, it's a UART.

>>>> In support of my argument; the fact that you need a table of data 
>>>> says
>>>> to me that this data should really be encoded in the device tree.  
>>>> :-)
>
>>>    Not at all.
>
>> Not _necessarily_.  I agree with Grant here: for many of these devices
>> with byte-size registers, it is very common to find them with their
>> register banks wired up differently, and that is often the *only*
>> difference to the "normal" device.  In this situation, it makes a lot
>> of sense to describe that difference with "reg-*" properties.
>
>    Note that "compicated" mapping is not (necessarily) a property of 
> the device itself but generally a property of the chip select circuit, 
> i.e. external entity.

There is no difference insofar as the device tree is concerned.


Segher
