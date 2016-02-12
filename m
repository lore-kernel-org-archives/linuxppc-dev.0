Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80C4D1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 16:53:02 +1100 (AEDT)
Date: Fri, 12 Feb 2016 16:52:58 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 6/6] KVM: PPC: Add support for multiple-TCE
 hcalls
Message-ID: <20160212055258.GA6219@fergus.ozlabs.ibm.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-7-git-send-email-aik@ozlabs.ru>
 <20160211053206.GD9757@oak.ozlabs.ibm.com>
 <56BD657A.1020203@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56BD657A.1020203@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 12, 2016 at 03:54:18PM +1100, Alexey Kardashevskiy wrote:
> On 02/11/2016 04:32 PM, Paul Mackerras wrote:
> >On Thu, Jan 21, 2016 at 06:39:37PM +1100, Alexey Kardashevskiy wrote:
> >>+	rmap = (void *) vmalloc_to_phys(rmap);
> >>+
> >>+	lock_rmap(rmap);
> >
> >A comment here explaining why we lock the rmap and what that achieves
> >would be useful for future generations.
> 
> 
> /* This protects the guest page with the TCE list from going away while we
> are reading TCE list */
> 
> ?
> 
> By "going away" I mean H_ENTER/H_REMOVE executed on parallel CPUs, is this
> roughly correct? as I did grep for "lock_rmap()" and did not find a single
> comment next to it...

Actually, taking the rmap lock stops the guest real -> host real
mapping from changing.  For the comment, I suggest this:

	/*
	 * Synchronize with the MMU notifier callbacks in
	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
	 * While we have the rmap lock, code running on other CPUs
	 * cannot finish unmapping the host real page that backs
	 * this guest real page, so we are OK to access the host
	 * real page.
	 */

Paul.
