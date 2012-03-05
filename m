Return-Path: <B34182@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CB58B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 01:22:03 +1100 (EST)
Subject: Re: [PATCH] powerpc/srio: Fix the compile errors when building
 with 64bit
From: Liu Gang <Gang.Liu@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6BFCD6C7-7675-4A99-9C4C-4E86FA5642A4@kernel.crashing.org>
References: <1330672127-22172-1-git-send-email-Gang.Liu@freescale.com>
 <6BFCD6C7-7675-4A99-9C4C-4E86FA5642A4@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 5 Mar 2012 22:20:22 +0800
Message-ID: <1330957222.23420.136.camel@10.ap.freescale.net>
MIME-Version: 1.0
Cc: r58472@freescale.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, r61911@freescale.com, Alexandre.Bounine@idt.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Kumar,

On Fri, 2012-03-02 at 09:11 -0600, Kumar Gala wrote:
> > diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
> > index 1548578..468011e 100644
> > --- a/arch/powerpc/sysdev/fsl_rmu.c
> > +++ b/arch/powerpc/sysdev/fsl_rmu.c
> > @@ -311,8 +311,8 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
> > 
> > 	/* XXX Need to check/dispatch until queue empty */
> > 	if (dsr & DOORBELL_DSR_DIQI) {
> > -		u32 dmsg =
> > -			(u32) fsl_dbell->dbell_ring.virt +
> > +		unsigned long dmsg =
> > +			(unsigned long) fsl_dbell->dbell_ring.virt +
> > 			(in_be32(&fsl_dbell->dbell_regs->dqdpar) & 0xfff);
> > 		struct rio_dbell *dbell;
> > 		int found = 0;
> > @@ -657,7 +657,8 @@ fsl_add_outb_message(struct rio_mport *mport, struct rio_dev *rdev, int mbox,
> > 	int ret = 0;
> > 
> > 	pr_debug("RIO: fsl_add_outb_message(): destid %4.4x mbox %d buffer " \
> > -		 "%8.8x len %8.8x\n", rdev->destid, mbox, (int)buffer, len);
> > +		 "%8.8lx len %8.8zx\n", rdev->destid, mbox,
> > +		(unsigned long)buffer, len);
> > 	if ((len < 8) || (len > RIO_MAX_MSG_SIZE)) {
> > 		ret = -EINVAL;
> > 		goto out;
> 
> For this case it seems as if some cast should be added to DBELL_* macros

Do you mean the DBELL_* macro should be added the cast "u16" and like
this:
#define DBELL_SID(x)    (u16)(*(u16 *)(x + DOORBELL_SID_OFFSET))

> > @@ -972,7 +973,7 @@ out:
> > void *fsl_get_inb_message(struct rio_mport *mport, int mbox)
> > {
> > 	struct fsl_rmu *rmu = GET_RMM_HANDLE(mport);
> > -	u32 phys_buf, virt_buf;
> > +	unsigned long phys_buf, virt_buf;
> 
> Do you really want to change phys_buf to an 'unsigned long'?
> 
> Should virt_buf really be void * here?

I think you are right, the phys_buf should not be changed to 'unsigned
long' and the virt_buf should be void *. I'll correct this in next
version.

> > @@ -982,7 +983,7 @@ void *fsl_get_inb_message(struct rio_mport *mport, int mbox)
> 
> The memcpy later could remove a cast if you make virt_buf a void *.

Thanks a lot, will remove.

Best Regards,

Liu Gang
