Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id BC905DDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Dec 2008 12:52:51 +1100 (EST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 22 Dec 2008 20:52:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: testing (Was: Re: linux-next: scsi-post-merge tree build failure)
Message-ID: <20081223015236.GA7137@zod.rchland.ibm.com>
References: <20081223012545.5b1e7f5e.sfr@canb.auug.org.au>
	<1229979392.4360.15.camel@pasglop>
	<20081223100456.bb556b19.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081223100456.bb556b19.sfr@canb.auug.org.au>
Cc: Blanchard <hollisb@us.ibm.com>, Hollis@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 23, 2008 at 10:04:56AM +1100, Stephen Rothwell wrote:
>Hi Ben,
>
>On Tue, 23 Dec 2008 07:56:32 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>>
>> On Tue, 2008-12-23 at 01:25 +1100, Stephen Rothwell wrote:
>> > Hi Paul, Ben,
>> > 
>> > Today's linux-next build (powerpc ppc44x_config) failed like this:
>> > 
>> > arch/powerpc/kvm/powerpc.c: In function 'kvm_arch_vcpu_put':
>> > arch/powerpc/kvm/powerpc.c:333: error: implicit declaration of function '_tlbil_all'
>> > 
>> > Probably caused by commit 2a4aca1144394653269720ffbb5a325a77abd5fa
>> > ("powerpc/mm: Split low level tlb invalidate for nohash processors").
>> > Reverting just that commit was too difficult, so I have reverted the
>> > powerpc tree for today.
>> 
>> You can't revert that without reverting my whole series.
>
>I know that ... I tried.
>
>> Adding a #include ../mm/mmu_decl.h to the kvm code should fix it for
>> now.
>> 
>> I need to talk to hollis about the right way to do that stuff in
>> the long run but it might be it... those _tlbil things are low level
>> stuff that aren't supposed to be used by the outside world which is
>> why I moved the declarations there, but KVM is also low level :-)
>
>So, why is this series in powerpc/next at all if some of the modified
>files haven't even been compiled?  A simple ppc44x_defconfig build of the
>powerpc/next tree fails - which I would have thought would be part of the
>testing since KVM is only implemented for 44x on powerpc.

Well, they were, and then they weren't.  I tested this series starting
with the ppc44x_defconfig.  However, I was incrementally compiling them
and I also had the 16/64K pages patch applied and 64K enabled.  That
resulted in a kernel that was too big for the wrapper, so I went in
and turned some stuff off to make the kernel smaller.  That included
the KVM stuff.  By the time I was done building and testing the whole
series, it had remained disabled.

That might sound like a cop-out, but it's what happend.  I should have
done a simple build after I was done.  Sorry Stephen.

josh
