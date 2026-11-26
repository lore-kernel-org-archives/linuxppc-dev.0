Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9992606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSbUHHYH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZlG42nYMz2yDD;
	Thu, 26 Nov 2026 16:19:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795670348;
	cv=none; b=GOiNQA+PVr6S/PsgKf4QqUBEGDUdcoBuV4wEbUpj2mgiesqhdiThSDB9IUaGhoC6YjmRUsu6UUKPf2BG2Sf6RfaANrXIIYiLC/wVlbekKblYyiU7kQZi36DuLgkdI2h3wH8dZRFjvhtkyb73/rOZNK5rTI1IavnsSonh1pgLmB1+P8NKUELgjwo4gNH7+HGs0Y9xe4GfeLbgvmJeH4yXk4sWKz/oGOxqzHKqjZEWZJhe3y76iNkj6l8+RKpvIUNYAJ83PwhJAe3ZumKXIKnOHW4p8osmyJViv0RQx0xVji65pNVILRifFhvFJexu2HzaCpvIJ3P9ZDO7li/H1UKIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795670348; c=relaxed/relaxed;
	bh=SmGwW+D3JztXCRa1pJ0AYwGqb4CeC20tVUU8LlpmFso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwndP/Zmpr3IxKnchkDz57YAzgC91XQjgd8wrOc3UG0C2HWXtVUlnf6Cjk39juy0XW/5tKrlDDTI7SYfA2ZDP6D+80ZkqG4hJyQya1aDYs1doArf9XWDcC5jJX6SOojx2PmAYVz1D2YdqAtH1cHFB7aXBYi4d9kq4J10rG1MZ/jIQpa6z64QwPeQCagjLxk6+Hyv8Wv9darlX1XhNCPR6F4TPlRSfkiM8ecyO4MeQSgBGJ7t3rylWaHGkXWefDi3SfrNz/l20fG/aCfbmPY2Uz4e42vQ6PuwYUzB7kHotZovRDPBXsp7Ja8lKLhxUBg5j1DSHkAHkUzPNXggHclqkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSbUHHYH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tSbUHHYH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZlG306fsz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 16:19:06 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-89d6bd67045so3106208b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 21:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670343; x=1796275143; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmGwW+D3JztXCRa1pJ0AYwGqb4CeC20tVUU8LlpmFso=;
        b=tSbUHHYHwBdTYNkhBcOvyfD9HQJYt1K3VmiUPXM1dkTCj4NAl1jqD85pThmoRcdFd4
         sR7Dqeuhrfdc4C9K3k3M5Ghtvmna24A7Seuf/bzvLK5OWrxKejhzMvT12L3v9l1iIMZ4
         vhz5oyDKl7NSXlFKjAgOGRCJRsLnge46Wu49heGHCuzBl3PE1w3jolP83AFTykEH9CKt
         gwnsbghHqsaw10ceLLmBnCQfeDq7kFsCvnK9AwW5W7SG4uoB9ILLWvyHCy49gALynWJI
         Bm6nhQSXqaU4PjsnrzkFpGglhqaNefHoHmxq1lYnqnjdsvpHYCBeBHWNajZQRAeXmNKY
         WAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670343; x=1796275143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmGwW+D3JztXCRa1pJ0AYwGqb4CeC20tVUU8LlpmFso=;
        b=rQOxPPCSGDG4hHhcdZTiWoTCPBhTNjyKWqblfRY/tvrzEutf7oMB9v2H+sM0mtnrIe
         +OBoJdPAdgpogrsD0KIztrywbeOLmkiizvnIxcUZgpkqf8Pnb3CvCL2SQ8giNrJGFdPF
         uxn1rhYAV9RWNdaC30pac16EG2IZFjhaPp4N9lUhzrBXwJJu6YyvPyGBD/Ua92mrOZDa
         hUC7MQQlWZgbf7Jnom7BSqM/p6mbrPqu/n2lyRr036YJAEHEj3j9S2k9SwYsVxKMnCqQ
         fnQhaurhN1bufPn8+aRP7I3dihx/zyQNJXaareYBR/yaxcafXq6BUh5hvD+wOlGV73xb
         DT+g==
X-Gm-Message-State: APuU4Z/vPz2/lsMRt9PEZoGpSAPH6asny218ywMyFehpv24nUnh+Pkr9
	TG/s608mK0jyWVT9rP2mWX1dtjoFvok/67slY9936qb/p7tVFgqq54vf
