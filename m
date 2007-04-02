Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 78ACDDDF07
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Apr 2007 20:57:54 +1000 (EST)
Date: Mon, 2 Apr 2007 14:57:56 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Robert Staven <robert@stopthespam_remove.staven.no>
Subject: Re: Allocating (placing) BufferDescriptors in Dual-Port RAM (CPM2)
Message-ID: <20070402145756.029f5049@vitb.ru.mvista.com>
In-Reply-To: <460EE00B.30007@stopthespam_remove.staven.no>
References: <460EE00B.30007@stopthespam_remove.staven.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 01 Apr 2007 00:26:19 +0200
Robert Staven <robert@stopthespam_remove.staven.no> wrote:

> It's probably basic knowledge, but I still having trouble figure it 
> out.... anyway:
> 
> Working with a SCC in a CPM (MPC8250 running linux 2.6.13-AM)
> 
> I need to place Buffer Descriptors (BD) in the Dual-Port RAM (DPRAM) 
> somewhere....
> But two FCCs, SMC1 and SCC1 are in use, and they might use some part of 
> the DPRAM.
> 
... cpm_dpalloc() will work for you I guess.

> Is there any way to figure out what part of the DPRAM thats free?
> And how to reserve the part I need?
> 
> Robert
> 
> (SCC3 parameter RAM are at 0x8200 in DPRAM so I just place a struct 
> there and assume that linux stays away from this memory area and don't 
> get mad cause I use it without allocating it. Or have I got this wrong to?)
> 

I'd suggest to look at the implemented 8260-like stuff and platform device approach (syslib/pq2_devices.c). Whole immr including DPRAM are is io_block_mapped early by the platform code so
you can do stuff in brackets I guess, but that might look weird and be more complex to debug.

Thanks.

-- 
Sincerely, 
Vitaly
