Return-Path: <dave@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C0F0B709C
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 04:33:35 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6GIJBMr025308
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 14:19:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6GIXXJX1929348
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 14:33:33 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6GIXWqU004375
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jul 2010 15:33:32 -0300
Subject: Re: [PATCH 1/5] v2 Split the memory_block structure
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4C40A3BC.3060504@austin.ibm.com>
References: <4C3F53D1.3090001@austin.ibm.com>
	<4C3F557F.3000304@austin.ibm.com> <1279300521.9207.222.camel@nimitz>
	<4C40A3BC.3060504@austin.ibm.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Fri, 16 Jul 2010 11:33:30 -0700
Message-ID: <1279305210.9207.250.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-16 at 13:23 -0500, Nathan Fontenot wrote:
> > If the memory_block's state was inferred to be the same as each
> > memory_block_section, couldn't we just keep a start and end phys_index
> > in the memory_block, and get away from having memory_block_sections at
> > all?
> 
> Oooohhh... I like.  Looking at the code it appears this is possible.  I'll
> try this out and include it in the next version of the patch.
> 
> Do you think we need to add an additional file to each memory block directory
> to indicate the number of memory sections in the memory block that are actually
> present? 

I think it's easiest to just say that each 'memory_block' can only hold
contiguous 'memory_block_sections', and we give either the start/end or
start/length pairs.  It gets a lot more complicated if we have to deal
with lots of holes.

I can just see the hardware designers reading this thread, with their
Dr. Evil laughs trying to come up with a reason to give us a couple of
terabytes of RAM with only every-other 16MB area populated. :)  

-- Dave
