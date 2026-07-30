Return-Path: <linuxppc-dev+bounces-25086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CB8C54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 09:36:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9kc83q07z2yYd;
	Thu, 30 Jul 2026 19:36:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785404200;
	cv=none; b=iJLohXE7D7SYZPW0TNF29hKtsbC/x0OpIZm+H5KPrTa0yxDrXD7Yo01z76v+lURdjGr0//099cYVtK/gBezhLXQjZ1N5f8VRxAuuK8DtbhFPe+qr3j46nlI2O++tP6EA4wAvA+Z+Ni766Z44qI3GAJkr8yWD9F8jNc+QMXZzQ+H/bsmsUxyfCu85ewr/8rB5z3YIIfcAl4Mt1lhEgdovE5TU+Kb4U/WyC5qOHqw4b9ZFLytlTXgGo4qbvhiYZRSe1ilJFHRl1ZcXhZpWIJab5cdv8tuiu9OQ1wseJsxN2AyWiKJP8PaWBOXnNLbuVoEBK55Ob6Uq2MpUiuIOQsbzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785404200; c=relaxed/relaxed;
	bh=JpATujKSDQr05JABAqg0NJi4p/t7GtODSZVncN5pOMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVbM6Hno7mEcW00CIYH4yFdiPVbhU9zI+b4UuK+NqDAfZlMOyYgsIU8O7Eix7Nix2+MKJH4e9bM9gdwdDKHnG3DttdCWLmLWp/rtfqG3UVAz07ensvdQWqZpFFtE8KgQs0TOZmAgDb4hVti9syzORFhcXAGLsVahAFHHK9ZAgfl9Q7SgdnhrudqDggqdaQSpc3MC8UbvJs/3P+vvpeqzgrYe8L92fgnvUddwddlW3SQgpLyyzLWvvkZ+VgLRKLzUAmVTE8eQYDBtM+iU6PyD+lZLhCzxbmkqcznOR7JAH13wp3Yve0d1+jpPgbu+/WBVQGV+NYECeSqbDXUlvuxRww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayxT2CY9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayxT2CY9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9kc712JNz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 19:36:38 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-8487088510aso2005426b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785404196; x=1786008996; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JpATujKSDQr05JABAqg0NJi4p/t7GtODSZVncN5pOMo=;
        b=ayxT2CY9kTLS064N5zL7wbPPCj8XiKUab/awiMKoZ/EHwZAurdeW0bUYjyjb7otQoO
         /pekV9JBtvZuA+fxlCdw4okzUK8C7Lll0c8TrVRwnPylQsaX3nwrjz44cCHqyS9wruTM
         UlOPdKuEW2XKWjc1ez29NrzGUi8t/vDBv4KAsi5fBd12vGzb/khu9cXKmDLFtSvOSZpf
         J9mi+V+sXt7DSRZtcAkOE2IrnBH9ZDmhaStBoe6AjV3/PJLpOC1HU6i9G8S+7kzkZQ47
         nOOYKUyFt4QfPOme5qHhr36EhN35w01ZTuENTT6I2z1V+kAOz8DhQFwg2cAtWtCv0WbI
         SO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785404196; x=1786008996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JpATujKSDQr05JABAqg0NJi4p/t7GtODSZVncN5pOMo=;
        b=p6n73uwg9A7iSSS/WEcrKfemwkdr+8wvs3c0RwomMObZni6KEzCRN0fUpWulqw2Xz3
         AHHA3gMhF8TVzvd9uaXurUSnmT4EoA7skDXb71EOSY20wWEiHHh6TbPPXHEx2kllA8Jk
         QWXxpkKpX83i/ae9e3wcXqYQA7GKNB/hU9w/1MnMX918UND9inje34NKVYFawrrq6YDm
         SZnTMD68QyyDI7jRILopiS0/q8Uj5EkJzRqtdrRGBSojKXJR82lbDPJEi2N4uj+kk56Y
         lx17bzMMLu9PR1tFf4QlvHw7lz6/DbInywPYY1n6pf5lkVgCOW8lXngsKLIoWZlTA/A7
         Iwqg==
X-Forwarded-Encrypted: i=1; AHgh+RqxMlV91FKqNQ9l2u81IHjv/yUGc8RLd7YdC/wakmmVrL/Q3VR40XOCzNF4X0epMEGa9JCOic56ncKkFhg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzPoK4EiNopmW4pTN4m3ttBbapdC6GLrxc7fKxkz6EuP7W474wF
	Qnue1iyibpDwfa8aIG89k+FTxVbITs7GAz8EZ1wW05j1jUXbd6cahbwc
