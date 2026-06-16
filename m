Return-Path: <linuxppc-dev+bounces-22681-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB91CD98CE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 05:08:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfZlH3ZcFz3bpx;
	Tue, 16 Jun 2026 15:08:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781586523;
	cv=none; b=EZVutso/nkgjDIkabSLkEY4bdAGoExMJGVTUlyQDMknAzQ5hCPCZcHMkPZVM8IrbVdGqK7FrjZ1RmaHKRCPECKlbBZaeI+HtbnWLM1271QLoemeRsV6ZY7S9nmQCBf9pwbfHyXQVOWh7SLlHmCZKGGJ26QCJbBvFaaajgmN36jaduj4Q+ajbUj1332s9zpVW805rarqYm/A6nZnBAkBcS7h4oUgDLSDmENPib9pS5SApaVrMY5dTCCq36ekoZBxv0JjPFz/Cbxy6ACuhvIN7SRAbR2EM/tEV4cGEORzI4ab0UP69MenjGwduWNYuGjO+A8B6+DV05wEAX/MLrLnVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781586523; c=relaxed/relaxed;
	bh=JGnLv8SO3eHawsWzNmyyE6lCQ87vw9PsT9VeN/LGYHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz7TchNM191xBlIvhgecnT72Rh2cgsD/6+FbXuerqlBnO8SIMFJ/ixjp5BlMJVt0TOlcUMuw3HrPFBG97YPB7nHpedmuUpegjAEsIsxvtdj/e5fE0zEiwbRYZE56ANqRjJCVl6JMV/4tDTTySnDBKMM0cGgNyan9jVtBLRcLEncXZZQb3OUy759+yvMN6TzbPo3EWmDDvdETsrpD6BrGeIUU6F67JS1S1rD0tUya4MnK3G51+t6x6QZigscYbYMPUHos1KQWgQVwm4gX8b7QMPcRs2QUhwLiOXOh/OVETxct8Zr+oNqcwFxWmvnomjlqy/gAsSZHFhAWzdVNjricjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rz02kjjW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rz02kjjW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfZlF6jvHz2yF7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 15:08:41 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso4105223a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 22:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586519; x=1782191319; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGnLv8SO3eHawsWzNmyyE6lCQ87vw9PsT9VeN/LGYHE=;
        b=Rz02kjjWYsQCer+xtL4uPKZJLjnIFo0Tp3ytG3GZ7BUqjGwStb0ZWk8DNwIcebuH4j
         DK+hcD7wcFBawd4Yn9kbXA4Y8aAVz8UzTwUsfSsDhtqUEsA5aEnzPFZfLXDT8geXgc4D
         hSMOejfvbd4Et0+Wix58iZWoQbJu/Yt2FVUJfJwrEpxgOd7ATHP2so1poAEkXXXQbWuG
         KU5GRZVyPOZbb6GtsTwyJWr1pLLi1ydGGJJpNZ5wrkSbAvO6jehy5ycyZC9TdUVCPlzD
         k/B52jjRlGL/lQKzoiUxee4T0wgJee8gsYLC11Sqs/nOxH2v1KI6IdbVyes6vlldzVcj
         ltPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586519; x=1782191319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGnLv8SO3eHawsWzNmyyE6lCQ87vw9PsT9VeN/LGYHE=;
        b=nKz0IHT9cs/J3uCQVZXoDD/dyhwaq5BPpSR0LXxmcrGeiu484OLsKdB3/DblqQUd0T
         /Op5GKhLo7b+yBVUTdk4Cm0hoD0PHHfbHAPrX5BpEOQtjxzFLgGU5exiY74uxEv2Nfi8
         kwZhNTePCYrmdh44FA65bn7Vvz+gVmlJscSbiVYwQxmAadTK7KPo2XofA0dwS6x2J/tq
         RBd4kqixJyuaQ+HTayqxJ4nHUJXkT+rly1gOYZDwl4MsER5DDjtgib+uigePFGPkxBYR
         fpSOgLmP11pywn1NzMWXSm8DLKRFKzZtc/zJNtl/xl7+rohj06bOin6oVTxrTsQbQ3WE
         kkgg==
