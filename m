Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 6E955DDEE2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 05:42:01 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LD1LJ-00041y-UE
	for linuxppc-dev@ozlabs.org; Wed, 17 Dec 2008 10:41:57 -0800
Message-ID: <21058850.post@talk.nabble.com>
Date: Wed, 17 Dec 2008 10:41:57 -0800 (PST)
From: bterrell <bterrell@empirix.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8572 - IPR Register
In-Reply-To: <40363DF0-BC55-4872-AF73-1ED0B24F6224@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <BD261180E6D35F4D9D32F3E44FD3D9010F59452A@EMPBEDEX.empirix.com>
	<A7BF6E08-786A-4D00-BBEA-1568939722E9@kernel.crashing.org>
	<21042870.post@talk.nabble.com>
	<40363DF0-BC55-4872-AF73-1ED0B24F6224@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>





On Dec 16, 2008, at 4:08 PM, bterrell wrote:

>
>
> Kumar Gala-3 wrote:
>>
>>
>> <1. Which PCIe port is the device on?
>> 2. is this a INT-X style or MSI interrupt?
>> 3. if INT-X is INT-A, B, C, D?

1. Non-transparent bridge device is on port 1 of the PLX8616 switch, which
is connected to first PCIE controller.
2. Using INTx style interrupts.
3. NT device asserts INTA, but this is swizzled by the upstream port of the
switch to be INTB before sending to 8572.

The problem also occurs when a hot-reset is sent inband from the PCIE
controller on 8572.  I see the following differences in 8572 PCIE registers
in configuration space before/after the "hot reset" is sent:

PEX Config Space Register 0x414: before 0x00000000 after 0x000000001 <==
undocumented reg??

PEX Config Space Register 0x43C: before 0x00C2DC76 after 0x00013014 <==
undocumented reg??

PEX Config Space Register 0x4E8: before 0x00004D4D after 0x00000101 <==
undocumented reg??

Any idea what these registers are?

thanks,
Bill Terrell
Empirix, Inc.


-- 
View this message in context: http://www.nabble.com/MPC8572---IPR-Register-tp21040440p21058850.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
