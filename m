Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0AC5CB7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 07:14:23 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C256DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 07:14:21 +1000 (EST)
Message-ID: <4A4D2332.1060607@freescale.com>
Date: Thu, 02 Jul 2009 16:14:26 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Aaron Pace <kodiakuppercut@gmail.com>
Subject: Re: Non-contiguous physical memory on 8572
References: <bc81dc640907021311y1395ed15l2d50cebb3749c29f@mail.gmail.com>
In-Reply-To: <bc81dc640907021311y1395ed15l2d50cebb3749c29f@mail.gmail.com>
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

Aaron Pace wrote:
> In MMU_init of arch/powerpc/mm/init_32.c, where the current code sets
> lmb.memory.cnt to zero, I instead walk through the memory regions and
> call lmb_reserve for each chunk of memory that lies in a 'hole'.
> There are then some minor fixups to make sure that total_memory and
> total_highmem get the right numbers.  This small change allows all
> four gigabytes of memory to be accessed and used in my tests.
> 
> Am I missing something obvious?

The main downsides that I see are wasted memory for bookkeeping of the 
hole (how acceptable this is depends on how large the hole is relative 
to the size of RAM -- it's a tradeoff against speed of looking up page 
structs), and that the reserved area may still be mapped in the TLB 
without the guarded bit set.

-Scott
