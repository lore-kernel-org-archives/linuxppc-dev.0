Return-Path: <linuxppc-dev+bounces-26785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1757C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 11:22:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfM4D3hwBz2y2b;
	Tue, 08 Sep 2026 21:22:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788866572;
	cv=none; b=nxL0KhTnfHqUzfPhTh8rwFaBYM2CoX/eYLA/M+S3YBuKJrYVm2aiiumYdj24WHMCRuenot2EQ9u6FN2qxZeILdMvJVKstY0lbd+/P69SBE73tMiw266QY3NOaaOPpKas7LZKlq9HUE4XvXgi0g+BemFDwldfTE89qpUkbjsgh6XiIsfltAO4TqX/FFVWsVD/L2jZSSvK2K1/52EQSIKHG7EzvYySvtm+K2MA4J7DXH5GMLI/DyiyhJOLxh8GiitCmXfMv9iM7q1rsFpS4d5IMh+dUFLnx2sfpP+MY/aONvwgY0jXsM6SkP6dD3S8uURG86rVUzRKkoqzC+ePc0h+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788866572; c=relaxed/relaxed;
	bh=/f3x8Z3givjt4IOINS3hmWB76mNz9OB3ZZIt4XHEaho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6HgaFKdwAweGybmk+DulRCyNTX+SzsDs5ugheJq/IBkrEfI1Un2id/QRj1zZ56p9D0z4sHcY+z3X4mHYt7Sl3xuaaEwnuU8cGjth3k8KWRDgSzjsXebr3ZH+KU1nsCGhx+cR9K3/eup2dvn+3GN+grH+MfzevWUgg6ePFpc/HRj1+kdVMrXMtIbvRDJaNwpyZTjq0sLE44C8BPbWQr1pMJKSq04sRLzxgHSLz/ibN/DBfq/MA/PzL4lPLFrc7ZdhwU/cpjut4mRXyteVXwpZ1T5vH5C8sO6ebyhI8E34SO/PEoQ2hqYRsQCDCguYdbd43de39GjRegaxtf6estxbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rNjnGdRG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rNjnGdRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfM4C0g1Mz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 21:22:50 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2db18e5cb56so41512195ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 04:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788866567; x=1789471367; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/f3x8Z3givjt4IOINS3hmWB76mNz9OB3ZZIt4XHEaho=;
        b=rNjnGdRGkYfgP99KxVrg7VDn94mZDGqqckcfVnyXj+p3pdZGQpfBfHVZtJKOiXZcWz
         dymydiup7KI/jW/7BjQ+FODMOsjCM4c75/VOEUzvasylzNWILY0SRTQg3dtRoZFROFUv
         YEYRkgwZmO5T4pFHixNx+7gsNa4aQl7Lhcqy3Kt1UUQpQFNstrhASxZOeP8x0dx0JpkE
         G5vJEQnLcVxZ8qHTJt9z0ZIXXEXbAoqnWHcQXomhQBE6k9CzsNTTW08r5jckVkKdyTKK
         37RsRivfaJTsIW/n+lIsptblmHQd5dvMqY+C7AM+K28M6rVlFa5oTAMFDP3jYNtLLGxe
         SyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788866567; x=1789471367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/f3x8Z3givjt4IOINS3hmWB76mNz9OB3ZZIt4XHEaho=;
        b=IulnONdql7J16khxOZJvbRwNwY+hXx1rShLYY3whLMzAcD2yk7DmVEHOAfH2/1isro
         lqmdG8kADc2I18YtjwQPxiJao3ZdlWXNTxDBrU+Y3LRaO+wqLpGlcb4GJSbTrE0ctITL
         XtsWmt+fEbFvXT+E5s90C2noAs37jV1xe3qN0lK9uDL/eBCmS9M2lfzNsOCCB2gl3Z8t
         DkqIe4su3dcoqS4dPedghiAGEHQJxo2voonzQFR/ta6uMnQEOnT3LEDcDZsd/vVzfsxS
         4/Z1bnHM6Hyuf1HK1p+dpBFntjGWjVZ6uAUHWOoCXfQHVjOOUu5QKqAtgtawIWq9tEon
         +HPA==
X-Forwarded-Encrypted: i=1; AKwUvBwW89NjTWzvcBI8ETxP8CQ6dKeggjMx/Ig+A17IxeM6I79LggOPtajifJAx956VUx8eq8ks7+EVHyppbUY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mAWb6lNO4urX00UjLObYnQgPGSTpHi3AyA6rFcxYl5zAtD1IK4
	qvIte7wUyR+BFTqWELLfmZ1rqUAlkgk7CT7YbZdUgUfMbPjYGJ9Yhecr
