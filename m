Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E2F21A0DC5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 18:58:45 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Fri, 30 Jan 2015 07:58:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 422981B08061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 07:58:43 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0U7wbaZ7274834
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 07:58:38 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0U7wbV7012147
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 00:58:37 -0700
Date: Fri, 30 Jan 2015 08:58:35 +0100
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC,1/2] powerpc/fsl-pci: atomic get_user when pagefault_disabled
Message-ID: <20150130085835.3d717a92@thinkpad-w530>
In-Reply-To: <20150130051501.GA14213@home.buserror.net>
References: <1416915806-24757-2-git-send-email-dahi@linux.vnet.ibm.com>
 <20150130051501.GA14213@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Tue, Nov 25, 2014 at 12:43:25PM +0100, David Hildenbrand wrote:
> > Whenever we have pagefaults disabled, we have to use the atomic variants of
> > (set|get)_user and copy_(from|to)_user.
> > 
> > Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/sysdev/fsl_pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> > index 65d2ed4..c0af4ef 100644
> > --- a/arch/powerpc/sysdev/fsl_pci.c
> > +++ b/arch/powerpc/sysdev/fsl_pci.c
> > @@ -1025,7 +1025,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
> >  	if (is_in_pci_mem_space(addr)) {
> >  		if (user_mode(regs)) {
> >  			pagefault_disable();
> > -			ret = get_user(regs->nip, &inst);
> > +			ret = __get_user_inatomic(regs->nip, &inst);
> >  			pagefault_enable();
> >  		} else {
> >  			ret = probe_kernel_address(regs->nip, inst);
> 
> Please post a non-RFC version if you're ready for this to be merged.
> 
> -Scott
> 

Hi Scott,

actually this patch was wrong. We are allowed to use the non-atomic variants
during pagefault_disable(). The semantics of get_user()/set_user() then change
- they will not sleep.

To reenable the might_sleep checks() in might_fault() makes it necessary to
count the levels of pagefault_disable() calls, to distinguish it from oridnary
preempt_disable() calls. I've got another patchset out there that deals with
this problem and is able to distinguish between them.

The interest in this feature just doesn't seem to be very high :)

So you can safely ignore this patch.

David
