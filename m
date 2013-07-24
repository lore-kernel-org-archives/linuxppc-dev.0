Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 555EA2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 09:14:14 +1000 (EST)
Message-ID: <1374707624.6142.16.camel@pasglop>
Subject: Re: [PATCH 04/10] powerpc: Prepare to support kernel handling of
 IOMMU map/unmap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 25 Jul 2013 09:13:44 +1000
In-Reply-To: <20130724154301.2af75867c51870fc0c32819b@linux-foundation.org>
References: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
 <1373936045-22653-5-git-send-email-aik@ozlabs.ru>
 <51EDE903.6010608@ozlabs.ru>
 <20130724154301.2af75867c51870fc0c32819b@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Mel Gorman <mgorman@suse.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-24 at 15:43 -0700, Andrew Morton wrote:
> For what?  The three lines of comment in page-flags.h?   ack :)
> 
> Manipulating page->_count directly is considered poor form.  Don't
> blame us if we break your code ;)
> 
> Actually, the manipulation in realmode_get_page() duplicates the
> existing get_page_unless_zero() and the one in realmode_put_page()
> could perhaps be placed in mm.h with a suitable name and some
> documentation.  That would improve your form and might protect the code
> from getting broken later on.

Yes, this stuff makes me really nervous :-) If it didn't provide an order
of magnitude performance improvement in KVM I would avoid it but heh...

Alexey, I like having that stuff in generic code.

However the meaning of the words "real mode" can be ambiguous accross
architectures, it might be best to then name it "mmu_off_put_page" to
make things a bit clearer, along with a comment explaining that this is
called in a context where none of the virtual mappings are accessible
(vmalloc, vmemmap, IOs, ...), and that in the case of sparsemem vmemmap
the caller must have taken care of getting the physical address of the
struct page and of ensuring it isn't split accross two vmemmap blocks.

Cheers,
Ben.
