Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id CCE892BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 00:46:25 +1100 (EST)
Message-ID: <1101736699.41ab2afb48566@webmail.televes.com:443>
Date: Mon, 29 Nov 2004 14:58:19 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
References: <1101236780.41a38a2c7f44f@webmail.televes.com:443><2515D492-3D8C-11D9-B8D4-003065F9B7DC@embeddededge.com>
	<1101732712.41ab1b682760f@webmail.televes.com:443>
	<001d01c4d617$0f72f340$0301a8c0@chuck2>
In-Reply-To: <001d01c4d617$0f72f340$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Mark,

I have tried this before and this doesn't work.
Execution flow never arrives to "2:".

All the other values are extra info I have collected.
But problem was isolated using breakpoints to avoid
stepping influence.

Best regards,

Alex

Citando Mark Chambers <markc@mail.com>:


> RFI = Return From Interrupt.  In normal usage the current
> address is copied into SRR0 when an exception occurs so
> the processor will return to that point with an RFI.  So this
> code is 'faking out' the RFI instruction to return to 2:
>
> Are you maybe trying to trace through this code?  If so,
> and depending on your debugger, you may not be able to.
> If your debugger uses trace or some other exception to do
> single step, once you get past mtspr SRR0,r4 the single
> step exception will overwrite the correct SRR0.  You
> can see if this is the case by only tracing to mtspr SRR0,r4
> and then putting a breakpoint at 2:
>
> Good luck,
> Mark Chambers
>
