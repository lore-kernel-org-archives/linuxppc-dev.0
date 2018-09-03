Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423dTJ4Pp2zF38m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 15:15:32 +1000 (AEST)
Date: Mon, 3 Sep 2018 15:15:29 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel] KVM: PPC: Avoid mapping compound pages to TCEs in
 real mode
Message-ID: <20180903051529.GA7848@fergus>
References: <20180831060850.33010-1-aik@ozlabs.ru>
 <20180903032844.GD2679@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180903032844.GD2679@umbus.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 03, 2018 at 01:28:44PM +1000, David Gibson wrote:
> On Fri, Aug 31, 2018 at 04:08:50PM +1000, Alexey Kardashevskiy wrote:
> > At the moment the real mode handler of H_PUT_TCE calls iommu_tce_xchg_rm()
> > which in turn reads the old TCE and if it was a valid entry - marks
> > the physical page dirty if it was mapped for writing. Since it is
> > the real mode, realmode_pfn_to_page() is used instead of pfn_to_page()
> > to get the page struct. However SetPageDirty() itself reads the compound
> > page head and returns a virtual address for the head page struct and
> > setting dirty bit for that kills the system.
> > 
> > This moves dirty bit setting before updating the hardware table
> 
> Um.. but now you're setting DIRTY based on the *new* TCE's
> permissions, instead of the old TCE's permissions, which I don't think
> is correct.

He's setting dirty on the page which is about to be mapped if the new
TCE allows the page to be written by the device.  Given that the page
is pinned, I don't see any reason why the dirty setting has to be done
when the page is unmapped rather than when it is mapped.  Do you see a
reason?

Paul.
