Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id E0F822BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 23:56:13 +1100 (EST)
Message-ID: <1101820104.41ac70c86a847@webmail.televes.com:443>
Date: Tue, 30 Nov 2004 14:08:24 +0100
From: alebas@televes.com
To: Mark Chambers <markc@mail.com>
References: <1101236780.41a38a2c7f44f@webmail.televes.com:443><2515D492-3D8C-11D9-B8D4-003065F9B7DC@embeddededge.com>
	<1101732712.41ab1b682760f@webmail.televes.com:443>
	<001d01c4d617$0f72f340$0301a8c0@chuck2>
	<1101736520.41ab2a48a710a@webmail.televes.com:443>
	<006b01c4d61e$707f2440$0301a8c0@chuck2>
In-Reply-To: <006b01c4d61e$707f2440$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel 2.6.10-rc1 yet not running on ads8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan,

I have finally found what I was doing wrong.
Checking mem as you suggested I found that
the breakpoint I was setting to virtual
address 0xc00035f8 has to be set to physical
0x000035f8, otherwise it doesn't stop.

So problem was here with BDI2000 debugging,
MMU and me. Sorry about my misknowledge.

Nevertheless kernel is still hanging.
Now I have continued debugging and I have
arrived to start_kernel ... and go on till
do_basic_setup. But still seeing nothing in
the serial console before kernel hanging.

I think I have some problem with serial
console I have to solve before going on.

Thanks

Alex

Citando Mark Chambers <markc@mail.com>:

> So it's not the simple stuff.  Never is.
>
> I probably shouldn't jump in here, I'm over my head,
> but in the spirit of brainstorming:  Is there any chance
> the bl load_up_mmu instruction isn't in memory at
> physical address 35f8?  It looks like this code is
> bouncing back to physical addressing after having
> the mmu enabled - maybe look at physical
> memory at 35f8 and see if there's a problem?
>
> Mark
>
