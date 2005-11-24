Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 4DE196881E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 21:32:54 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jAOAfBTw012732
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 12:41:11 +0200 (EET)
Message-ID: <438594FD.9060002@intracom.gr>
Date: Thu, 24 Nov 2005 12:25:01 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Clement Fabien <Fabien.Clement@thomson.net>
References: <9C1918067C3BC14C9C351C206D8A843701F54B1A@rennsmail03.eu.thmulti.com>
In-Reply-To: <9C1918067C3BC14C9C351C206D8A843701F54B1A@rennsmail03.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [Patch] CPM allocation mechanism in 2.6.13
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Clement Fabien wrote:
> Hello
> 
> I found out that the rh_alloc mechanism used in 2.6.xx does not always
> provide aligned blocks. 
> I'm using a 8275 and try to start the SAR driver of Alex Zeffert.
> 
> Here is a trace of allocations at linux startup of the code that gives
> me problems:
> 
> <...>
> rh_alloc Required size = 8, align = 16
> rh_alloc Block available, blk->size = 00003f40 - Start = 000000c0
> rh_alloc Alloc size = 16, align = 16 - Start = 000000c0
> 
> rh_alloc Required size = 6144, align = 32 
> rh_alloc Block available, blk->size = 00003f30 - Start = 000000d0 
> rh_alloc Alloc size = 6144, align = 32 - Start = 000000d0 
> (!!!! WRONG ALIGNMENT !!!!)
> 
> rh_alloc Required size = 264, align = 64 
> rh_alloc Block available, blk->size = 00002730 - Start = 000018d0
> rh_alloc Alloc size = 320, align = 64 - Start = 000018d0  
> (!!!! WRONG ALIGNMENT !!!!)
> 
> rh_alloc Required size = 64, align = 16
> rh_alloc Block available, blk->size = 000025f0 - Start = 00001a10
> rh_alloc Alloc size = 64, align = 16 - Start = 00001a10
> <...>
> 
> If we observe rh_alloc (arch/ppc/lib/rheap.c) function
> 
> The following line only ensures that there is enough space to perform
> alignment:
> 1.	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
> 
> But with the block start modification mechanism you cannot ensure that
> the next block will be aligned : 
> 2.   	blk->start = (int8_t *)blk->start + size;
> 
> The allocation mechanism must take into account the starting address, as
> it was in Linux 2.4 following code (3. extracted from commproc.c)
> 3.     off = ((p->start_addr + align_mask) & (~align_mask)) -
> p->start_addr;
> 
> I've had an initial discussion with Pantelis who suggests that alignment
> shall be unique for this heap: 
> 
> 
>>>Excuse me, how do you modify the rheap's alignment at runtime?
>>>The allocators prototype is:
> 
> 
>>>void *rh_alloc(rh_info_t * info, int size, const char *owner)
> 
> 
>>>I don't see an alignment parameter.
> 
> 
>>>If you are modifying info->alignment by hand before calling you can't
> 
> 
>>>possibly expect this to work.
> 
> 
>>>The alignment is fixed after the creation of the rheap.
>>>If you need specific alignment you do it like this.
> 
> 
>>>u8 *p = rh_alloc(info, size + (align - 1), "owner");
> 
> 
>>>p = (void *)((unsigned long)p + (align - 1) & ~(align - 1));
> 
> 
> So I guess the problem is in the usage of the function in kernel: it is
> initialized with 1 byte alignment (in cpm2_dpinit in
> arch/ppc/syslib/cpm2_common.c), then the cpm_dpalloc manipulates the
> alignment like this:
> 
> 4.	cpm_dpmem_info.alignment = align;
> 	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
> 
> 
> I do not have an exact idea whether to modify cpm_dpalloc or rh_alloc.
> Can someone provide inputs on this subject?
> 
> Please see also the patch I suggest to correct the rh_alloc function
> 
> Regards
> Fabien Clement
> 

I'm on it.

Regards

Pantelis
