Return-Path: <sshtylyov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id AED01DDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 03:14:30 +1100 (EST)
Message-ID: <47E7D3BB.1050403@ru.mvista.com>
Date: Mon, 24 Mar 2008 19:15:55 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
References: <12060242324116-git-send-email-john.linn@xilinx.com>	
	<20080320144402.3063517C005D@mail148-sin.bigfish.com>	
	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>	
	<18403.32257.725539.470771@cargo.ozlabs.ibm.com>	
	<fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>	
	<47E7B61B.70708@ru.mvista.com>
	<fa686aa40803240727p14c7e8c0r8575f7d5feb776dd@mail.gmail.com>
In-Reply-To: <fa686aa40803240727p14c7e8c0r8575f7d5feb776dd@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

>> >> > Personally, I'm not fond of this approach.  There is already some
>> >> > traction to using the reg-shift property to specify spacing, and I
>> >> > think it would be appropriate to also define a reg-offset property to
>> >> > handle the +3 offset and then let the xilinx 16550 nodes use those.

>> >> Why do we need a reg-offset property when we can just add the offset
>> >> to the appropriate word(s) in the reg property?
>
>> > Primarily because the device creates 32 byte registers starting at 0;
>> > but they are also big-endian byte accessible so a byte read at offset
>> > 8 also works.

>>    Probably I misunderstood you: does it give the same result as offset 11?

> er; typo; oops.  A 32 bit read add offset 0 is the same as a byte read
> at offset *3*.

    Oh, well... unfortunately, we can't use UPIO_MEM32 "register model" in 
8250.c anyway since that makes use of readl()/writel() -- which treat the bus 
as bigendian on PPC... anyway, we would need at least a "reg-size" property, 
if not new "compatible"...

>> > reg-offset seems to be a better description of the hardware to me.

>>    Have you considered using the existing "big-endian" property?

> No I haven't, but that would work too.  I'm happy with that if it
> works for you.  If the property was defined, then the byte offset to
> the first reg would be adjusted by 1^(reg-shift) - 1

    You don't mean "xor" by ^, do you? :-O
    In fact, it should be <<...

> Cheers,
> g.

WBR, Sergei
