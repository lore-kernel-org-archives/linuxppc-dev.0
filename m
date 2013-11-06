Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EFD3F2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 06:59:00 +1100 (EST)
Message-ID: <1383767930.4776.125.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc/kvm: remove redundant assignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Thu, 07 Nov 2013 06:58:50 +1100
In-Reply-To: <740542A8-47BC-4015-8675-D36C72F5837D@suse.de>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-3-git-send-email-pingfank@linux.vnet.ibm.com>
 <740542A8-47BC-4015-8675-D36C72F5837D@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Liu Ping Fan <kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-06 at 12:24 +0100, Alexander Graf wrote:
> On 05.11.2013, at 08:42, Liu Ping Fan <kernelfans@gmail.com> wrote:
> 
> > Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> 
> Patch description missing.

Do you really need a description for trivial one-lines whose subject
is a perfectly complete description already ?

> Please add Paul's ack in the next revision of this patch :).
> 
> 
> Alex
> 
> > ---
> > arch/powerpc/kvm/book3s_64_mmu_hv.c | 1 -
> > 1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > index 28160ac..7682837 100644
> > --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> > @@ -731,7 +731,6 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
> > 	lock_rmap(rmap);
> > 
> > 	/* Check if we might have been invalidated; let the guest retry if so */
> > -	ret = RESUME_GUEST;
> > 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
> > 		unlock_rmap(rmap);
> > 		goto out_unlock;
> > -- 
> > 1.8.1.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
