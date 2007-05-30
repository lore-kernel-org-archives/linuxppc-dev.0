Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 9BC5ADE062
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 01:57:00 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1179530872.32247.423.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d9319311aa8767ba9d50b3f31a52f6e1@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
Date: Wed, 30 May 2007 10:56:45 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Fri, 2007-05-18 at 17:41 +0400, Sergei Shtylyov wrote:
>>     From the "PowerPC Operating Environment Architecture"
>> that I've already quoated it follows that POWER4-compatible
>> decremented exception *must* be edge triggered.
>>
>> says that an exception is generated when the MSB transitions
>> from 0 to 1. It's not clear wether the exception sticks while
>> that bit is 1 or is
>>
>>     Freescale MPC 7450 manual says the same, for example.
>
> I find it extremely silly to implement it as edge anyway. The
> EE line is level triggered, and having a mix of edge and level
> on the same exception without a clean way to retrigger the DEC
> one other than waiting one tick is just causing trouble.

Making it edge triggered means that the operating system gets to
set the max value to 2^32-1 instead of 2^31-1, increasing the
range of the timeouts.

The architecture changed to level sensitive when support for
shared processor lpars was being added so that the hypervisor
didn't have to do dances to avoid pending decrementer
interrupts when changing partitions.

Besides, they aren't the same vector, just the same enable.

Oh, and loading the decrementer with 1 instead of 0 is the
workaround for an errata on at least one supported cpu.

milton
