Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sctf53qNpzDscr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 14:47:09 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 6so3696543pfl.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 21:47:09 -0700 (PDT)
Date: Mon, 19 Sep 2016 12:47:19 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, mikey@neuling.org,
 anton@samba.org
Subject: Re: [PATCH 2/2] powerpc: tm: Enable transactional memory (TM) lazily
 for userspace
Message-ID: <20160919044718.GB3797@simonLocalRHEL7.x64>
References: <20160914080216.13833-1-cyrilbur@gmail.com>
 <20160914080216.13833-3-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160914080216.13833-3-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2016 at 06:02:16PM +1000, Cyril Bur wrote:
> @@ -954,8 +963,16 @@ static inline void __switch_to_tm(struct task_struct *prev,
>  		struct task_struct *new)
>  {
>  	if (cpu_has_feature(CPU_FTR_TM)) {
> -		tm_enable();
> -		tm_reclaim_task(prev);
> +		if (tm_enabled(prev) || tm_enabled(new))
> +			tm_enable();
> +
> +		if (tm_enabled(prev)) {
> +			prev->thread.load_tm++;
> +			tm_reclaim_task(prev);
> +			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm == 0)
> +				prev->thread.regs->msr &= ~MSR_TM;
> +		}
Hi Cyril,

If MSR_TM_ACTIVE(), is it better to reset load_tm to 0?
Other looks good to me.

Thanks,
- Simon
