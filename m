Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 7C029DE4C4
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 02:53:21 +1100 (EST)
Message-ID: <47E3DA40.6000007@ru.mvista.com>
Date: Fri, 21 Mar 2008 18:54:40 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
References: <12060242324116-git-send-email-john.linn@xilinx.com>	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<47E3B189.6060002@ru.mvista.com>
	<75a17dc1bd4e99a473ed679ccf9b210f@kernel.crashing.org>
In-Reply-To: <75a17dc1bd4e99a473ed679ccf9b210f@kernel.crashing.org>
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

Hello.

Segher Boessenkool wrote:

>>> Personally, I'm not fond of this approach.  There is already some
>>> traction to using the reg-shift property to specify spacing, and I
>>> think it would be appropriate to also define a reg-offset property to
>>> handle the +3 offset and then let the xilinx 16550 nodes use those.

>>    That's making things only worse than the mere "reg-shift" idea. I 
>> think that both are totally wrong. Everything about the programming 
>> interface should be said in the "compatible" and possibly "model" 
>> properties.

> No.  In effect, you are saying here that no device binding should define
> any binding-specific properties.  This will just lead to combinatorial
> explosion of "compatible" values.

> That said, "reg-spacing"/"reg-shift"/"reg-offset" should *not* be
> considered something generic; they are part of specific device
> bindings.  Of course it is nice if various bindings use the same
> names for the same concepts, but that's an orthogonal issue.

    The proposed use clearly would treat them as generic, since in the context 
of the Xilinx UART they're just not needed -- it's known beforehand and most 
probably fixed how/where the registers are mapped. There's just no need for 
such info in the device tree -- unless you're going to teach the *generic* 
driver to handle this specific (and possibly others alike) kind of a device.

>>  of_serial driver should recognize them and pass the necessary details 
>> to 8250.c. As for me, I'm strongly against plaguing the device tree 
>> with the *Linux driver implementation specifics*

> "reg-*" has nothing to do with Linux device driver implementation
> issues: it describes how a device is physically wired up!

    Hm... wasn't that you who were telling that use of "range" properties 
guarantees 1:1 correspondence of the upstream/downstream bus addresses (in 
their LSB part of course -- meaning that the device registers 0..x are seen by 
the CPU at addresses base+0..base+X?

>> (despite I was trying this with MTD -- there it seemed somewhat more 
>> grounded :-).

> Quite the opposite, but let's not rehash that discussion.

    I might be mixing with the February thread about this UART -- have 
alsready forgotten about it.

>>> In support of my argument; the fact that you need a table of data says
>>> to me that this data should really be encoded in the device tree.  :-)

>>    Not at all.

> Not _necessarily_.  I agree with Grant here: for many of these devices
> with byte-size registers, it is very common to find them with their
> register banks wired up differently, and that is often the *only*
> difference to the "normal" device.  In this situation, it makes a lot
> of sense to describe that difference with "reg-*" properties.

    Note that "compicated" mapping is not (necessarily) a property of the 
device itself but generally a property of the chip select circuit, i.e. 
external entity.

> In some other situations, it is better to create a new binding for
> the device.

> Segher

WBR, Sergei
