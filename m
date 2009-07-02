Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D8814B70DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 07:05:11 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 476FBDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 07:05:10 +1000 (EST)
Message-Id: <44A414B6-1CA7-4209-B934-4970CD62CA49@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Aaron Pace <kodiakuppercut@gmail.com>
In-Reply-To: <bc81dc640907021311y1395ed15l2d50cebb3749c29f@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: Non-contiguous physical memory on 8572
Date: Thu, 2 Jul 2009 16:05:04 -0500
References: <bc81dc640907021311y1395ed15l2d50cebb3749c29f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 2, 2009, at 3:11 PM, Aaron Pace wrote:

> Hello,
>
> I wrote to this list quite some time ago concerning a board that has 2
> gigs of ram mapped in at 0x0.0000.0000 - 0x0.7fff.ffff, and a second 2
> gigs of ram at 0x1.0000.0000 - 0x1.7fff.ffff.  Kumar responded and
> mentioned that this wasn't currently supported in the powerpc
> architecture.  I've had this on my 'curiosity' back burner to take a
> look at for some time.
> I found a little time to look at this, and what I discovered is that
> this seems to actually have been a fairly trivial problem to solve.
> I'd like to get some feedback on the method I used, if possible, to
> see if I've overlooked something blatantly obvious.
>
> In MMU_init of arch/powerpc/mm/init_32.c, where the current code sets
> lmb.memory.cnt to zero, I instead walk through the memory regions and
> call lmb_reserve for each chunk of memory that lies in a 'hole'.
> There are then some minor fixups to make sure that total_memory and
> total_highmem get the right numbers.  This small change allows all
> four gigabytes of memory to be accessed and used in my tests.
>
> Am I missing something obvious?
> Would you like this in a patch for 32 or next, or is there a reason
> that this would not be desirable in the powerpc branch?

What you described is one possible solution.  However when I was  
thinking about support non-contiguous memory I was thinking about  
doing at based on CONFIG_DISCONTIGMEM (see include/asm-generic/ 
memory_model.h).  I think ppc64 supports SPARSEMEM which is a  
variation on the them.

- k
