Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtvl30SY5zDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 19:24:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, aik@ozlabs.ru,
 agraf@suse.de, kvm-ppc@vger.kernel.org, qemu-devel@nongnu.org,
 paulus@samba.org, david@gibson.dropbear.id.au
Subject: Re: [1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
In-Reply-To: <20160719032325.GA14519@tungsten.ozlabs.ibm.com>
References: <741e7a7860e055603a311bcc6051bd88fdad1215.1467785081.git.sam.bobroff@au1.ibm.com>
 <3rmB8G0Wkxz9s9Z@ozlabs.org> <20160719032325.GA14519@tungsten.ozlabs.ibm.com>
Date: Tue, 19 Jul 2016 19:24:46 +1000
Message-ID: <87lh0y9e01.fsf@@concordia.ellerman.id.au>
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

Sam Bobroff <sam.bobroff@au1.ibm.com> writes:

> On Fri, Jul 08, 2016 at 08:49:49PM +1000, Michael Ellerman wrote:
>> On Wed, 2016-06-07 at 06:05:54 UTC, Sam bobroff wrote:
>> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> > index 02416fe..06d79bc 100644
>> > --- a/arch/powerpc/kvm/powerpc.c
>> > +++ b/arch/powerpc/kvm/powerpc.c
>> > @@ -588,6 +588,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>> >  		r = 1;
>> >  		break;
>> >  #endif
>> > +	case KVM_CAP_PPC_HTM:
>> > +		r = cpu_has_feature(CPU_FTR_TM)
>> > +		    && is_kvmppc_hv_enabled(kvm);
>> 
>> I think it should be using CPU_FTR_TM_COMP.
>
> Oh, why is that? I'm happy to respin the patch I'm just curious.
>
> (I did it that way becuase that seems to be the way the other flags are used,
> e.g. CPU_FTR_ALTIVEC).
>
> If I read the code correctly, using CPU_FTR_TM_COMP will work fine: it should
> cause the cpu_has_feature() test to always return false if CPU_FTR_TM_COMP is
> 0.

CPU_FTR_TM says the CPU supports TM.

CPU_FTR_TM_COMP says the CPU supports TM *and* the kernel is built with
TM support.

The distinction exists because currently the assembly patching macros
don't deal correctly with a feature bit that is defined to 0. (And
possibly other reasons I don't remember)

We should fix that, but until we have, anything that is advertising
support to userspace should be using the COMP bits, when they exist.

cheers
