Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5379FDDE49
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 02:08:51 +1000 (EST)
Message-ID: <4662E7EA.70506@ru.mvista.com>
Date: Sun, 03 Jun 2007 20:10:18 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
In-Reply-To: <1180769992.14025.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:
> On Fri, 2007-06-01 at 23:30 -0500, Milton Miller wrote:
> 
>>Actually, looking back at your device tree {1], your list several
>>properties for flash, including bank-width and partition names.
>>Perhaps first compatible should be direct-mapped-partitioned-flash,
>>direct-mapped-partitioned-rom, direct-mapped-rom  (to me a
>>direct-mapped-rom driver would expose one section of address space
>>read-only). I'm assuming that your driver for this "direct-mapped"
>>device will look at these properties from the of device node and
>>call the mtd layer somewhat directly with their contents. 

> If it's a flash, compatible should be the chip type, and maybe as a
> second entry, what type of flash protocol (amd, intel, cfi, ...) it's
> compatible.

    As I've already (and repatedly) stated before, this gets you *nothing* WRT 
selecting the proper driver in the current Linux MTD subsystem. What it 
actually *needs* to know is flash mapping information, the CFI/JEDEC interface 
then can be deduced by probing -- so, this property ("ptobe-type"), although 
specified in Documentation/powerpc/booting-without-of.txt, is optional.

> Ben.

WBR, Sergei
