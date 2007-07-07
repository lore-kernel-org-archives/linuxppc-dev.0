Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 95FB1DE1A8
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 03:05:25 +1000 (EST)
Message-ID: <468FC849.20801@ru.mvista.com>
Date: Sat, 07 Jul 2007 21:07:21 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Handle reg-shift property for of_serial ports
References: <1183784308.3066.16.camel@shinybook.infradead.org>	<200707071410.14998.arnd@arndb.de>
	<1183827083.3066.64.camel@shinybook.infradead.org>
In-Reply-To: <1183827083.3066.64.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

David Woodhouse wrote:

>>Given the existence of the boards, it looks correct to do this.
>>However, I wonder if it was correct for the MV64660 to claim
>>compatibily witn ns16550 if the programming model is not exactly
>>the same. The official OF serial port bindings don't mention the
>>reg-shift property, so it maybe would have been better to have

   I'd preferred "reg-stride" or "reg-size" but see below...

>>a different value for the "compatible" property, in order not
>>to confuse existing operating systems that implement the standard. 

> Ok, how about 'sparse16550'? Otherwise identical to ns16550, but with

    Erm, wouldn't it be *too* generic approach?  I'd suggest to name the 
device with its own name and make of_serial.c recognize it and register with 
8250.c as needed.

> the reg-shift property. I'll send a patch shortly, and I'll reorder the
> match table -- if something claims compatibility with both 8250 and
> 16550, shouldn't we drive it as the latter?

    Certainly. BTW, was there really "ns8250" -- 8250 is Intel's chip?

WBR, Sergei
