Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 91AD6679F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 22:42:26 +1000 (EST)
Message-ID: <003a01c571a7$cb45bef0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Jason Chen" <jason_chen@usish.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <200506150531.j5F5VMPK006235@ms.usish.com>
Date: Wed, 15 Jun 2005 08:43:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: Re: change the SDRAM address
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> hi,all,
> I am a newer.I worked on a platform based on MPC8248.
> The 64M SDRAM use CS2,and it's base address is
0x00000000,BR2=0x00000041,OR2=fc002cd0.
> It's just a simple issue,I want to change the base address of the SDRAM
from 0x00000000 to 0x03000000,I thought change the BR2 register to
0x03000041 was ok,but the real thing is that you can read/write the area of
0x03000000 to 0x03ffffff,but the area above the 0x04000000 can not be
written and all be read as 0x0.
> I want to know am I right to change the base address just by change the
BR2?
> Is there some other should be change? Or it may connect with a hardware
change?
>

That base address just won't work right for 64MB.  The target address AND'd
with
the mask in the upper part of the OR must equal the BR.  Typically a 2^n
sized
area must be placed on a 2^n boundary (00xx xxxx, 04xx xxxx, and so on in
your
case)

Mark Chambers
