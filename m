Return-Path: <linuxppc-dev+bounces-29369-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CF6CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:16:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3vx46Pzpz3brM;
	Wed, 14 Oct 2026 00:16:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791897384;
	cv=none; b=Ufp8d+uOwnUO0fbTiJegdvh0FD6lg/V9jmKVCJzruEgGtC3M2MQDS6suOB76yMOcjkTr2VedJCMr+qil1XVt68vzp4iN5zLyYr4hAPi4bA6KN2xlSRNbyg6GHwY0ZO1BCUqdeKlXWV6tWZZN57DfVrZf6SqzVudLYmRA2qcxS7CI7roe7Oc3VPYRNPwNb4V203AHNOEcs/4MX+QXQk3ayTNKjqpSdiYJTSLjGAoJ0m2KvCpAQmIEVzWtkz18xeNPWQ92mPza32W+npoG0ensASBPjDtrHru8npSf37SV4EJy+N3QzGDIA9RDBTV+4bL40MpUwtwXoQl5z7RirsmUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791897384; c=relaxed/relaxed;
	bh=/Q6uCkX+rlTkR+bq8MdQcJ9FUDBjBYXnucYbcKrw8i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGK3tnvZEmFhoaVDYNYx4+2/Xt9Nz8zD2KdbD17DaerTBK9hMHymci+o22BX121WS0UwKlTkggs8bZLtCXlunq9FT1HH90lWTATtweOtN2vryMDhUohkko4kxdgdTUHf8TFrFma8SMzpvL3H46d1orE+s0k6anhzpHrk/9tVrYcfbdjjHqx5PL37XNJdYmiQ6UXylTxta7qIieG5Zql1p03qBLsjWbf8FOG7HDTNuMLvjeaCqQ+1EvPudQTxCkC6o/AidBF2bolb1mDWUukgv659bjVVcoIAj+VXPaiZuiqVLk1JHqLaelcAmRApcyLsjudi+VeHuOfK7SVO431zrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lvSZOhA3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lvSZOhA3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com [IPv6:2607:f8b0:4864:20::b136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3vx40fz0z30VV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 00:16:23 +1100 (AEDT)
Received: by mail-yx1-xb136.google.com with SMTP id 956f58d0204a3-677cc343120so2863639d50.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791897381; x=1792502181; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Q6uCkX+rlTkR+bq8MdQcJ9FUDBjBYXnucYbcKrw8i0=;
        b=lvSZOhA3IUK1Dszt8qb4EqYsBvZnhEKV3+/kzDTmpYJWr3en56P4bqTo9Nt9WnVuHt
         hjeIkyadNJSlkb0AOfZNZN/bC8lS84n8DLUENs5SaXh8bXZ0haePLZNJ6kfQqfapVPXp
         /X4XkIZYxY/DFqZICSxf7yxCayDGDgSNIUiuTJyhvoql1sFbv4p7385JkmNDwBwLuOjT
         Rnw5UPuR/yyWnMcCQVjR4ROXJl2/DteS4QXUPIBegF8voa2ddquXpcQ5QONQTu1r0Kae
         +BviA/zLwiJAkM1pL+KPL6Iikt7aMsnTew3nkO45ZiiTVKH++W5CQClarORz1H1I0BUV
         1vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791897381; x=1792502181;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Q6uCkX+rlTkR+bq8MdQcJ9FUDBjBYXnucYbcKrw8i0=;
        b=MVaPus7YqUvHLqPXQEuWoZi0zbAS1K/45pA5SsZquDYoMgUocq+ZqHtH40Jmbq6Z9k
         DQu1V/3KNAsAcTxOxb/iT9HVron4P6JGQo/H1RHUsGyWuEYFHE25dtoLJkwuWABTHQim
         TVVrCtYYs1sbr4D0HdN5J885MUqTVoA9RkwFNKfg9YtwgUrqMjP9R0kn9T9YtNgrzg7q
         fbViaeP0wblgBTOUP/d2qUGZlaRYQM1cSs0V9uiuj1Snyn/qJle2FaO9lImRzdULMz6C
         rL8MbHvbY2J21grb8j+pZ1U1T4zVNqhYAuuLw3Fzo46yM9UkQdodAuwQpR0Dlfmbuny7
         xa5Q==
X-Gm-Message-State: AFq9FYIRHaXducUIpjsXc4kOpNk/ssqbUvXjwLD9A9tG/lsVQL8oS7bS
	JcIyySZDgwWGHZpx4AnyYKi24buaCNfxuO8dkKEi85T6JPgdOFsx5Lqy
X-Gm-Gg: AYBFou0ikQGX92BM2Zz4lT3o4ZuFloCVyDxihiMDRY/y0+yxO1+BzLpyYoa5fbMv4CH
	8iJMCA9CMHtBv14kmOsWXI6NvUVXtUrsAAILxvZTH+NLHE3Wrm8SgumCrJ3khepepF7fUuUYliu
	veSNWFZLnfF4El81NOqdH24yS4zHGCPyV3uwhlQ2xYoJYpxcci6jzJ1UrCy+WTJV0AqQSUXPy0o
	mxf6+xJ+IlXoM86JLRrgU4aaDTbRIxw64s+cY7Tj5MVjuH+AbTWBX+tWZRdndfk1GJZVU8UYs6x
	cEiYYsDwzWVChdcI2X+YPS+zon0NTF4al7PRYnbmabAKv9LUeePRFl7XuXsDy8I0xm8GtOjTHfK
	b0HCwQzOfkjCnRgQUYYrzt4EQlHbEz3CWlC0LPLppw3Nj3R0ZPAgzs5fGoTzpk5BiU7FCQsCkmB
	GVflJzvCycuu4UdC4uwfQXomMX+OUS9o/NEJ+PDm2MsevN0y4cWFLB37bhC6hbD1d1swC2jsec9
	I7OXhhRRh3LQ1gQPT8NzziEGWbwChFheICpuTRDeYLN
X-Received: by 2002:a05:690e:118e:b0:677:d21f:b632 with SMTP id 956f58d0204a3-67935f1c7b5mr5301132d50.2.1791897381320;
        Tue, 13 Oct 2026 06:16:21 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6793570cfe3sm4726812d50.25.2026.10.13.06.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:16:20 -0700 (PDT)
Date: Tue, 13 Oct 2026 18:46:12 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, 
	"Bernhard M. Wiedemann" <bwiedemann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc: Remove unused thread info flags
Message-ID: <as4vCZiuc8h4zjQ7@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
 <dcbd135c06fcf013b8aa902fbea8f6b1827d06c2.1791826411.git.msuchanek@suse.de>
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
In-Reply-To: <dcbd135c06fcf013b8aa902fbea8f6b1827d06c2.1791826411.git.msuchanek@suse.de>

On Mon, Oct 12, 2026 at 07:38:29PM +0200, Michal Suchanek wrote:
> These are no longer used with the generic entry code
> 
> Fixes: 6ed60999d33d4 ("powerpc: Remove unused functions")
> Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/powerpc/include/asm/thread_info.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 0e8dc71c8d3fe..4b7ec1db30349 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -96,22 +96,17 @@ void arch_setup_new_exec(void);
>  /*
>   * thread information flag bit numbers
>   */
> -#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
>  #define TIF_SIGPENDING		1	/* signal pending */
>  #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
>  #define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
> -#define TIF_SYSCALL_EMU		4	/* syscall emulation active */
>  #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
>  #define TIF_PATCH_PENDING	6	/* pending live patching update */
> -#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>  #define TIF_SINGLESTEP		8	/* singlestepping active */
>  #define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
> -#define TIF_SECCOMP		10	/* secure computing */
>  #define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
>  #define TIF_NOERROR		12	/* Force successful syscall return */
>  #define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
>  #define TIF_UPROBE		14	/* breakpointed or single-stepping */
> -#define TIF_SYSCALL_TRACEPOINT	15	/* syscall tracepoint instrumentation */
>  #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
>  						for stack store? */
>  #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
> @@ -123,7 +118,6 @@ void arch_setup_new_exec(void);
>  #define TIF_SYSCALL_RET		21	/* syscall error value set */
>  
>  /* as above, but as bit values */
> -#define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
>  #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
>  #define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
> @@ -132,16 +126,12 @@ void arch_setup_new_exec(void);
>  #define _TIF_32BIT		(1<<TIF_32BIT)
>  #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
>  #define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
> -#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
>  #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
> -#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
>  #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
>  #define _TIF_NOERROR		(1<<TIF_NOERROR)
>  #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
>  #define _TIF_UPROBE		(1<<TIF_UPROBE)
> -#define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
> -#define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
>  
>  #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>  				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
> -- 
> 2.51.0
> 
LGTM
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

