Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qklRf4Z4WzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 21:42:54 +1000 (AEST)
Message-ID: <1460461368.23581.1.camel@ellerman.id.au>
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com
Date: Tue, 12 Apr 2016 21:42:48 +1000
In-Reply-To: <87y48kfeja.fsf@linux.vnet.ibm.com>
References: <3qWf364wYxz9sDG@ozlabs.org> <8737rau3b7.fsf@linux.vnet.ibm.com>
 <570B23CD.3090203@au1.ibm.com> <1460348865.3444.0.camel@ellerman.id.au>
 <878u0kahqn.fsf@linux.vnet.ibm.com>
 <1460373271.17837.3.camel@ellerman.id.au>
 <87y48kfeja.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-11 at 19:12 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > 
> > In this case it *looks* like we have a giant hole in the mm handling for CAPI
> > contexts, which would let userspace create mappings of kernel memory with
> > _PAGE_USER set. I think I agree with Ian that in fact that's not true, but it's
> > not clear from the diff that is the case. So I'd really like someone to write a
> > good commit message demonstrating that we understand what the bug is and why
> > it's not a big deal, despite the patch looking scary at first glance.
> 
> That confused me.

Sorry :)

> Do you agree that the current code won't allow 
> "userspace create mappings of kernel memory with  _PAGE_USER set" ?

Yes. My point is that the diff doesn't make that clear - and at first glance it
looks like it could be a bad bug. So it needs a good change log explaning
why it's not possible.

> Or are you suggesting that we do and this need to be documented ?
> 
> If it is later, that is not true. The current code will set _PAGE_USER
> to the access flags for any fault address. ie, because ~ operation will
> be true for all address we take fault on. But setting _PAGE_USER also means
> that the fault will be handled only if the page table have _PAGE_USER
> set.
> 
> Now if it is an user space access, then the change really don't have an
> impact because we have (!ctx->kernel) true for that case and we take
> that if condition true.

Right. And if it was a userspace access of a kernel address it should never have
got that far, because copro_handle_mm_fault() should have failed IIUIC.

> 
> Now if kernel is faulting, which I am not sure capi can result such a
> fault and it is faulting on a adress in the kernel range, then the
> current code will result in a loop fault, because we will not insert
> hash pte due to access and pte permission mismatch. So there is
> no security hole in the fault handling AFAIU.
> 
> Are you suggesting that the above should be documented in the commit
> message ?

Yep.

cheers
