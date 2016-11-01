Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7FyP0YMMzDvNT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 13:47:40 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id s8so10264756pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 19:47:40 -0700 (PDT)
Message-ID: <1477968451.2143.7.camel@gmail.com>
Subject: Re: [PATCH V2 2/2] powerpc/kvm: Update kvmppc_set_arch_compat() for
 ISA v3.00
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 mpe@ellerman.id.au,  benh@kernel.crashing.org, agraf@suse.com
Date: Tue, 01 Nov 2016 13:47:31 +1100
In-Reply-To: <20161031054436.6vv76jci5aebfpd6@oak.ozlabs.ibm.com>
References: <1477873703-22403-1-git-send-email-sjitindarsingh@gmail.com>
 <1477873703-22403-3-git-send-email-sjitindarsingh@gmail.com>
 <20161031054436.6vv76jci5aebfpd6@oak.ozlabs.ibm.com>
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

On Mon, 2016-10-31 at 16:44 +1100, Paul Mackerras wrote:
> On Mon, Oct 31, 2016 at 11:28:23AM +1100, Suraj Jitindar Singh wrote:
> > 
> > The function kvmppc_set_arch_compat() is used to determine the
> > value of the
> > processor compatibility register (PCR) for a guest running in a
> > given
> > compatibility mode. There is currently no support for v3.00 of the
> > ISA.
> > 
> > Add support for v3.00 of the ISA which adds an ISA v2.07
> > compatilibity mode
> > to the PCR.
> > 
> > We also add a check to ensure the processor we are running on is
> > capable of
> > emulating the chosen processor (for example a POWER7 cannot emulate
> > a
> > POWER8, similarly with a POWER8 and a POWER9).
> > 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 32 +++++++++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c
> > b/arch/powerpc/kvm/book3s_hv.c
> > index 3686471..24681e7 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -311,24 +311,38 @@ static int kvmppc_set_arch_compat(struct
> > kvm_vcpu *vcpu, u32 arch_compat)
> >  			 * If an arch bit is set in PCR, all the
> > defined
> >  			 * higher-order arch bits also have to be
> > set.
> >  			 */
> > -			pcr = PCR_ARCH_206 | PCR_ARCH_205;
> > +			if (cpu_has_feature(CPU_FTR_ARCH_206))
> > +				pcr |= PCR_ARCH_205;
> > +			if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > +				pcr |= PCR_ARCH_206;
> > +			if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +				pcr |= PCR_ARCH_207;
> >  			break;
> >  		case PVR_ARCH_206:
> >  		case PVR_ARCH_206p:
> > -			pcr = PCR_ARCH_206;
> > +			/* Must be at least v2.06 to (emulate) it
> > */
> > +			if (!cpu_has_feature(CPU_FTR_ARCH_206))
> > +				return -EINVAL;
> > +			if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > +				pcr |= PCR_ARCH_206;
> > +			if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +				pcr |= PCR_ARCH_207;
> >  			break;
> >  		case PVR_ARCH_207:
> > +			/* Must be at least v2.07 to (emulate) it
> > */
> > +			if (!cpu_has_feature(CPU_FTR_ARCH_207S))
> > +				return -EINVAL;
> > +			if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +				pcr |= PCR_ARCH_207;
> > +			break;
> > +		case PVR_ARCH_300:
> > +			/* Must be at least v3.00 to (emulate) it
> > */
> > +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> > +				return -EINVAL;
> >  			break;
> I can't help thinking that the repetitive structure of the lines
> you're adding must imply a regularity that could be expressed more
> concisely.  If you defined a dummy PCR_ARCH_300 bit as 0x10, perhaps
> you could do something like this:
> 
> 	if (cpu_has_feature(CPU_FTR_ARCH_300))
> 		host_pcr_bit = PCR_ARCH_300;
> 	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
> 		host_pcr_bit = PCR_ARCH_207;
> 	else
else if
> 		host_pcr_bit = PCR_ARCH_206;
else
	host_pcr_bit = PCR_ARCH_205;
> 
> 	switch (arch_compat) {
> 	case PVR_ARCH_205:
> 		guest_pcr_bit = PCR_ARCH_205;
> 		break;
> 	case PVR_ARCH_206:
> 		guest_pcr_bit = PCR_ARCH_206;
> 		break;
> 	case PVR_ARCH_207:
> 	case PVR_ARCH_207S:
> 		guest_pcr_bit = PCR_ARCH_207;
> 		break;
> 	case PVR_ARCH_300:
> 		guest_pcr_bit = PCR_ARCH_300;
> 		break;
> 	default:
> 		return -EINVAL;
> 	}
> 
> 	if (guest_pcr_bit > host_pcr_bit)
> 		return -EINVAL;
> 
> 	pcr = host_pcr_bit - guest_pcr_bit;
That approach is simpler and more extensible, I guess I don't really
like that it relies on the assumption that the PCR bits remain
consecutive and breaks if that assumption becomes invalid, which may
never be the case. I guess we can assume they will be for now and fix
it in the event that ever changes.
> 
> The translation from arch_compat to guest_pcr_bit might look neater
> as
> a table lookup on the low bits of arch_compat, after a bounds check.
Is that really necessary? I don't see the benefit and the code is more
readable in it's current form IMO.

Something like this?

unsigned long guest_pcr_bits = {0,              /* 0 */ 
                                0,              /* 1 */ 
                                PCR_ARCH_205,   /* 0x0F000002 */
                                PCR_ARCH_206,   /* 0x0F000003 */
                                PCR_ARCH_207,   /* 0x0F000004 */
                                PCR_ARCH_300 }; /* 0x0F000005 */
if (arch_compat <= PVR_ARCH_300 && arch_compat >= PVR_ARCH_205)
        guest_pcr_bit = guest_pcr_bits[arch_compat & 0xF]; 
else    
        return -EINVAL;
> 
> Paul.
