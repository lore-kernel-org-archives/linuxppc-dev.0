Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27A7967B32
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 01:28:25 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7EFSHdC013650
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 11:28:17 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7EFSHkm208778
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 11:28:17 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7EFSHKX020030
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 11:28:17 -0400
Subject: Re: [PATCH] kprobes/powerpc: Fix possible system crash during
	out-of-line single-stepping
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: ananth@in.ibm.com
In-Reply-To: <20060811113134.GA24462@in.ibm.com>
References: <20060811113134.GA24462@in.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 10:27:59 -0500
Message-Id: <1155569280.5160.19.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, willschm@us.ibm.com,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-11-08 at 17:01 +0530, Ananth N Mavinakayanahalli wrote:
> - On archs that have no-exec support, we vmalloc() a executable scratch
> area of PAGE_SIZE and divide it up into an array of slots of maximum
> instruction size for that arch
> - On a kprobe registration, the original instruction is copied to the
> first available free slot, so if multiple kprobes are registered, chances
> are, they get contiguous slots
> - On POWER4, due to not having coherent icaches, we could hit a situation
> where a probe that is registered on one processor, is hit immediately on
> another. This second processor could have fetched the stream of text from
> the out-of-line single-stepping area *before* the probe registration
> completed, possibly due to an earlier (and a different) kprobe hit and
> hence would see stale data at the slot.
> 
> Executing such an arbitrary instruction lead to a problem as reported
> in LTC bugzilla 23555.
> 
> The correct solution is to call flush_icache_range() as soon as the
> instruction is copied for out-of-line single-stepping, so the correct
> instruction is seen on all processors.
> 
> Thanks to Will Schmidt who tracked this down.
> 
> Ananth
> ---
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>

-Will
