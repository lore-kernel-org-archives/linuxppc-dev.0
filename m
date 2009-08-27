Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0D795B7B7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 02:33:39 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 753FEDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 02:33:37 +1000 (EST)
Message-ID: <4A96B579.3030907@freescale.com>
Date: Thu, 27 Aug 2009 11:34:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: Can't write value into memory ?(E500 V2)
References: <e997b7420908260739u49fb4b36j9eb148782829547b@mail.gmail.com>	
	<20090826192030.GA17027@b07421-ec1.am.freescale.net>	
	<e997b7420908270853i7d4058e1p8ddcfcf8df18486e@mail.gmail.com>	
	<4A96AD4B.1010204@freescale.com>
	<e997b7420908270927m1ec1dbcbq51781e3b1e4db061@mail.gmail.com>
In-Reply-To: <e997b7420908270927m1ec1dbcbq51781e3b1e4db061@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wilbur.chan wrote:
> 2009/8/27 Scott Wood <scottwood@freescale.com>:
>> Is this under Linux (it is a Linux mailing list...)?  If so, there are
>> better ways of communicating that don't involve clobbering random memory and
>> overlapping userspace TLB mappings.
> 
> Yes, I'm doing this under linux in kernel mode.
> 
> I've used interrupt between cores, to make:
> 
> 1) cpu0  carrys some data to a place (As a matter of fact ,the 'data'
> is a kernel, the 'place' is at 0, and  I'm using kexec..)
> 
> 2) cpu0 writes a 'flag' to a physical address(16M), to indicate that ,
> 
> it has finished the carrying in step 1. And jump to new kernel directly.

OK, so it's not really "under Linux" but "between Linuxes". :-)

Don't forget to clean the cache out on the destination core -- icache is 
not coherent with dcache.

> 3) cpu1 enters the loop by IRQ , checking the 'flag' from time to
> time. If the 'flag' is true, it
> 
> breaks the  loop and jumps to the instruction in new kernel.
> 
> 
>> Do both cores have a mapping with the M bit (memory coherence required) set?
> 
> 
> What do you mean by  M bit set?

There is a bit in MAS2, labelled "M", that you must set when writing the 
TLB entry for the mapping to be coherent across cores.

-Scott
