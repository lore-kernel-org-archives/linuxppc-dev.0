Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 154361007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 03:50:47 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Fix SMP when "cpu-release-addr" is in lowmem
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1264112935.31570.361.camel@localhost.localdomain>
Date: Mon, 25 Jan 2010 10:50:42 -0600
Message-Id: <512B1A06-4F10-45C8-8760-2F4EE98E6D84@freescale.com>
References: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
	<1264112935.31570.361.camel@localhost.localdomain>
To: Peter Tyser <ptyser@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 21, 2010, at 4:28 PM, Peter Tyser wrote:

> On Fri, 2009-12-18 at 16:50 -0600, Peter Tyser wrote:
>> Recent U-Boot commit 5ccd29c3679b3669b0bde5c501c1aa0f325a7acb caused
>> the "cpu-release-addr" device tree property to contain the physical RAM
>> location that secondary cores were spinning at.  Previously, the
>> "cpu-release-addr" property contained a value referencing the boot page
>> translation address range of 0xfffffxxx, which then indirectly accessed
>> RAM.
>> 
>> The "cpu-release-addr" is currently ioremapped and the secondary cores
>> kicked.  However, due to the recent change in "cpu-release-addr", it
>> sometimes points to a memory location in low memory that cannot be
>> ioremapped.  For example on a P2020-based board with 512MB of RAM the
>> following error occurs on bootup:
>> 
>>  <...>
>>  mpic: requesting IPIs ...
>>  __ioremap(): phys addr 0x1ffff000 is RAM lr c05df9a0
>>  Unable to handle kernel paging request for data at address 0x00000014
>>  Faulting instruction address: 0xc05df9b0
>>  Oops: Kernel access of bad area, sig: 11 [#1]
>>  SMP NR_CPUS=2 P2020 RDB
>>  Modules linked in:
>>  <... eventual kernel panic>
>> 
>> Adding logic to conditionally ioremap or access memory directly resolves
>> the issue.
>> 
>> Signed-off-by: Peter Tyser <ptyser@xes-inc.com>
>> Signed-off-by: Nate Case <ncase@xes-inc.com>
>> Reported-by: Dipen Dudhat <B09055@freescale.com>
>> Tested-by: Dipen Dudhat <B09055@freescale.com>
> 
> Any chance this going to be picked up for 2.6.33?  The issue is
> currently going to bite anyone using an MP-capable 85xx system that
> doesn't use highmem.

This just got lost in my queue.  Will apply and send up for .33

- k
