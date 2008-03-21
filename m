Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB0C4DE6F2
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 02:37:55 +1100 (EST)
In-Reply-To: <47E3B189.6060002@ru.mvista.com>
References: <12060242324116-git-send-email-john.linn@xilinx.com>	<20080320144402.3063517C005D@mail148-sin.bigfish.com>
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>
	<47E3B189.6060002@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <75a17dc1bd4e99a473ed679ccf9b210f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
Date: Fri, 21 Mar 2008 16:37:44 +0100
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

>> Personally, I'm not fond of this approach.  There is already some
>> traction to using the reg-shift property to specify spacing, and I
>> think it would be appropriate to also define a reg-offset property to
>> handle the +3 offset and then let the xilinx 16550 nodes use those.
>
>    That's making things only worse than the mere "reg-shift" idea. I 
> think that both are totally wrong. Everything about the programming 
> interface should be said in the "compatible" and possibly "model" 
> properties.

No.  In effect, you are saying here that no device binding should define
any binding-specific properties.  This will just lead to combinatorial
explosion of "compatible" values.

That said, "reg-spacing"/"reg-shift"/"reg-offset" should *not* be
considered something generic; they are part of specific device
bindings.  Of course it is nice if various bindings use the same
names for the same concepts, but that's an orthogonal issue.

>  of_serial driver should recognize them and pass the necessary details 
> to 8250.c. As for me, I'm strongly against plaguing the device tree 
> with the *Linux driver implementation specifics*

"reg-*" has nothing to do with Linux device driver implementation
issues: it describes how a device is physically wired up!

> (despite I was trying this with MTD -- there it seemed somewhat more 
> grounded :-).

Quite the opposite, but let's not rehash that discussion.

>> In support of my argument; the fact that you need a table of data says
>> to me that this data should really be encoded in the device tree.  :-)
>
>    Not at all.

Not _necessarily_.  I agree with Grant here: for many of these devices
with byte-size registers, it is very common to find them with their
register banks wired up differently, and that is often the *only*
difference to the "normal" device.  In this situation, it makes a lot
of sense to describe that difference with "reg-*" properties.

In some other situations, it is better to create a new binding for
the device.


Segher
