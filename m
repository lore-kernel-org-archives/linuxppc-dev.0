Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2F3A8DDFF0
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 03:04:41 +1100 (EST)
Message-ID: <47E52E68.60503@ru.mvista.com>
Date: Sat, 22 Mar 2008 19:06:00 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx uart
	16550.
References: <12060242324116-git-send-email-john.linn@xilinx.com>	<20080320144402.3063517C005D@mail148-sin.bigfish.com>	<fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com>	<18403.32257.725539.470771@cargo.ozlabs.ibm.com>
	<fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>
In-Reply-To: <fa686aa40803220750h1d86589am9a26aeeb359178b7@mail.gmail.com>
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

>> > Personally, I'm not fond of this approach.  There is already some
>> > traction to using the reg-shift property to specify spacing, and I
>> > think it would be appropriate to also define a reg-offset property to
>> > handle the +3 offset and then let the xilinx 16550 nodes use those.

>> Why do we need a reg-offset property when we can just add the offset
>> to the appropriate word(s) in the reg property?

> Primarily because the device creates 32 byte registers starting at 0;
> but they are also big-endian byte accessible so a byte read at offset
> 8 also works.  reg-offset seems to be a better description of the
> hardware to me.

    Ugh... I was just going is it possible to access the chip registers as 
32-bit entities, and employ UPIO_MEM32 mode of 8250.c -- just to avoid that 
reg-offset wart. Now you're telling everybody that it's completely 
superfluous... :-)

> Cheers,
> g.

WBR, Sergei
