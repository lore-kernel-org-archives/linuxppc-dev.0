Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E0101A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 13:10:31 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 7 Sep 2015 21:10:29 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id EC8691FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 21:01:35 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8839c4u41418988
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 20:09:38 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t883AP8i031392
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Sep 2015 21:10:26 -0600
Date: Mon, 7 Sep 2015 20:10:24 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@in.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH v2] powerpc/powernv/pci-ioda: fix kdump with
 non-power-of-2 crashkernel=
Message-ID: <20150908031024.GA10404@linux.vnet.ibm.com>
References: <20150904182252.GN47557@linux.vnet.ibm.com>
 <1441617549.8979.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441617549.8979.5.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07.09.2015 [19:19:09 +1000], Michael Ellerman wrote:
> On Fri, 2015-09-04 at 11:22 -0700, Nishanth Aravamudan wrote:
> > The 32-bit TCE table initialization relies on the DMA window having a
> > size equal to a power of 2 (and checks for it explicitly). But
> > crashkernel= has no constraint that requires a power-of-2 be specified.
> > This causes the kdump kernel to fail to boot as none of the PCI devices
> > (including the disk controller) are successfully initialized.
> > 
> > After this change, the PCI devices successfully set up the 32-bit TCE
> > table and kdump succeeds.
> > 
> > Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
> > Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> > Cc: stable@vger.kernel.org # 4.2
> > 
> > Michael, I kept this as a follow-on patch to my previous one. If you'd
> > rather I made a v3 of that patch with the two fixes combined, I can
> > resend.
> 
> No that's fine. I guess they could have been a single fix, but it's
> not a big deal.

Ok, thanks for understanding.

> > Also, I fixed up the context on my end to be u64, but not sure
> > if that will match your tree (next doesn't have my prior patch applied
> > yet, that I can see).
> 
> next isn't open yet, because we're still in the merge window, ie. rc1
> hasn't come out yet.

Ah got it. I did mean your next branch, not linux-next itself, fwiw.

> This is a fix so it'll go to my fixes branch. Whether I send that to
> Linus before or after rc1 depends on how urgent the fixes people send
> me are. Sounds like you'd like these two to go in asap?

If at all possible, yes please.

-Nish
