Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXTvS6bwLzDsFG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 10:58:28 +1000 (AEST)
Date: Mon, 12 Sep 2016 10:58:25 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] powerpc/mm: Speed up computation of base and
 actual page size for a HPTE
Message-ID: <20160912005825.GF9873@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
 <20160907061709.GD21443@fergus.ozlabs.ibm.com>
 <20160908100836.GA4965@fergus.ozlabs.ibm.com>
 <4ba4f3d7-eadc-5d20-534e-afc7075938fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ba4f3d7-eadc-5d20-534e-afc7075938fc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 08, 2016 at 12:16:00PM +0200, Paolo Bonzini wrote:
> 
> 
> On 08/09/2016 12:08, Paul Mackerras wrote:
> >> > 
> >> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 37 ++++++++++++
> >> >  arch/powerpc/include/asm/kvm_book3s_64.h      | 87 +++------------------------
> >> >  arch/powerpc/include/asm/mmu.h                |  1 +
> >> >  arch/powerpc/mm/hash_native_64.c              | 42 +------------
> >> >  arch/powerpc/mm/hash_utils_64.c               | 55 +++++++++++++++++
> > This of course touches two maintainers' areas.  Michael and Paolo, how
> > do you want to proceed here?  Can this just go through Michael's tree?
> > Or should I make a topic branch off Linus' tree that you can both
> > pull, or should I split the patch into two (i.e. everything except the
> > kvm_book3s_64.h change in the first patch, and the kvm_book3s_64.h
> > change in the second) and get Michael to put the first one in a topic
> > branch that I can then pull and apply the second patch onto?
> 
> This patch seems separate from the other two (I can't really tell since
> there wasn't a cover letter on linuxppc-dev).  Can you place it in a
> pull request for both Michael and myself?

Yes, it is separate.  I have put it in a new kvm-ppc-infrastructure
branch, which I have merged into my kvm-ppc-next branch (since there
are some other patches on that branch which are prerequisites for some
patches in kvm-ppc-next).  Michael can pull kvm-ppc-infrastructure
when he wants to.  I'll send a pull request for kvm-ppc-next tomorrow
assuming today's linux-next merge doesn't cause any problems.

Paul.
