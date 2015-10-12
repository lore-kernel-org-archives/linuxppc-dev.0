Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5698C1A05AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 14:17:10 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F9131402A1
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 14:17:09 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 12 Oct 2015 08:47:05 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id AEC4D394005A
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 08:47:01 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9C3H06Z61210736
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 08:47:00 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9C3GxJB007709
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 08:47:00 +0530
Date: Mon, 12 Oct 2015 11:16:58 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 "gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
 "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH V5 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
Message-ID: <20151012031658.GB2111@Richards-MacBook-Pro.local>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444358816-8163-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444378519.2845.14.camel@kernel.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6D1CBB0E91@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBB0E91@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 09:02:16AM +0000, David Laight wrote:
>From: Benjamin Herrenschmidt
>> Sent: 09 October 2015 09:15
>> On Fri, 2015-10-09 at 10:46 +0800, Wei Yang wrote:
>> > On PHB_IODA2, we enable SRIOV devices by mapping IOV BAR with M64 BARs. If
>> > a SRIOV device's IOV BAR is not 64bit-prefetchable, this is not assigned
>> > from 64bit prefetchable window, which means M64 BAR can't work on it.
>> 
>> Won't this cause a lot of devices to become unsupported for us ? Or do
>> all devices we care about have their BARs marked prefetchable ?
>> 
>> > The reason is PCI bridges support only 2 windows and the kernel code
>> > programs bridges in the way that one window is 32bit-nonprefetchable and
>> > the other one is 64bit-prefetchable. So if devices' IOV BAR is 64bit and
>> > non-prefetchable, it will be mapped into 32bit space and therefore M64
>> > cannot be used for it.
>> >
>> > This patch makes this explicit.
>> 
>> So PCIe allows for non-prefetchable BARs to be put under prefetchable
>> bridge windows as long as the mapping done by the CPU doesn't prefetch,
>> I believe. Well it's a natural conclusion of the weird note "Additional
>> Guidance on the Prefetchable Bit in Memory Space BARs" page 596 of PCIe
>> spec v3.0... it also says that devices should be pretty much free to
>> set their prefetchable bit even if they have side effects so.
>> 
>> So maybe we should have that option, rather than just not using the
>> devices, allow them to be allocate via the prefetchable window...
>
>I'm trying to understand some of this for other reasons...
>(Mostly because NetBSD doesn't allow PCIe addresses above 4G.)

I guess here means the pci root bridge's windows are all below 4G?

>
>AFAICT there are two options '32bit' and '64bit prefetchable'.
>

For a pci bridge, the bridge window could be:
1. 32bit non-prefetchable and 32bit prefetchable
2. 32bit non-prefetchable and 64bit prefetchable

>I presume the latter allows addresses above 4G (although I've
>not looked closely enough to see how that gets written into the BAR).
>

Allow, and also could below 4G.

>That seems problematic on architectures like x86 where the bios
>initialises the BARs but doesn't (usually) know whether the OS
>will be 32 or 64bit.
>

I didn't get the point.

Usually when bios handle the MMIO assignment, kernel will mostly leave it
alone, as I know.

>Whether the cpu maps the addresses prefetchable ought to depend
>on the way the driver maps the area - since it is the driver
>that knows whether prefetching is sensible.
>
>	David
>
>

-- 
Richard Yang
Help you, Help me
