Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC638DE333
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 06:16:04 +1100 (EST)
Message-Id: <504DF4A9-6ED5-4208-84B4-FECC3FC90C0D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Kernel oops while duming user core.
Date: Thu, 31 Jan 2008 13:15:42 -0600
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE44A5@ismail.innsys.innovsys.com>
	<20080131161527.GT14201@localdomain>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2008, at 10:26 AM, Rune Torgersen wrote:

> Nathan Lynch wrote:
>> Hmm, this is the second report of 2.6.24 crashing in
>> __flush_dcache_icache during a core dump; see:
>> http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048662.html
>>
>> Is this easily recreatable?
>
> Yes. I have a binary that will do this every time it is started (on  
> this
> particular system),
> only takes about 10 seconds before it dumps.
>
> I was going to test HEAD of powerpc.git to see if it is still there.
> I cannot test any earlier versions as our board port was done on  
> 2.6.24.
>
> Our older kernel port is 2.6.18 on arch/ppc, and it works just fine.
>
>
> One potential clue:
>> Unable to handle kernel paging request for data at address 0x48024000
>
> this adddress is beyond our physical memory. We have 1GB of mem
> (CONFIG_HIGH_MEM enabled) so 0x3fff_ffff is the last valid address.
> 0x4000_0000 to 0x7fff_ffff are unused, 0x8000_0000 to 0x9fff_ffff is
> used by PCI.


Can you git-bisect to narrow this down further.

- k