X-Forwarded-Encrypted: i=1; AFNElJ8vJTZ4TDcadXnnnUQH2ksUQhlapUJHVUzqFQl2GUhgyl/VoyQB9LxZTppfGdZpAq9ce8YbiHScpIR3OOs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzeYdA6goQwoYN2kGHaXQ52LhWb/NprTPykZbJsADv7C0B2Zu7G
	ZDMm0Eh989gjOCWjIVtmYGI+SppS8GDpO9yqvCjY1nMSr9cpWEReyyzQ
X-Gm-Gg: Acq92OG7wsV0xaNliPO9lj4Id9rC3SSOjbqY2inflzQtAFUI5H685VxVZMEpz+P65vq
	/EJNcOwlgzQ1B9VOmHroHUbeecC3xG90ifJizmtoDrtYF5vuiPmsMJq7NKSyb0y2u9EDILV3EYx
	GBanzoqWb6psV6f56f3yQB/etiJegJMLnyy8Mzb8WjTowxW+seb0IkqNFZWZRz2nucrPITz0GxH
	5A3/Jgzj/i0w28zgJ9M5KdOCG9OJtWrsZRe5xmydBMiEOySpTiRpO+osVjtZfFQG9xmBr3PexrJ
	SJQZfoXPoY9+0tWT+GMg7oDbt5gOjPUaWcbYPhTam31FIDherjQSXjTkl4busU5HEAPyzxWMapU
	35Xi0jXol7/3k3DUuMeA7/fLC7fhDMCAHHevHiu1kua/RxQf8RTQxaE4AY4mi1Bv2oDdWOF44oz
	GPE+ZnxT3JSdXsX7iBdyRzGYDgOKH4BXLFqZkd43iim679gckJqOMbU/lS3aliA6inN9pevGQ=
X-Received: by 2002:a17:90b:3910:b0:36b:4d63:4a96 with SMTP id 98e67ed59e1d1-37a01848945mr18556918a91.1.1781586519045;
        Mon, 15 Jun 2026 22:08:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e84e7011sm7586159a91.1.2026.06.15.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:08:38 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:38:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Sayali Patil <sayalip@linux.ibm.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, mkchauras@linux.ibm.com, 
	ruanjinjie@huawei.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Restore kuap regs during syscall restart exit
Message-ID: <ajDaNuCzggxvO20Y@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260613123831.1510474-1-mkchauras@gmail.com>
 <c08eaf78-38ce-47f9-883d-5a009e768584@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c08eaf78-38ce-47f9-883d-5a009e768584@linux.ibm.com>

On Mon, Jun 15, 2026 at 10:51:43AM +0530, Shrikanth Hegde wrote:
> Hi Mukesh.
> 
> On 6/13/26 6:08 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> > During syscall restart, we block the kuap as we need to replay
> > interrupts. Which are not restored when we exit to the user, hence we
> > get a fault which ends up with `bad_access_pkey` and hence crashing the
> > kernel.
> > 
> > We have already stored the kuap values during the entry, just restore
> > them when we exit.
> > 
> > Applies on linux-next (next-20260610).
> > 
> 
> Please re-write the changelog in imperative mood.
> i.e Avoid we/you/I.
> 
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes
> 
> 
> > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > Reported-by: Sayali Patil <sayalip@linux.ibm.com>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >   arch/powerpc/kernel/interrupt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> > index 89a999be1352..159901d6ba8c 100644
> > --- a/arch/powerpc/kernel/interrupt.c
> > +++ b/arch/powerpc/kernel/interrupt.c
> > @@ -165,7 +165,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
> >   		local_irq_disable();
> >   		goto again;
> >   	}
> > -
> > +	kuap_user_restore(regs);
> 
> Please describe where was kuap save was done in the stack.
> 
> >   	regs->exit_result |= regs->exit_flags;
> >   	return regs->exit_result;
> 
Sent out V2 with the requested changes.

Regards,
Mukesh

