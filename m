Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scvWc4212zDsf7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 15:26:36 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id vz6so6434759pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 22:26:36 -0700 (PDT)
Message-ID: <1474262788.5093.8.camel@gmail.com>
Subject: Re: [PATCH 2/2] powerpc: tm: Enable transactional memory (TM)
 lazily for userspace
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, mikey@neuling.org,
 anton@samba.org
Date: Mon, 19 Sep 2016 15:26:28 +1000
In-Reply-To: <20160919044718.GB3797@simonLocalRHEL7.x64>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
 <20160914080216.13833-3-cyrilbur@gmail.com>
 <20160919044718.GB3797@simonLocalRHEL7.x64>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-09-19 at 12:47 +0800, Simon Guo wrote:
> On Wed, Sep 14, 2016 at 06:02:16PM +1000, Cyril Bur wrote:
> > 
> > @@ -954,8 +963,16 @@ static inline void __switch_to_tm(struct
> > task_struct *prev,
> >  		struct task_struct *new)
> >  {
> >  	if (cpu_has_feature(CPU_FTR_TM)) {
> > -		tm_enable();
> > -		tm_reclaim_task(prev);
> > +		if (tm_enabled(prev) || tm_enabled(new))
> > +			tm_enable();
> > +
> > +		if (tm_enabled(prev)) {
> > +			prev->thread.load_tm++;
> > +			tm_reclaim_task(prev);
> > +			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) 
> > && prev->thread.load_tm == 0)
> > +				prev->thread.regs->msr &= ~MSR_TM;
> > +		}
> Hi Cyril,
> 
> If MSR_TM_ACTIVE(), is it better to reset load_tm to 0?
> Other looks good to me.
> 

Doing so would extend the window that we keep TM enabled for when we
might not need to. It is possible that we could assume that if
MSR_TM_ACTIVE() then they're in codepathes that will reuse TM again
soon so load_tm = 0 could be a good idea but there's really no way to
know. Food for thought I guess...

Maybe?

Good thought,
Cyril

> Thanks,
> - Simon
