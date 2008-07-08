Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 89E64DE34C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 00:54:14 +1000 (EST)
Message-ID: <48737D55.9000905@nortel.com>
Date: Tue, 08 Jul 2008 08:44:37 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Paolo Doz <paolo.doz@gmail.com>
Subject: Re: While(1) in kernel space
References: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
In-Reply-To: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paolo Doz wrote:
> Hi folks,
> I'm developing a custom SPI driver (char device) on a MPC5200b, the 
> microcontroller linked as slave implements a protocol that must follow 
> strict timing constraints. I need to receive and send messages every 
> 6msec.

What are your timing requirements?  How much over/under 6ms can the 
protocol handle?

Kernel threads might work, but then you're at the mercy of the 
scheduler.  You'd probably be better off using a timer or softirq.

If the latency requirements are really strict, your best bet would 
probably be to use the -rt patches for the kernel.  That requires 
building a custom kernel though.

Chris
