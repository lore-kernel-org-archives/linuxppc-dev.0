Return-Path: <ankita@in.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C71C01007DA
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:08:13 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id o8GC88dq023210
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 17:38:08 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8GC88Me4116486
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 17:38:08 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8GC87KM003514
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:08:08 +1000
Date: Thu, 16 Sep 2010 17:38:06 +0530
From: Ankita Garg <ankita@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Reserved pages in PowerPC
Message-ID: <20100916120806.GJ2332@in.ibm.com>
References: <20100916052311.GC2332@in.ibm.com>
	<1284631464.30449.85.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284631464.30449.85.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org
Reply-To: Ankita Garg <ankita@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Thu, Sep 16, 2010 at 08:04:24PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2010-09-16 at 10:53 +0530, Ankita Garg wrote:
> > 
> > With some debugging I found that that section has reserved pages. On
> > instrumenting the memblock_reserve() and reserve_bootmem() routines, I can see
> > that many of the memory areas are reserved for kernel and initrd by the
> > memblock reserve() itself. reserve_bootmem then looks at the pages already
> > reserved and marks them reserved. However, for the very last section, I see
> > that bootmem reserves it but I am unable to find a corresponding reservation
> > by the memblock code.
> 
> It's probably RTAS (firmware runtime services). I'ts instanciated at
> boot from prom_init and we do favor high addresses for it below 1G iirc.
>

Thanks Ben for taking a look at this. So I checked the rtas messages on
the serial console and see the following:

instantiating rtas at 0x000000000f632000... done

Which does not correspond to the higher addresses that I see as reserved
(observation on a 16G machine).

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs,
Bangalore, India
