Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D30482C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 10:32:11 +1000 (EST)
Message-ID: <1346805124.2257.10.camel@pasglop>
Subject: Re: [PATCH] powerpc-powernv: added tce_get callback for powernv
 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 05 Sep 2012 10:32:04 +1000
In-Reply-To: <50469A95.7050606@ozlabs.ru>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744158-31190-1-git-send-email-aik@ozlabs.ru>
 <1346787702.3025.7.camel@pasglop> <50469A95.7050606@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-05 at 10:19 +1000, Alexey Kardashevskiy wrote:
> >> +static unsigned long pnv_tce_get(struct iommu_table *tbl, long
> index)
> >> +{
> >> +    return ((u64 *)tbl->it_base)[index - tbl->it_offset] &
> IOMMU_PAGE_MASK;
> >> +}
> >
> > Why the masking here ?
> 
> 
> Oops. No reason. Will remove.

Right. The caller wants to know both whether the low bits are set and
whether there's an address up.

On the H_PUT_TCE path, you want to make sure:

 - If any of the low bit is set, set the TCE entry & get_page()
 - If none, then clear the whole entry (ignore the high bits passed by
the guest) and maybe put_page() the old page

IE the TCE either contains a valid page address + low bit(s) or all 0

That way, on the cleanup path, you can check the low bits only to decide
whether to cleanup, and if any is set, you know both your direction
(writeable vs. read only) and whether something was there at all.

You do not want to ever compare the high bits (address) to 0. While we
never do it in practice I suspect, there's no fundamental reason why a
physical address of 0 is incorrect in a TCE.

Cheers,
Ben.
 
