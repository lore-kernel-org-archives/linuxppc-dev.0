Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5650DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 May 2007 06:38:19 +1000 (EST)
In-Reply-To: <1178915365.9018.44.camel@saruman.qstreams.net>
References: <46434C1E.3020004@cambridgebroadband.com>
	<1178816847.9018.2.camel@saruman.qstreams.net>
	<46443784.3060600@cambridgebroadband.com>
	<1178892748.9018.13.camel@saruman.qstreams.net>
	<C873B42C-ABE7-4265-9EF5-15EBA9525324@kernel.crashing.org>
	<1178915365.9018.44.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D0F806D6-F3C0-4D47-999F-6EAA97C7673C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 83xx: requesting external interrupts
Date: Fri, 11 May 2007 15:37:16 -0500
To: bwarren@qstreams.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 11, 2007, at 3:29 PM, Ben Warren wrote:

> On Fri, 2007-05-11 at 15:15 -0500, Kumar Gala wrote:
>
>>
>> I assume you're code doesn't look exactly like this.  You'll need to
>> use the virq in the request_irq()... its most likely just random luck
>> if things are working and you aren't using the virq returned from
>> irq_create_mapping()
>>
>> (Well its more than random luck, its because most 83xx systems only
>> have one PIC and this hw_irq # == virq)
>>
>> - k
>
> In the code that registers the ISR I do this:
>
> virq = irq_find_mapping(NULL, MY_IRQ);
> request_irq(virq ...)
>
> Since I only have one interrupt controller, host is NULL, right?

Should be ok.  I've been doing the irq_create_mapping() in _init_IRQ 
() and saving off the return.

- k