X-Gm-Gg: AR+sD12nU7eQ4mld7g6FAN3hdSp4eSIsvqvWK7RNi7wbfjA+2FRISzBJEvSgIqd4PTe
	40ffR5qeVnTdfwpSTj1uH4wf3mWOK5dwwtf7odNVLjveziF2fyg1U5lHKurbj1p1mtmcfsDH6yZ
	Hbdln6MvVh94dsjlhsMPwzwypNxCXOJQzcbkW6Ysd4Jv9FEc6N4zoseWDBvaOvCfo1pQzCpPDbz
	EQSW7qhBnQJy03QP35kE5dSO9whoEFLa9Dp/a9ox46dY3+ohjVvdP6Qg0n83EER4tp+lnCaBCcr
	GPAbOOD0K90XK3JQf7hmHFJKYQ45fOJhXCjvVwnKIiia8qvz1Sp/VuWQC/fHYFT0ujmftQvFyIe
	IY28ZNAGc5Mzv9Hgt9CyMSRfut33C2xrBTNkz2Bq60SOgMMJt+kPyhDGBHnK+HfmGrWyhT0nXyq
	d3Xbi9ggwQ6PIdwSUIxM6tE/bCQytSlz2IzGdKrrTDk9l/hgtd5nPCsYvY19DU4M3oemdKbQN3N
	YIUAcjyt2WStCPqniDbLwpmhUx7BmZT90ZxhmbErEINfCYo/p8M7pg=
X-Received: by 2002:a05:6a00:182a:b0:848:6c9c:4074 with SMTP id d2e1a72fcca58-84ebc1eab5cmr2094648b3a.1.1785404195711;
        Thu, 30 Jul 2026 02:36:35 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03d0675sm2754047b3a.61.2026.07.30.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:36:35 -0700 (PDT)
Date: Thu, 30 Jul 2026 15:06:23 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jirka Hladky <jhladky@redhat.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, oleg@redhat.com, kees@kernel.org, 
	luto@amacapital.net, wad@chromium.org, mchauras@linux.ibm.com, sshegde@linux.ibm.com, 
	thuth@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, 
	macro@orcam.me.uk, ldv@strace.io, charlie@rivosinc.com, deller@gmx.de, 
	kevin.brodsky@arm.com, ritesh.list@gmail.com, yeoreum.yun@arm.com, 
	agordeev@linux.ibm.com, segher@kernel.crashing.org, mark.rutland@arm.com, 
	ryan.roberts@arm.com, pmladek@suse.com, feng.tang@linux.alibaba.com, 
	peterz@infradead.org, kan.liang@linux.intel.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v5 0/8] Generic IRQ entry/exit support for powerpc
Message-ID: <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
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
In-Reply-To: <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>

On Mon, Jul 27, 2026 at 11:41:07AM +0200, Jirka Hladky wrote:
> Hi Mukesh, Shrikanth, Madhavan,
> 
> I'm seeing a ~19% throughput regression on ppc64le (POWER10) in
> syscall-heavy workloads between kernel 7.1 and 7.2-rc4, which I've
> narrowed down to the GENERIC_ENTRY enablement for powerpc (commit
> bee25f97ad24 "powerpc: Enable GENERIC_ENTRY feature").
> 
> The regression manifests specifically when SELinux is enabled. Regression
> disappears with selinux=0. With SELinux disabled, 7.2 is actually
> slightly *faster* than 7.1.
> 
> Test: stress-ng --kill 1 -t 23 (single-thread kill() syscall loop)
> Machine: IBM,9080-HEX POWER10, 8 vCPUs (1 core SMT-8), 64 GiB
> 
> Results (bogo-ops/sec, higher is better):
> 
> Kernel   Enforcing   Permissive   Disabled    SELinux tax
> ------   ---------   ----------   --------    -----------
> 7.1      69,107      70,248       93,566      -26.1%
> 7.2-rc4  56,247      59,075       99,240      -43.3%
> Delta    -18.6%      -15.9%       +6.1%
> 
> Key observations:
> - SELinux permissive ~ enforcing on both kernels (overhead is in the
>   code path, not policy evaluation)
> - SELinux disabled: 7.2 is 6% faster than 7.1 -- the generic entry
>   path itself is not slower for the base syscall
> - The SELinux "tax" nearly doubles from 26% to 43% between 7.1->7.2
> - No changes to security/selinux/avc.c between v7.1 and v7.2-rc4
> 
> The kill() hot path (sys_kill -> check_kill_permission -> security_task_kill
> -> selinux_task_kill -> avc_has_perm -> avc_lookup) wraps every AVC lookup
> in rcu_read_lock()/rcu_read_unlock(). On ppc64le with PREEMPT_RCU, each
> pair requires lwsync/isync barriers. I suspect the generic entry path
> changes something in how context tracking, tracing, or RCU interacts
> with the syscall fast path that amplifies the per-call RCU cost.
> 
> Note: this is on top of a separate ~36% regression from 6.12->7.1 caused
> by HAVE_PREEMPT_DYNAMIC_KEY enabling CONFIG_PREEMPT_RCU on ppc64le
> (commit 6ad7751537e8), which I reported separately on the v4 thread.
> 
> Thank you
> Jirka
[...]
Hey Jirka,

Thanks for reporting this.
I'll take a look.

Thanks,
Mukesh

