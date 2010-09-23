Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 2EA0BB70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 06:34:14 +1000 (EST)
Received: from mail182-tx2 (localhost.localdomain [127.0.0.1])	by
	mail182-tx2-R.bigfish.com (Postfix) with ESMTP id A306A11886DC	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 23 Sep 2010 20:34:03 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.244])	by
	mail182-tx2.bigfish.com (Postfix) with ESMTP id 49A7513A804F	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 23 Sep 2010 20:34:03 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8NKXn52019124	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Sep 2010 13:33:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8NKXtYe012195	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Sep 2010 15:33:55 -0500 (CDT)
Date: Thu, 23 Sep 2010 15:33:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] powerpc: Fix invalid page flags in create TLB CAM path
	for PTE_64BIT
Message-ID: <20100923153347.4b517105@udp111988uds.am.freescale.net>
In-Reply-To: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
References: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Sep 2010 16:10:15 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> So the possibility exists to wrongly assign the user MAS3_U<RWX> bits
> to kernel (PAGE_KERNEL_X) address space via the following code fragment:
> 
>         if (flags & _PAGE_USER) {
>            TLBCAM[index].MAS3 |= MAS3_UX | MAS3_UR;
>            TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_UW : 0);
>         }
> 
> Here is a dump of the TLB info from Simics with the above code present:
> ------
> L2 TLB1
>                                             GT                   SSS UUU V I
>  Row  Logical           Physical            SS TLPID  TID  WIMGE XWR XWR F P   V
> ----- ----------------- ------------------- -- ----- ----- ----- --- --- - -   -
>   0   c0000000-cfffffff 000000000-00fffffff 00     0     0   M   XWR XWR 0 1   1
>   1   d0000000-dfffffff 010000000-01fffffff 00     0     0   M   XWR XWR 0 1   1
>   2   e0000000-efffffff 020000000-02fffffff 00     0     0   M   XWR XWR 0 1   1
> 
> Actually this conditional code was only used for two legacy functions:
> 
>   1: support KGDB to set break point.
>      KGDB already dropped this; now uses its core write to set break point.
> 
>   2: io_block_mapping() to create TLB in segmentation size (not PAGE_SIZE)
>      for device IO space.
>      This use case is also removed from the latest PowerPC kernel.

io_block_mapping() went away, but the feature itself is still useful
and might come back with something like this:

http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg33851.html

...though I'm not sure why such mappings would ever have user access.

This could end up being used for large user pages by something like
hugetlbfs or KVM, though.  I don't think we want to make large user
pages fail, especailly if it just happens with the 32-bit page table
format (which i may not what the person adding such a feature tests
with).

I don't see a generic accessor that can test PTE flags for user
access -- in the absence of one, I guess we need an ifdef here.  Or at
least put in a comment so anyone who adds a userspace use knows they
need to fix it.

-Scott
