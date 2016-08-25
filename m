Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKkHt2mKszDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 22:38:50 +1000 (AEST)
Date: Thu, 25 Aug 2016 22:38:34 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, michael@ellerman.id.au
Subject: Re: [RFCv3 00/17] PAPR HPT resizing, guest & host side
Message-ID: <20160825123834.GB4815@fergus.ozlabs.ibm.com>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 21, 2016 at 02:53:07PM +1100, David Gibson wrote:
> This is an implementation of the kernel parts of the PAPR hashed page
> table (HPT) resizing extension.
> 
> It contains a complete guest-side implementation - or as complete as
> it can be until we have a final PAPR change.
> 
> It also contains a draft host side implementation for KVM HV (the KVM
> PR and TCG host-side implementations live in qemu).  This works, but
> is very slow in the critical section (where the guest must be
> stopped).  It is significantly slower than the TCG/PR implementation;
> unusably slow for large hash tables (~2.8s for a 1G HPT).
> 
> I'm still looking into what's the cause of the slowness, and I'm not
> sure yet if the current approach can be tweaked to be fast enough, or
> if it will require a new approach.

I have finally managed to have a close look at this series.  The
approach and implementation seem basically sane, though I think the
rehash function could be optimized a bit.  I also have an optimized
implementation of hpte_page_size() and hpte_base_page_size() which
should be a lot quicker than the 2d linear (areal?) search which we do
at present.

Paul.
