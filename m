Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id 47149B70D5
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2010 01:44:17 +1100 (EST)
Message-ID: <4CEBD33D.7020603@mlbassoc.com>
Date: Tue, 23 Nov 2010 07:44:13 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Change in PCI behaviour
References: <4CE69AF6.6090408@mlbassoc.com>	
	<1290203218.32570.48.camel@pasglop>
	<4CE95E11.1050606@mlbassoc.com>	 <4CEA3F87.9080102@mlbassoc.com>
	<1290457615.32570.67.camel@pasglop>
In-Reply-To: <1290457615.32570.67.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/22/2010 01:26 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2010-11-22 at 03:01 -0700, Gary Thomas wrote:
>> I have a bit more information on this.  I'm pretty sure that the failures
>> are only happening in my SCSI (SATA actually) code.  My board (8347ea) has
>> a PCI bus with a SIL SATA controller.  This combo works perfectly in 2.6.28.
>> In 2.6.32, it will run for a while (possibly quite a while), then timeout
>> trying to do a large block write - typically 256 blocks.  Once this timeout
>> happens, the SIL controller is stuck and accesses to it will eventually
>> cause the whole system to hang (as above).
>>
>> Was there any major change in how PCI or DMA was handled between 2.6.28
>> and 2.6.32?  Given the ephemeral nature of these failures (multiple runs
>> all eventually fail, but never the same twice), my only hope of fixing it
>> will be to have some ideas what might have changed.
>
> Maybe the changes you did to the PCI outbound windows are now breaking
> DMA ? Make sure the outbound and inbound don't overlap for example and
> that all RAM is reachable for inbound.

Here's what I did to work around this - in my DTS, I set up my PCI as
	ranges = <0x02000000 0x0 0xC4000000 0xC4000000 0x0 0x1C000000
	          0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;
Before, I had it as
	ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x20000000
	          0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;

I wasn't sure how to reserve the memory (based on your earlier suggestion),
so I just narrowed the window.  Note that I did not change the PCI hardware
registers (maybe the FSL code does?), so the outbound window should still
be the whole 512MB.

If this isn't viable, perhaps you could explain a bit more how to reserve
such a chunk of memory so that the PCI mappings remain the same.

Thanks again

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
