Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4DBA1A0205
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Sep 2014 06:57:05 +1000 (EST)
Message-ID: <1411157986.13320.75.camel@snotra.buserror.net>
Subject: Re: [PATCH 03/15] powerpc/msi: Improve IRQ bitmap allocator
From: Scott Wood <scottwood@freescale.com>
To: Michael Neuling <mikey@neuling.org>
Date: Fri, 19 Sep 2014 15:19:46 -0500
In-Reply-To: <1411157769.13320.74.camel@snotra.buserror.net>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-4-git-send-email-mikey@neuling.org>
 <1411157769.13320.74.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 imunsie@au.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Laurentiu
 Tudor <Laurentiu.Tudor@freescale.com>, anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-09-19 at 15:16 -0500, Scott Wood wrote:
> On Thu, 2014-09-18 at 18:26 +1000, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > Currently msi_bitmap_alloc_hwirqs() will round up any IRQ allocation requests
> > to the nearest power of 2.  eg. ask for 5 IRQs and you'll get 8.  This wastes a
> > lot of IRQs which can be a scarce resource.
> > 
> > For cxl we can require multiple IRQs for every contexts that is attached to the
> > accelerator.  For AFU directed accelerators, there may be 1000s of contexts
> > attached, hence we can easily run out of IRQs, especially if we are needlessly
> > wasting them.
> > 
> > This changes the msi_bitmap_alloc_hwirqs() to allocate only the required number
> > of IRQs, hence avoiding this wastage.
> > 
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/sysdev/msi_bitmap.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> This conflicts with (and partially duplicates)
> http://patchwork.ozlabs.org/patch/381892/
> which I have in my tree.  How should we handle it?
> 
> Laurentiu, from looking at the overlap between patches I see a problem
> with your existing patch, regarding the out-of-irqs path and
> msi_bitmap_free_hwirqs(), so one way or another that needs to get fixed
> soon.

Given the problems with Laurentiu's patch, perhaps it'd be best for me
to just revert that patch in my tree, and respin it after this patchset
has been merged.

-Scott
