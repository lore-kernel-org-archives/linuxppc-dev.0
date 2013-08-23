Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 29B9A2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 14:28:14 +1000 (EST)
Message-ID: <1377232085.3613.0.camel@pasglop>
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 23 Aug 2013 14:28:05 +1000
In-Reply-To: <87haeh13s2.fsf@linux.vnet.ibm.com>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
 <87haeh13s2.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-23 at 09:01 +0530, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.de> writes:
> 
> > On 22.08.2013, at 12:37, Aneesh Kumar K.V wrote:
> >
> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >
> > Isn't this you?
> 
> Yes. The patches are generated using git format-patch and sent by
> git send-email. That's how it always created patches for me. I am not sure if
> there is a config I can change to avoid having From:

Don't bother, that's perfectly fine, and git am will do the right thing.

Cheers,
Ben.

> >
> >> 
> >> We should be able to copy upto count bytes
> >
> > Why?
> >
> 
> Without this we end up doing
> 
>  +    struct kvm_get_htab_buf {
>  +        struct kvm_get_htab_header header;
>  +        /*
>  +         * Older kernel required one extra byte.
>  +         */
>  +        unsigned long hpte[3];
>  +    } hpte_buf;
> 
> 
> even though we are only looking for one hpte entry.
> 
> http://mid.gmane.org/1376995766-16526-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com
> 
> >
> > Alex
> >
> >> 
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >> ---
> >> arch/powerpc/kvm/book3s_64_mmu_hv.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> >> index 710d313..0ae6bb6 100644
> >> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> >> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> >> @@ -1362,7 +1362,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
> >> 	lbuf = (unsigned long __user *)buf;
> >> 
> >> 	nb = 0;
> >> -	while (nb + sizeof(hdr) + HPTE_SIZE < count) {
> >> +	while (nb + sizeof(hdr) + HPTE_SIZE <= count) {
> >> 		/* Initialize header */
> >> 		hptr = (struct kvm_get_htab_header __user *)buf;
> >> 		hdr.n_valid = 0;
> >> @@ -1385,7 +1385,7 @@ static ssize_t kvm_htab_read(struct file *file, char __user *buf,
> >> 		/* Grab a series of valid entries */
> >> 		while (i < kvm->arch.hpt_npte &&
> >> 		       hdr.n_valid < 0xffff &&
> >> -		       nb + HPTE_SIZE < count &&
> >> +		       nb + HPTE_SIZE <= count &&
> >> 		       record_hpte(flags, hptp, hpte, revp, 1, first_pass)) {
> >> 			/* valid entry, write it out */
> >> 			++hdr.n_valid;
> >> -- 
> >> 1.8.1.2
> >> 
