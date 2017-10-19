Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHpbR2QD8zDr26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:46:59 +1100 (AEDT)
Date: Thu, 19 Oct 2017 14:46:55 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.vnet.ibm.com>, Jerry
 Snitselaar <jsnitsel@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, Corentin Labbe
 <clabbe.montjoie@gmail.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Peter =?UTF-8?B?SMO8d2U=?=
 <PeterHuewe@gmx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/4] char/tpm: Less checks in tpm_ibmvtpm_probe() after
 error detection
Message-ID: <20171019144655.7d06111c@kitsune.suse.cz>
In-Reply-To: <9327cc83-448e-8404-af00-73f6409e269e@users.sourceforge.net>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
 <20171019135632.4af42743@kitsune.suse.cz>
 <9327cc83-448e-8404-af00-73f6409e269e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 Oct 2017 14:36:09 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> >> @@ -683,13 +683,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev
> >> *vio_dev, reg_crq_cleanup:
> >>  	dma_unmap_single(dev, ibmvtpm->crq_dma_handle,
> >> CRQ_RES_BUF_SIZE, DMA_BIDIRECTIONAL);
> >> -cleanup:
> >> -	if (ibmvtpm) {
> >> -		if (crq_q->crq_addr)
> >> -			free_page((unsigned long)crq_q->crq_addr);
> >> -		kfree(ibmvtpm);
> >> -	}
> >> -  
> > 
> > I think a single cleanup section is better than many labels that
> > just avoid a single null check.  
> 
> I proposed to delete two unnecessary condition checks together with
> an adjustment of jump targets.
> 

They are necessary to ensure the code works with single jump target.

The compiler is free to optimize them away and create the new jump
target implicitly. Do not do the optimization in place of the compiler.
It can do it automatically, in most cases better, and automatically
adapt it to code changes.

Thanks

Michal
