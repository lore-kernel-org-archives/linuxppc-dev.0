Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CB3E1DE5A2
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:59:45 +1100 (EST)
Message-ID: <47E3E9D0.60105@ru.mvista.com>
Date: Fri, 21 Mar 2008 20:01:04 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
References: <12060242324116-git-send-email-john.linn@xilinx.com>	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<47E3B189.6060002@ru.mvista.com>
	<75a17dc1bd4e99a473ed679ccf9b210f@kernel.crashing.org>
	<47E3DA40.6000007@ru.mvista.com>
	<0a442bfb97492bd8d687678480c6217a@kernel.crashing.org>
In-Reply-To: <0a442bfb97492bd8d687678480c6217a@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>>    The proposed use clearly would treat them as generic, since in the 
>> context of the Xilinx UART they're just not needed -- it's known 
>> beforehand and most probably fixed how/where the registers are mapped. 
>> There's just no need for such info in the device tree -- unless you're 
>> going to teach the *generic* driver to handle this specific (and 
>> possibly others alike) kind of a device.

> I was under the impression that the "xilinx uart" was just a 16550 (or so)
> with its registers wired up in a slightly unusual way.  If it's a 
> completely
> different device, of course you need a separate binding, and you might not
> want reg-shift properties etc. there.

    It seems to be 16550 in the core, although coming in many flavors. :-)

>>> "reg-*" has nothing to do with Linux device driver implementation
>>> issues: it describes how a device is physically wired up!

>>    Hm... wasn't that you who were telling that use of "range" 
>> properties guarantees 1:1 correspondence of the upstream/downstream 
>> bus addresses (in their LSB part of course -- meaning that the device 
>> registers 0..x are seen by the CPU at addresses base+0..base+X?

> I have no idea what "ranges" has to do with this.

    Me neither. :-)

> This device is not a memory-mapped bus, it's a UART.

    IIRC, we were discussing MTD then, with an imaginary (for PPC) case of it 
being reverse-endian (actually happened on other archs)... IMHO, how the child 
bus addresses correspond to parent's one 1:1, doesn't imply that you can't 
have a device wired to the child bus a strange way, e.g. with byte-enables 
"reversed"...

>>>>> In support of my argument; the fact that you need a table of data says
>>>>> to me that this data should really be encoded in the device tree.  :-)

>>>>    Not at all.

>>> Not _necessarily_.  I agree with Grant here: for many of these devices
>>> with byte-size registers, it is very common to find them with their
>>> register banks wired up differently, and that is often the *only*
>>> difference to the "normal" device.  In this situation, it makes a lot
>>> of sense to describe that difference with "reg-*" properties.

>>    Note that "compicated" mapping is not (necessarily) a property of 
>> the device itself but generally a property of the chip select circuit, 
>> i.e. external entity.

> There is no difference insofar as the device tree is concerned.

    OK...

> Segher

WBR, Sergei
