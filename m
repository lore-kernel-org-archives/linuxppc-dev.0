Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6AF45B6F7E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2011 08:06:51 +1000 (EST)
Message-ID: <4E824904.2040208@embedded-sol.com>
Date: Wed, 28 Sep 2011 01:07:00 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Handling multiple GPIO controllers in 8xxx GPIO driver
References: <4E81D6C0.3010201@embedded-sol.com>
	<20110927182912.GA3994@ponder.secretlab.ca>
In-Reply-To: <20110927182912.GA3994@ponder.secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On 09/27/2011 09:29 PM, Grant Likely wrote:
> On Tue, Sep 27, 2011 at 04:59:28PM +0300, Felix Radensky wrote:
>> Hi,
>>
>> Looks like  8xxx GPIO driver cannot properly handle interrupts
>> when multiple GPIO controllers exist in the system.
>>
>> On Freescale P1022 there are 3 GPIO controllers. All 3 use
>> the same interrupt line, internal interrupt 31. If all controllers
>> are defined in device tree set_irq_chained_handler() is invoked
>> 3 times with same  hardware irq number. The result is interrupt
>> storm,  mpc8xxx_gpio_irq_cascade() is invoked indefinitely.
>>
>> What would be the best way to fix the problem ?
> The solution is to make the gpio driver register as a regular
> interrupt handler, and not as a chained handler.
>
> g.
>

You mean interrupt handler per GPIO pin ?

Felix.
