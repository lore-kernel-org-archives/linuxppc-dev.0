Return-Path: <hollisb@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64425DE0B9
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:52:17 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n05GooPM006924
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 11:50:50 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n05GqDAk190510
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 11:52:13 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n05GqDKg003790
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 11:52:13 -0500
Subject: Re: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index for use in
	c file
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <163A79D0-237C-4513-948A-6460AB497ACC@freescale.com>
References: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
	<0A1FE637C2C7E148B9573BB60CC630E5041F58@zch01exm26.fsl.freescale.net>
	<163A79D0-237C-4513-948A-6460AB497ACC@freescale.com>
Content-Type: text/plain
Date: Mon, 05 Jan 2009 10:52:11 -0600
Message-Id: <1231174331.27460.10.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Liu Yu <Yu.Liu@freescale.com>, Piepho Trent-B16872 <tpiepho@freescale.com>,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-05 at 10:26 -0600, Kumar Gala wrote:
> I'll pick this up, but wondering about this patch vs Trent's changes  
> to remove this.

Please do not pick up this patch; if you ack it, let us push it through
kvm.git. Otherwise we need to wait for it to travel from kumar.git ->
benh.git -> linus.git -> kvm.git before KVM will build.

If you're referring to http://patchwork.ozlabs.org/patch/12882/, that
patch removes a different variable (num_tlbcam_entries). tlbcam_index,
referenced below, still exists.

> How is KVM on fsl-booke using this value?

I'll let Yu answer that in more detail, but in
http://git.kernel.org/?p=linux/kernel/git/avi/kvm.git;a=blob_plain;f=arch/powerpc/kvm/e500_tlb.c;hb=HEAD it looks like he's storing guest TLB1 mappings in the real TLB1, alongside the host TLB1 mappings. Accordingly, he needs to know where the host mappings are to avoid clobbering them.

> On Jan 4, 2009, at 12:57 AM, Liu Yu wrote:
> 
> > Hi Kumar,
> >
> > Can I get your ack?
> > So that I can submit this patch through KVM tree.
> >
> >
> >> -----Original Message-----
> >> From: Liu Yu-B13201
> >> Sent: Friday, December 19, 2008 10:35 AM
> >> To: kvm-ppc@vger.kernel.org; linuxppc-dev@ozlabs.org
> >> Cc: hollisb@us.ibm.com; Gala Kumar-B11780; Piepho
> >> Trent-B16872; Wood Scott-B07421; Liu Yu-B13201
> >> Subject: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index
> >> for use in c file
> >>
> >> KVM on E500 platform currently utilize TLB1 entries without
> >> bothering host,
> >> that is using unused TLB1 entries.
> >>
> >> So, KVM needs to read tlbcam_index to know exactly
> >> which TLB1 entry is unused by host.
> >>
> >> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> >> ---
> >> [v2]
> >> Remove num_tlbcam_entries declare and read from SPRN_TLB1CFG
> >> in KVM instead.
> >>
> >> arch/powerpc/include/asm/mmu-fsl-booke.h |    2 ++
> >> 1 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h
> >> b/arch/powerpc/include/asm/mmu-fsl-booke.h
> >> index 925d93c..c86af6c 100644
> >> --- a/arch/powerpc/include/asm/mmu-fsl-booke.h
> >> +++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
> >> @@ -73,6 +73,8 @@
> >>
> >> #ifndef __ASSEMBLY__
> >>
> >> +extern unsigned int tlbcam_index;
> >> +
> >> typedef struct {
> >> 	unsigned long id;
> >> 	unsigned long vdso_base;
> >> -- 
> >> 1.5.4
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
Hollis Blanchard
IBM Linux Technology Center
