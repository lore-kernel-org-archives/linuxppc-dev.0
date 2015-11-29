Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09DDC1A080F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 08:33:44 +1100 (AEDT)
Date: Mon, 30 Nov 2015 08:33:00 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Geyslan =?iso-8859-1?Q?Greg=F3rio?= Bem <geyslan@gmail.com>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] kvm - possible out of bounds
Message-ID: <20151129213300.GA28845@fergus.ozlabs.ibm.com>
References: <CAGG-pUS04iVsi3s4hkB8goWkCM3sq+QiLw7L74bbef93Z=+qwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAGG-pUS04iVsi3s4hkB8goWkCM3sq+QiLw7L74bbef93Z=+qwg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 29, 2015 at 05:14:03PM -0300, Geyslan Gregório Bem wrote:
> Hello,
> 
> I have found a possible out of bounds reading in
> arch/powerpc/kvm/book3s_64_mmu.c (kvmppc_mmu_book3s_64_xlate
> function). pteg[] array could be accessed twice using the i variable
> after the for iteration. What happens is that in the last iteration
> the i index is incremented to 16, checked (i<16) then confirmed
> exiting the loop.
> 
> 277    for (i=0; i<16; i+=2) { ...
> 
> Later there are reading attempts to the pteg last elements, but using
> again the already incremented i (16).
> 
> 303    v = be64_to_cpu(pteg[i]);  /* pteg[16] */
> 304    r = be64_to_cpu(pteg[i+1]); /* pteg[17] */

Was it some automated tool that came up with this?

There is actually no problem because the accesses outside the loop are
only done if the 'found' variable is true; 'found' is initialized to
false and only ever set to true inside the loop just before a break
statement.  Thus there is a correlation between the value of 'i' and
the value of 'found' -- if 'found' is true then we know 'i' is less
than 16.

> I really don't know if the for lace will somehow iterate until i is
> 16, anyway I think that the last readings must be using a defined max
> len/index or another more clear method.

I think it's perfectly clear to a human programmer, though some tools
(such as gcc) struggle with this kind of correlation between
variables.  That's why I asked whether your report was based on the
output from some tool.

> Eg.
> 
>     v = be64_to_cpu(pteg[PTEG_LEN - 2]);
>     r = be64_to_cpu(pteg[PTEG_LEN - 1]);
> 
> Or just.
> 
>     v = be64_to_cpu(pteg[14]);
>     r = be64_to_cpu(pteg[15]);

Either of those options would cause the code to malfunction.

> I found in the same file a variable that is not used.
> 
> 380    struct kvmppc_vcpu_book3s *vcpu_book3s;
> ...
> 387    vcpu_book3s = to_book3s(vcpu);

True.  It could be removed.

> A question, the kvmppc_mmu_book3s_64_init function is accessed by
> unconventional way? Because I have not found any calling to it.

Try arch/powerpc/kvm/book3s_pr.c line 410:

		kvmppc_mmu_book3s_64_init(vcpu);

Grep (or git grep) is your friend.

Paul.
