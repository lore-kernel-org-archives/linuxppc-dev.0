Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19BC11A001D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 21:06:14 +1100 (AEDT)
Date: Mon, 25 Jan 2016 21:06:09 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [kernel] powerpc: Make vmalloc_to_phys() public
Message-ID: <20160125100609.GA24295@fergus.ozlabs.ibm.com>
References: <1453361708-19422-1-git-send-email-aik@ozlabs.ru>
 <20160125054603.5D55B140326@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160125054603.5D55B140326@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 25, 2016 at 04:46:03PM +1100, Michael Ellerman wrote:
> On Thu, 2016-21-01 at 07:35:08 UTC, Alexey Kardashevskiy wrote:
> > This makes vmalloc_to_phys() public as there will be another user
> > (in-kernel VFIO acceleration) for it soon.
> > 
> > As a part of future little optimization, this changes the helper to call
> > vmalloc_to_pfn() instead of vmalloc_to_page() as the size of the
> > struct page may not be power-of-two aligned which will make gcc use
> > multiply instructions instead of shifts.
> 
> You should also mention why you need to export it, presumably because whatever
> new user you have in mind can be built as a module.

If I remember correctly, it's the *existing* user in hv-24x7.c that
needs the export.

Paul.
