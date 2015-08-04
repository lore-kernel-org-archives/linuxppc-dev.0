Return-Path: <ego@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 925801A0748
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 20:57:57 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 4 Aug 2015 04:57:55 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A26A01FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 04:49:02 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t74Auxjs50659494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 03:56:59 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t74AvqKx020219
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2015 04:57:52 -0600
Date: Tue, 4 Aug 2015 16:27:47 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: powerpc: Add an inline function to update HID0
Message-ID: <20150804105747.GA19966@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1438677058-12883-1-git-send-email-ego@linux.vnet.ibm.com>
 <20150804100858.1F272140306@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150804100858.1F272140306@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, Aug 04, 2015 at 08:08:58PM +1000, Michael Ellerman wrote:
> On Tue, 2015-04-08 at 08:30:58 UTC, "Gautham R. Shenoy" wrote:
> > Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
> > prescribes that updates to HID0 be preceded by a SYNC instruction and
> > followed by an ISYNC instruction (Page 91).
> > 
> > Create a function name update_hid0() which follows this recipe and
> > invoke it from the static split core path.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/include/asm/kvm_ppc.h       | 11 +++++++++++
> 
> Why is it in there? It's not KVM related per se.

Ok. Will fix this.
> 
> Where should it go? I think reg.h would be best, ideally near the definition
> for HID0, though that's probably not possible because of ASSEMBLY requirements.
> So at the bottom of reg.h ?
> 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index c6ef05b..325f1d6 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -685,4 +685,15 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
> >  
> >  extern void xics_wake_cpu(int cpu);
> >  
> > +static inline void update_hid0(unsigned long hid0)
> > +{
> > +	/*
> > +	 *  The HID0 update should at the very least be preceded by a
> > +	 *  a SYNC instruction followed by an ISYNC instruction
> > +	 */
> > +	mb();
> > +	mtspr(SPRN_HID0, hid0);
> > +	isync();
> 
> That's going to turn into three separate inline asm blocks, which is maybe a
> bit unfortunate. Have you checked the generated code is what we want, ie. just
> sync, mtspr, isync ?
> 

Yes, the objdump of subcore.o shows exactly these three instructions:
 7c 00 04 ac     sync    
 7c 70 fb a6     mtspr   1008,r3
 4c 00 01 2c     isync

> cheers
>
--
Thanks and Regards
gautham. 