X-Gm-Gg: AYBFou1GESX0dddnaTomJE2IKmVI/kqsaNYPiGulRspEnoCcNDQwcvHH/isQdNzB8ZN
	dEn3z+baPO7djmdZqXBN9/6lrvvBbQZLq8VM4jnfWBYVU8d2WtphhPmba2gsGbYoxy3R43JFQZs
	SnY9GGzuBcvL9zG1beOPPV571EH/xgK+WO3Z42rdyfJbEMo/ZHsahdNZAwOZcrXX3sLFY2OmUDq
	QkwsLQ6E8kLI0J87RmxNiWG9LPrEd/YI+2dYSIEEyrgIyd44bA1t9HZQmn5TObg63QkIJJ7R5Yy
	Ary/agOfsJnbMa62ecyZH1ofCp5QmyglHSGlveBLyO197eqOJo637+crocj953zq5csQDk57TvK
	Rw2mNSGqBAQVWFrWMyV90yfcwqEkU75LzWtIITcc/6xbpYwSc0Y3jsubj6VAJTpLZsTqB+yL6q4
	3r8p/G7abo9NHuYijt+xC8cnyM22cZm1TKc0SGLFp2SAZeGD6QKxv7p3GAnjVVqdAoJPX2+1cZz
	qopTCSNXBLNM+lM3XzNkRU2cJWxKniH8fCu
X-Received: by 2002:a17:90b:3b46:b0:398:dcfe:967a with SMTP id 98e67ed59e1d1-39b2620a2ecmr40925181a91.17.1788866566728;
        Tue, 08 Sep 2026 04:22:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([122.161.53.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm41000804eec.7.2026.09.08.04.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:22:46 -0700 (PDT)
Date: Tue, 8 Sep 2026 16:52:32 +0530
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
Message-ID: <ap_vl6lyicTVWYrk@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
 <CAE4VaGACd2es4NPQyhbR9pMEoGiTVBSE7Lw7x9VOb1Qbpvc6nw@mail.gmail.com>
 <amsapeQ2Kp6rwPpF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE4VaGB_EhbWq8_X6FLtOx2MqoP7JEkOKkKSjKB7N--tt-sCeA@mail.gmail.com>

On Thu, Jul 30, 2026 at 01:24:46PM +0200, Jirka Hladky wrote:
> On Thu, Jul 30, 2026 at 11:36 AM Mukesh Kumar Chaurasiya
> <mkchauras@gmail.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 11:41:07AM +0200, Jirka Hladky wrote:
> > > Hi Mukesh, Shrikanth, Madhavan,
> > >
> > > I'm seeing a ~19% throughput regression on ppc64le (POWER10) in
> > > syscall-heavy workloads between kernel 7.1 and 7.2-rc4, which I've
> > > narrowed down to the GENERIC_ENTRY enablement for powerpc (commit
> > > bee25f97ad24 "powerpc: Enable GENERIC_ENTRY feature").
> > >
> > > The regression manifests specifically when SELinux is enabled. Regression
> > > disappears with selinux=0. With SELinux disabled, 7.2 is actually
> > > slightly *faster* than 7.1.
> > >
> > > Test: stress-ng --kill 1 -t 23 (single-thread kill() syscall loop)
> > > Machine: IBM,9080-HEX POWER10, 8 vCPUs (1 core SMT-8), 64 GiB
> > >
> > > Results (bogo-ops/sec, higher is better):
> > >
> > > Kernel   Enforcing   Permissive   Disabled    SELinux tax
> > > ------   ---------   ----------   --------    -----------
> > > 7.1      69,107      70,248       93,566      -26.1%
> > > 7.2-rc4  56,247      59,075       99,240      -43.3%
> > > Delta    -18.6%      -15.9%       +6.1%
> > >
> > > Key observations:
> > > - SELinux permissive ~ enforcing on both kernels (overhead is in the
> > >   code path, not policy evaluation)
> > > - SELinux disabled: 7.2 is 6% faster than 7.1 -- the generic entry
> > >   path itself is not slower for the base syscall
> > > - The SELinux "tax" nearly doubles from 26% to 43% between 7.1->7.2
> > > - No changes to security/selinux/avc.c between v7.1 and v7.2-rc4
> > >
> > > The kill() hot path (sys_kill -> check_kill_permission -> security_task_kill
> > > -> selinux_task_kill -> avc_has_perm -> avc_lookup) wraps every AVC lookup
> > > in rcu_read_lock()/rcu_read_unlock(). On ppc64le with PREEMPT_RCU, each
> > > pair requires lwsync/isync barriers. I suspect the generic entry path
> > > changes something in how context tracking, tracing, or RCU interacts
> > > with the syscall fast path that amplifies the per-call RCU cost.
> > >
> > > Note: this is on top of a separate ~36% regression from 6.12->7.1 caused
> > > by HAVE_PREEMPT_DYNAMIC_KEY enabling CONFIG_PREEMPT_RCU on ppc64le
> > > (commit 6ad7751537e8), which I reported separately on the v4 thread.
> > >
> > > Thank you
> > > Jirka
> > [...]
> > Hey Jirka,
> >
> > Thanks for reporting this.
> > I'll take a look.
> >
> > Thanks,
> > Mukesh
> >
> 
> Thank you, Mukesh! I'm happy to run additional tests on the POWER10 machine
> if you have patches to try or specific experiments you'd like me to do.
> 
> Jirka
> 

Hey Jirka,

Sry about the delayed response, i got occupied with functional issues.
Anyways, I don't seem to reproduce it with default fedora policy. Can
you share the details of policy which you are using?

Regards,
Mukesh

