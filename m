Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCMPG6BzwzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 11:07:14 +1000 (AEST)
Date: Wed, 26 Apr 2017 11:07:09 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S PR: Do not fail emulation with
 mtspr/mfspr for unknown SPRs
Message-ID: <20170426010709.GA18142@fergus.ozlabs.ibm.com>
References: <1491400731-2492-1-git-send-email-thuth@redhat.com>
 <b86abd70-b9f4-521b-8b94-01eab8a3cf81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b86abd70-b9f4-521b-8b94-01eab8a3cf81@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2017 at 09:14:01AM +0200, Thomas Huth wrote:
> On 05.04.2017 15:58, Thomas Huth wrote:
> > According to the PowerISA 2.07, mtspr and mfspr should not always
> > generate an illegal instruction exception when being used with an
> > undefined SPR, but rather treat the instruction as a NOP or inject a
> > privilege exception in some cases, too - depending on the SPR number.
> > Also turn the printk here into a ratelimited print statement, so that
> > the guest can not flood the dmesg log of the host by issueing lots of
> > illegal mtspr/mfspr instruction here.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  v3:
> >  - Make sure that we do not advance the program counter after we've
> >    already changed it due to injecting a program interrupt
> > 
> >  v2:
> >  - Inject illegal instruction program interrupt instead of emulation
> >    assist interrupt (according to the last programming note in section
> >    6.5.9 of Book III of the PowerISA v2.07)
> > 
> >  arch/powerpc/kvm/book3s_emulate.c | 34 ++++++++++++++++++++++++++--------
> >  arch/powerpc/kvm/emulate.c        |  8 ++++++++
> >  2 files changed, 34 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> > index 8359752..68d6898 100644
> > --- a/arch/powerpc/kvm/book3s_emulate.c
> > +++ b/arch/powerpc/kvm/book3s_emulate.c
> > @@ -503,10 +503,18 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
> >  		break;
> >  unprivileged:
> >  	default:
> > -		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
> > -#ifndef DEBUG_SPR
> > -		emulated = EMULATE_FAIL;
> > -#endif
> > +		pr_info_ratelimited("KVM: invalid SPR write: %d\n", sprn);
> > +		if (sprn & 0x10) {
> > +			if (kvmppc_get_msr(vcpu) & MSR_PR) {
> > +				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
> > +				emulated = EMULATE_AGAIN;
> > +			}
> > +		} else {
> > +			if ((kvmppc_get_msr(vcpu) & MSR_PR) || sprn == 0) {
> > +				kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> > +				emulated = EMULATE_AGAIN;
> > +			}
> > +		}
> >  		break;
> >  	}
> >  
> > @@ -648,10 +656,20 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
> >  		break;
> >  	default:
> >  unprivileged:
> > -		printk(KERN_INFO "KVM: invalid SPR read: %d\n", sprn);
> > -#ifndef DEBUG_SPR
> > -		emulated = EMULATE_FAIL;
> > -#endif
> > +		pr_info_ratelimited("KVM: invalid SPR read: %d\n", sprn);
> > +		if (sprn & 0x10) {
> > +			if (kvmppc_get_msr(vcpu) & MSR_PR) {
> > +				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
> > +				emulated = EMULATE_AGAIN;
> > +			}
> > +		} else {
> > +			if ((kvmppc_get_msr(vcpu) & MSR_PR) || sprn == 0 ||
> > +			    sprn == 4 || sprn == 5 || sprn == 6) {
> > +				kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
> > +				emulated = EMULATE_AGAIN;
> > +			}
> > +		}
> > +
> >  		break;
> >  	}
> >  
> > diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> > index b379146..c873ffe 100644
> > --- a/arch/powerpc/kvm/emulate.c
> > +++ b/arch/powerpc/kvm/emulate.c
> > @@ -259,10 +259,18 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
> >  
> >  		case OP_31_XOP_MFSPR:
> >  			emulated = kvmppc_emulate_mfspr(vcpu, sprn, rt);
> > +			if (emulated == EMULATE_AGAIN) {
> > +				emulated = EMULATE_DONE;
> > +				advance = 0;
> > +			}
> >  			break;
> >  
> >  		case OP_31_XOP_MTSPR:
> >  			emulated = kvmppc_emulate_mtspr(vcpu, sprn, rs);
> > +			if (emulated == EMULATE_AGAIN) {
> > +				emulated = EMULATE_DONE;
> > +				advance = 0;
> > +			}
> >  			break;
> >  
> >  		case OP_31_XOP_TLBSYNC:
> > 
> 
> Ping!
> 
> Paul, does this now look OK for you this way?

Yes, and I put it in, see commit feafd13c96d6.

Paul.
