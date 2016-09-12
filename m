Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXXgz579rzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 13:03:43 +1000 (AEST)
From: Michael Ellerman <michael@ellerman.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] powerpc/mm: Speed up computation of base and
 actual page size for a HPTE
In-Reply-To: <4ba4f3d7-eadc-5d20-534e-afc7075938fc@redhat.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
 <20160907061709.GD21443@fergus.ozlabs.ibm.com>
 <20160908100836.GA4965@fergus.ozlabs.ibm.com>
 <4ba4f3d7-eadc-5d20-534e-afc7075938fc@redhat.com>
Date: Mon, 12 Sep 2016 13:03:43 +1000
Message-ID: <877fahrf8w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 08/09/2016 12:08, Paul Mackerras wrote:
>>> > 
>>> >  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 37 ++++++++++++
>>> >  arch/powerpc/include/asm/kvm_book3s_64.h      | 87 +++------------------------
>>> >  arch/powerpc/include/asm/mmu.h                |  1 +
>>> >  arch/powerpc/mm/hash_native_64.c              | 42 +------------
>>> >  arch/powerpc/mm/hash_utils_64.c               | 55 +++++++++++++++++
>> This of course touches two maintainers' areas.  Michael and Paolo, how
>> do you want to proceed here?  Can this just go through Michael's tree?
>> Or should I make a topic branch off Linus' tree that you can both
>> pull, or should I split the patch into two (i.e. everything except the
>> kvm_book3s_64.h change in the first patch, and the kvm_book3s_64.h
>> change in the second) and get Michael to put the first one in a topic
>> branch that I can then pull and apply the second patch onto?
>
> This patch seems separate from the other two (I can't really tell since
> there wasn't a cover letter on linuxppc-dev).

Yeah. I've merged 1/3 as a fix, and will take 2/3 into next.

> Can you place it in a pull request for both Michael and myself?

Paul and I talked about this offline, he's going to create a topic
branch with this in it.

I'll hold off merging it until closer to the merge window, and I'll
merge it then if we are actually seeing conflicts between the PPC & KVM
trees caused by this.

cheers
