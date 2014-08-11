Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7830B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 09:56:34 +1000 (EST)
Message-ID: <1407801378.7427.117.camel@snotra.buserror.net>
Subject: Re: [PATCH] KVM: PPC: e500mc: Add support for single threaded vcpus
 on e6500 core
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 11 Aug 2014 18:56:18 -0500
In-Reply-To: <3CE03B7F-D9C3-4CD0-8215-9815494A19AF@suse.de>
References: <1407342808-15987-1-git-send-email-mihai.caraman@freescale.com>
 <1407800199.7427.108.camel@snotra.buserror.net>
 <3CE03B7F-D9C3-4CD0-8215-9815494A19AF@suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-12 at 01:53 +0200, Alexander Graf wrote:
> 
> > Am 12.08.2014 um 01:36 schrieb Scott Wood <scottwood@freescale.com>:
> > 
> >> On Wed, 2014-08-06 at 19:33 +0300, Mihai Caraman wrote:
> >> @@ -390,19 +400,30 @@ static void kvmppc_core_vcpu_free_e500mc(struct kvm_vcpu *vcpu)
> >> 
> >> static int kvmppc_core_init_vm_e500mc(struct kvm *kvm)
> >> {
> >> -    int lpid;
> >> +    int i, lpid;
> >> 
> >> -    lpid = kvmppc_alloc_lpid();
> >> -    if (lpid < 0)
> >> -        return lpid;
> >> +    /* The lpid pool supports only 2 entries now */
> >> +    if (threads_per_core > 2)
> >> +        return -ENOMEM;
> >> +
> >> +    /* Each VM allocates one LPID per HW thread index */
> >> +    for (i = 0; i < threads_per_core; i++) {
> >> +        lpid = kvmppc_alloc_lpid();
> >> +        if (lpid < 0)
> >> +            return lpid;
> >> +
> >> +        kvm->arch.lpid_pool[i] = lpid;
> >> +    }
> > 
> > Wouldn't it be simpler to halve the size of the lpid pool that the
> > allocator sees, and just OR in the high bit based on the low bit of the
> > cpu number?
> 
> Heh, I wrote the same and then removed the section from my reply again. It wouldn't really make that much of a difference if you think it through completely.
> 
> But yes, it certainly would be quite a bit more natural. I'm ok either way.

It's not a huge difference, but it would at least get rid of some of the
ifdeffing in the headers.  It'd also be nicer when debugging to have the
LPIDs correlated.

-Scott