X-Gm-Gg: AZFdTZeFTwlgs97ITZIarUacf+2Q/f2hnPACQPFaUiT6Dx+Hsa9Qewp54ksRHzSelWT
	ljEWHESPU/wFkPX0bslQq4b8hsIQwZZ+GiDLnPLX+B3Knd5FGky2RWhWrBbVYPpQinYHzX7urXj
	bmV98SDDuwoiC7TUMG/hCV+HZVYHcR4dkEO8Aajqy+9aJ6OA6zTHbIGP+pjV9NjE6W8DedNr+Gz
	weoghDE4HoiLZGdN7A2H7eZTrB+Mt6Jvkf2bL76UIV5ynnz1autxRSgAti3BebBaGtkW/85FaDZ
	h+ztMJm5Zx7IQWZLn5BConscMC4PV/ByhRsA2cSYTfnIXXH8P8sw5XmzTRnbCY3hAgrdub+P1qT
	ZATdZygV1Ia8RsL73ONdBL1dNsS2rUqkoitTpVCZO/iaqntteV6ARqkp10mgaeZkwM1tJRd/cGr
	7aY3GYFQYjQe5A3HfZ/YZPw+8+8bWjC/poKc2mQiZKLxrQ1AwWA2nFR9eK2fGLS1yIQSZ9CnKqW
	XpcwrHOgLcy/h4P80wteKaxoHs4O/Z1KvStsfAPaEro8cq9yE5iZsQczgu/lU1hmhNvU4lCgyHV
	FD240Rgyh0in1zLPypzegYVqHKwh4zD26lzA2T8iZJbPwgcigSOkSZBjQLL3QhdYZfhcKNgYZqZ
	bN9t6dgQfaQ89mGDr8BToYA==
X-Received: by 2002:a05:6a00:3c92:b0:89e:db6c:f199 with SMTP id d2e1a72fcca58-8c87c57b613mr11322869b3a.14.1795670343036;
        Wed, 25 Nov 2026 21:19:03 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.50.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45756sm10149403b3a.27.2026.11.25.21.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:19:02 -0800 (PST)
Date: Thu, 26 Nov 2026 10:48:56 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, chleroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv4 2/4] powerpc/watchdog: Disable preemption in
 arch_touch_nmi_watchdog()
Message-ID: <awfBNN6hpOHXS13M@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <cover.1795603946.git.ritesh.list@gmail.com>
 <fb07a250216a733b064f8eec672f9e682c3660d8.1795603946.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb07a250216a733b064f8eec672f9e682c3660d8.1795603946.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 04:56:04PM +0530, Ritesh Harjani (IBM) wrote:
> touch_nmi_watchdog() can be called from preemptible context, e.g.
> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
> smp_processor_id(), so with DEBUG_PREEMPT we get:
> 
>   root@buildroot:/# echo w > /proc/sysrq-trigger
>   sysrq: Show Blocked State
>   BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>   caller is arch_touch_nmi_watchdog+0x3c/0xd4
>   CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>   Call Trace:
>    dump_stack_lvl+0x138/0x150 (unreliable)
>    check_preemption_disabled+0x120/0x158
>    arch_touch_nmi_watchdog+0x3c/0xd4
>    show_state_filter+0xf0/0x338
>    sysrq_handle_showstate_blocked+0x24/0x38
>    __handle_sysrq+0x134/0x3a8
>    write_sysrq_trigger+0x178/0x22c
>    proc_reg_write+0xf4/0x150
>    vfs_write+0xfc/0x71c
>    ksys_write+0x8c/0x150
>    system_call_exception+0x310/0x590
>    system_call_vectored_common+0x15c/0x2ec
>   ---- interrupt: 3000 at 0x7ffd01755b98
> 
> Unlike the generic version, which only sets a flag, we update the CPU's
> timebase stamp and its SMP watchdog pending bit, so a migration in
> between touches the state of a CPU we are no longer on.
> 
> Disable preemption across the update to fix this.
> 
> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
> Cc: stable@vger.kernel.org
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/kernel/watchdog.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 44f178e07531..1a8514b2d853 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -459,9 +459,13 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  void arch_touch_nmi_watchdog(void)
>  {
>  	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
> -	int cpu = smp_processor_id();
> +	int cpu;
>  	u64 tb;
>  
> +	/* Callers may be preemptible. Stay on this CPU for the update. */
> +	guard(preempt_notrace)();
> +	cpu = raw_smp_processor_id();
> +
>  	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>  		return;
>  
> -- 
> 2.39.5
> 

LGTM 

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

