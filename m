Return-Path: <linuxppc-dev+bounces-27586-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0A3C982D6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:10:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm11d3BFGz2y2W;
	Fri, 18 Sep 2026 02:10:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789661413;
	cv=none; b=a1mNe/X4bq6qWRo4fVDXDIYExdSwzvuEUyGvPwltfBwRUw5kJmk88GXpAHVo0rBMtSH+7fVGGS5fGAotJazZRadzvSnVIzOEjR1O6PlL9efOI3LZg5WHuoUlldwbeB84RfvQT8lIiNEt2vmD9KiI5sx6xrTu8o7bpSf5Lfh2KpUn9iwfWO0mfeBU6g2Jz3C7Hi42X0ncnr/fCAZA8Lx+y4i/VyA2rZ9RtqiDC4QMiFi63XAfmJCSJkTzWR6U9CZVpFrqrXH1b76pLdQY6l9sQtKL434S4TGtN9/Q1cHo4z7WYISUs7D7f/K+TpVjxyit2hQ5Pv0nWRx8Qw0OR4jmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789661413; c=relaxed/relaxed;
	bh=PovAW1yhJdf58+Zr5M8cxohYcmOHlAy4fb+9VSn+dn0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lmqoF5zBnXrYHzPpbOnB/ThXqQhvvVkTFiu4K5O41rTQHdlIemCsBfmV15H85aG1ZjoXAfG4rivY7jyc0ET2aLgmzE8hXYTI8TlJadBf7k2A8qrVswAwXmmV5RJ4Uf16ZQ73jOg4T4+hXwSU7FZEL6A6xF1SukQ936dQY8T/jiXBCe8uvcq8ib4Mu35wNMcE3B+Uh2Zd397WxPE0aJ9r76TpeB5cTVTOI3DhwzxAWxjzbgHmykcD2UuP335yaSZ829Gcohfw/CXlKU9q3VHYw8+R9WYO2T1sjsuqYFq2RXqJN8/27t/Bv2xDNPt0I1iLLfZZj0/uMC9YqQiuqTfAhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LFOBkSzA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::e; helo=mail-qk2-x0e.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LFOBkSzA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:34::e; helo=mail-qk2-x0e.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x0e.google.com (mail-qk2-x0e.google.com [IPv6:2607:f8b0:4864:34::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm11c3f9lz2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:10:12 +1000 (AEST)
Received: by mail-qk2-x0e.google.com with SMTP id d75a77b69052e-52fb769ca17so8107051cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789661410; x=1790266210; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PovAW1yhJdf58+Zr5M8cxohYcmOHlAy4fb+9VSn+dn0=;
        b=LFOBkSzAzoWlTkJPQOdVZEE94uyBIpK+nAX/Z4d5tbBGon1CYw2A+SEZEmqEn2Vb3e
         OTGpDvEYsy3hb301RCk6Y9rSjYK3gvvzA5big+Wd1az4EljlJI960SKrrBvunYjDYYM6
         uFrQWEUNyPyorRkkBEBwSfdFTmCK4DM1E9ecqkFUeE/3NLZEM5m8IX7DxkqS6s/P3+GP
         u+UcB+ZGnKd23ws1BA2hcacBM5gtVy9xE9bj8n+BHfpkcf0oT4egzYWTzvCV+W0LmrPa
         ar3RE09yiT2i8upWz/WmiXMuEP1NDSjq4NdM+ogQdK6PiJRW/U0CdF0pycAH9tkly0qQ
         z4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661410; x=1790266210;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PovAW1yhJdf58+Zr5M8cxohYcmOHlAy4fb+9VSn+dn0=;
        b=AArJ4NSbDGpXKzfzgm5VmVE8d2Z6lZbYDzO1YxDCU1DrhHbmLqUtm/x/JB8fkPqr0W
         LR2yiY4sib3Hp7I0+o074IKjuDC0hgRyVVoFcLWG+ZJUeA+03/l3zToiRfi1ldpZRpBb
         LC1tsqn9dc+GgDWAtrkv/KCrOP1gSEsPrckcAb6W6jqidrK8WYRoBmOVf1qErqPcbAmY
         q1Z11TksPQcmvUyeYB70zrj42Ll1uFhlGTXMvMNbRIWW+i4KYUI0hR+Hm0189WAMXYLp
         hMEpuf/geA9ND933yLP4y5xvDWtvLhMNd8YW40Csbess/Zu23KLHx3Py2HHUggr097Rr
         kh/g==
X-Forwarded-Encrypted: i=1; AKwUvBx0eKdKBDp/9R2oL7MYMyr+SpQ0G9bzuhfCQquDUintpOLudSemT4IgyUCMTfIopjqRi3P8aDlg+3/nUPs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lgyWbBmw2lOSr3ImLi9h1H899a39ip+nbSMU/z+z9jHb0icl7P
	P2jsHcdK1ma5BH0WSO9f80qevq7AZWLHmHY5IJaLKsVFYpXVYvxCbkB+n2mG9Hdc9g==
X-Gm-Gg: AYBFou33ebV7i1BvVSeu39nQUsCKx3GuCsc8ZFVyPby2xVAfq3bfaOiOb2f5KAq3bAZ
	V7VfbpvOhazJtA5G360kLmBdkRfsInp/23U8RqCrBv0ZpiZ/jloPiMv8w/cndN1yTvqc1+PtGKV
	Y0MOv2VaPpAfvzWccMjAtMsDpUmQLdGbIqrgIy4ejjvYh+wHx7aXv1bZ4kc0g6URDsdS9JkTQZW
	dR4egC/93ZPFg/3biEzBTH+FFfWJke9RlOYddpFWFi6+jFrCEIjXc0GDLgM2p03zqBKvCPUPpvn
	E+js2k610R6WszHgda35D6/KTg15XfKW9aOLKPVOdrNa6/nRFi0iE4xaGz4W+OL8lh3VHvAl7db
	PbA+CGrA1prQjtnZUlCGpzc7oSiL2mVHfPRKugpBTO6UaqBGC+5AlZfniQZTZ5aAAotOzhEZCV9
	7UBXmnbAE3m4YzXV4lLr1Bx0PrBppRQR7uNJTFosFiWtGajbPSft7xgATVUXdY1biUzTx7R7b3+
	C1xnRArcgmTIwII3b+2BmKtWxLjVyI8312WSrE/
X-Received: by 2002:ac8:7d44:0:b0:52f:b1b6:a4aa with SMTP id d75a77b69052e-5327edf9c51mr125939161cf.4.1789661409717;
        Thu, 17 Sep 2026 09:10:09 -0700 (PDT)
Received: from [10.99.118.151] ([72.159.227.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532620dc734sm54943111cf.30.2026.09.17.09.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:10:08 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf <bpf@vger.kernel.org>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, <audit@vger.kernel.org>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, <yonghong.song@linux.dev>, <tglx@kernel.org>, <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 12:10:06 -0400
Message-ID: <1a0b021e330.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
 <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net>
 <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
User-Agent: AquaMail/2.7.0 (build: 200700061)
Subject: Re: [BUG] audit/powerpc: WARNING at kernel/auditsc.c:1995 (__audit_syscall_entry) during BPF kselftests (test_progs)
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
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

[NOTE: correcting the audit mailing list address to audit@vger ...]

On September 17, 2026 12:06:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On September 17, 2026 10:03:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> Hi Venkat,
>>
>> On 9/17/26 3:01 PM, Venkat Rao Bagalkote wrote:
>>> Hi all,
>>>
>>> IBM CI has reported a kernel warning triggered in __audit_syscall_entry()
>>> on a PowerPC 64 (ppc64le, POWER9 pSeries guest) system while running the
>>> BPF kselftest suite (test_progs).
>>>
>>> Environment:
>>>
>>>
>>> Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
>>> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
>>> Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)
>>>
>>>
>>> Problem Description:
>>>
>>>
>>> During syscall entry processing (system_call_exception ->
>>> syscall_enter_audit -> __audit_syscall_entry), the kernel hit
>>> WARN_ON(context->context != AUDIT_CTX_UNUSED) at kernel/auditsc.c:1995,
>>> indicating that the task's audit context was not reset to AUDIT_CTX_UNUSED
>>> prior to entering the new syscall.
>>
>> Hm, based on the trace feels somewhat unrelated to bpf, but were you able
>> to bisect in
>> case it can be reliably reproduced? Which tree is this, linux-next or
>> bpf/bpf-next?
>
> Thanks for the report Venkat.
>
> Unfortunately due to some unexpected family medical issues I'm not able to
> look into this very closely at the moment (triaging mail on my phone), but
> the related audit code has been fairly stable lately so it seems a bit odd.
>
> I do know that Thomas Gleixner (CC'd) did some work recently on the syscall
> entry code (audit related commit below), perhaps that may be a place to start?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f25517010ddd3f8080d7e06b9b1cb1b64b73772
>
> FWIW, I haven't seen this in any of my testing on x86 or ARM, have you seen
> this on other arches besides Power? Also, as Daniel already mentioned, more
> information on the tree would be helpful.
>
> While I don't have access to a Power system, I'm CC'ing Ricardo Robaina who
> also works at IBM/RH and has experience with the audit kernel code. If this
> appears to be specific to Power, he might be a good resource to help
> diagnose and develop a patch.
>
>>
>>> Trace:
>>>
>>>
>>> [ 1371.387510] ------------[ cut here ]------------
>>> [ 1371.387528] WARNING: kernel/auditsc.c:1995 at
>>> __audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
>>> [ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) reed_solomon(E)
>>> livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) mrp(E) stp(E) llc(E)
>>> veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E)
>>> nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
>>> nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E)
>>> hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) drm(E) fuse(E)
>>> drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) nvme_tcp(E) sd_mod(E)
>>> cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E)
>>> scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
>>> [last unloaded: bpf_test_modorder_x(OE)]
>>> [ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G
>>> OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
>>> [ 1371.387616] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
>>> [ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202
>>> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
>>> [ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR:
>>> c00000000000cf00
>>> [ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      OE K
>>> (7.3.0-rc3-g238650ef6c7c)
>>> [ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48002824
>>> XER: 20040084
>>> [ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
>>>       GPR00: c000000000034958 c00000000beafd40 c0000000020eb200 c0000000345f4800
>>>       GPR04: 00007fffe2a31184 0000000000000081 000000007fffffff 0000000000000000
>>>       GPR08: 0000000000000000 0000000000000001 0000000000000001 00000000000000dd
>>>       GPR12: 0000000000000000 c00000002e99b300 0000000000000000 0000000000000000
>>>       GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>       GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>       GPR24: 0000000000000000 0000000000000000 0000000000000000 c0000000345f4800
>>>       GPR28: 0000000000000000 00000000000000dd 00000000000000dd c000000138e0c000
>>> [ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1b0
>>> [ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
>>> [ 1371.387722] Call Trace:
>>> [ 1371.387725] [c00000000beafd40] [c000000000937050]
>>> selinux_task_getpgid+0x80/0xa0 (unreliable)
>>> [ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beafde0
>>> [ 1371.387741] [c00000000beafe00] [c000000000034958]
>>> system_call_exception+0x448/0x480
>>> [ 1371.387749] [c00000000beafe50] [c00000000000d05c]
>>> system_call_vectored_common+0x15c/0x2ec
>>> [ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0
>>>
>>>
>>> Please let me know if additional logs, config, or repro details are needed.
>>>
>>> Regards,
>>>
>>> Venkat.

--
paul-moore.com




