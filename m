Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bSHf3yLgzF2RN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 15:58:05 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m21-v6so9829791pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 May 2018 22:58:05 -0700 (PDT)
Date: Wed, 2 May 2018 15:57:57 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: rashmica <rashmica.g@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>
Subject: Re: [resend] Revert "powerpc/powernv: Increase memory block size to
 1GB on radix"
Message-ID: <20180502155757.1a80b51e@balbir.ozlabs.ibm.com>
In-Reply-To: <58c3feb3-390c-2461-2bca-5b71f8dd14df@gmail.com>
References: <20180501025725.7441-1-bsingharora@gmail.com>
 <58c3feb3-390c-2461-2bca-5b71f8dd14df@gmail.com>
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

On Wed, 2 May 2018 15:10:33 +1000
rashmica <rashmica.g@gmail.com> wrote:

> Tested hot-unplugging dimm device on radix guest on p9 host with KVM.
> 
> 
> On 01/05/18 12:57, Balbir Singh wrote:
> > This commit was a stop-gap to prevent crashes on hotunplug, caused by
> > the mismatch between the 1G mappings used for the linear mapping and the
> > memory block size. Those issues are now resolved because we split the
> > linear mapping at hotunplug time if necessary, as implemented in commit
> > 4dd5f8a99e79 ("powerpc/mm/radix: Split linear mapping on hot-unplug").
> >
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>  
> Tested-by: Rashmica Gupta <rashmica.g@gmail.com>

I tested the following:

a. memtrace  - enable a region smaller than 1G, which split the mappings
as expected.
b. Checked linear mapping is 1G and not impacted by the revert
c. I can hotplug sizes less than 1G via the probe method

Tested-by: Balbir Singh <bsingharora@gmail.com>

> > ---
> >
> > Resend with a newer commit message grabbed from an email sent by mpe.
> >
> >  arch/powerpc/platforms/powernv/setup.c | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> > index ef8c9ce53a61..fa63d3fff14c 100644
> > --- a/arch/powerpc/platforms/powernv/setup.c
> > +++ b/arch/powerpc/platforms/powernv/setup.c
> > @@ -356,15 +356,7 @@ static void pnv_kexec_cpu_down(int crash_shutdown, int secondary)
> >  #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> >  static unsigned long pnv_memory_block_size(void)
> >  {
> > -	/*
> > -	 * We map the kernel linear region with 1GB large pages on radix. For
> > -	 * memory hot unplug to work our memory block size must be at least
> > -	 * this size.
> > -	 */
> > -	if (radix_enabled())
> > -		return 1UL * 1024 * 1024 * 1024;
> > -	else
> > -		return 256UL * 1024 * 1024;
> > +	return 256UL * 1024 * 1024;
> >  }
> >  #endif
> >    
> 
