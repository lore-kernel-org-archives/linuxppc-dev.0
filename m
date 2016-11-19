Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLMDY2F6KzDvyH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 15:23:25 +1100 (AEDT)
Date: Sat, 19 Nov 2016 15:14:34 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 09/13] KVM: PPC: Book3S HV: Adapt TLB invalidations to
 work on POWER9
Message-ID: <20161119041434.GE29462@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-10-git-send-email-paulus@ozlabs.org>
 <87y40gn941.fsf@linux.vnet.ibm.com>
 <1479506248.27850.18.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1479506248.27850.18.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 19, 2016 at 08:57:28AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2016-11-18 at 20:11 +0530, Aneesh Kumar K.V wrote:
> > > +      * Work out how many sets the TLB has, for the use of
> > > +      * the TLB invalidation loop in book3s_hv_rmhandlers.S.
> > > +      */
> > > +     if (cpu_has_feature(CPU_FTR_ARCH_300))
> > > +             kvm->arch.tlb_sets = 256;       /* POWER9 */
> > > +     else if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > > +             kvm->arch.tlb_sets = 512;       /* POWER8 */
> > > +     else
> > > +             kvm->arch.tlb_sets = 128;       /* POWER7 */
> > > +
> > 
> > We have 
> > 
> > #define POWER7_TLB_SETS         128     /* # sets in POWER7 TLB */
> > #define POWER8_TLB_SETS         512     /* # sets in POWER8 TLB */
> > #define POWER9_TLB_SETS_HASH    256     /* # sets in POWER9 TLB Hash mode */
> > #define POWER9_TLB_SETS_RADIX   128     /* # sets in POWER9 TLB Radix mode */
> > 
> > May be use that instead of opencoding ?
> 
> Both are bad and are going to kill us for future backward
> compatibility.
> 
> These should be a device-tree property. We can fallback to hard wired
> values if it doesn't exist but we should at least look for one.

Tell me what the property is called and I'll add code to use it. :)
That's the whole reason why I moved this to C code.

> Note: P8 firmwares all have a bug creating a bogus "tlb-sets" property
> in the CPU node, so let's create a new one instead, with 2 entries
> (hash vs. radix) or 2 new ones, one for hash and one for radix (when
> available).

Paul.
