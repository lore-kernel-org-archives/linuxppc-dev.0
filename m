Return-Path: <linuxppc-dev+bounces-27583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE84C982D6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm0xG5ljPz2y2W;
	Fri, 18 Sep 2026 02:06:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789661186;
	cv=none; b=Ft0muW+jSVBllgOaTBDYRntNUaHx5b+s6iJ0FNjVB2bwNgPCXrDNg2P9xhPiydUPMbJmUmz0VG57st877Aqp5lOk+XM0zDyyZHlHpuXyKS0fkMxGNjXWzr14XlRWkkqn+aQaCieWGeuxTe4cVi2QwYT/c+IbnqSfb1p6SIxyYynWj3B6XTXNn6XGQdeMOOeKspdiIKjtKzKHkl+I/Qtrvc2bEEwvPzS6m2HkiyAymtvUgiGd1SQ72N5xpioAEu0YsBNAdH5LHy7d/CHWkEuL1noEeUIl/Je8ZXtd2Dg8BfzoZTtzKo4t4bWDdHyMoxP9t7eCB8ceEeO3fL28hQvMaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789661186; c=relaxed/relaxed;
	bh=Zb/rJ/ij4dBANOQDlvdvkPcPAUB1WlQ7k+q4Vg9N9w0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ngWtIc8J6SQU1CFJvdl56C8Gs2bZFQ4fO+c1n9rp1DErVI07Vosuh3sSxy5zzpOAjbyZV0geNTblN5gZ+DFoj9K2bv5pe4X5B5VCFiwAk0Hzj3IyKvp5OFmOmePL4ZCSqt4zAgaMAIbdDJ3CqjR8pxUF1S9eKsY88QGvHd9eGCZrwJ4ib1bToTYLKU3p6P5TnC9LGRqp//WFCXDtaiQ/mJnyyXc5ROWlaMnxfVJwMsLmlGRN5o95AbFqAgLb7wijBE058mystuOksRRUnoua21AiQaMKR7aq5pUPaRLMFOHpTYRi5ZHwE72CYwgiNU/3KNy0NJCqgbAQiilCZW/Byg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Bek5eDwh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Bek5eDwh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm0xF4nwwz2xSR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 02:06:25 +1000 (AEST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-93a10f9a2easo85813585a.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789661181; x=1790265981; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zb/rJ/ij4dBANOQDlvdvkPcPAUB1WlQ7k+q4Vg9N9w0=;
        b=Bek5eDwh23lOptGyYR0rojUD0zClrTmr3PoaxG8nanmm5SYtRtIEv9Yb7uaRIrRRPp
         Sf7t0TyF/DcAyy5hcPtSRSNMzD101blk10M7mQDZurKB3bTz+ugqrHvsE4/9BL950YuM
         pK5Y1zDoM7BvtcIaH4i95EOS4GzM9m94g/M6US7DEHQutMTbgsDaOgUPm8zij+f8PY/v
         UJcDszL5sO6xyoySgxgx2+T45ww2K/38Wf++/8M8aZ9H/1InNLA94JKnAF1+vkxj1Umh
         s+Fjg+2NpPKbhGpHbat4+pSwq962NOqhtnZSH+E61LjV0iem0Km2t2qSyBHA9AjpBCQX
         pP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789661181; x=1790265981;
        h=content-transfer-encoding:content-type:mime-version:subject
         :user-agent:references:in-reply-to:message-id:date:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zb/rJ/ij4dBANOQDlvdvkPcPAUB1WlQ7k+q4Vg9N9w0=;
        b=eARKHrcmNfls1BzhCkzSnADEfz6AWQhcCY5HzqnK34z7e2q4g2ThjyHDBAUyrYclP0
         q6ePO70IcbIRPGoBytTL8PHjZo0Z9olgQz4+RIiFwBPPmmIiGUTzgIGkbdq50n1jB2dZ
         +9z4tlzke9OpC0D2xEH3+0cEuEawubEYF0YW5xsYBLDsXYZwar9eYbZlUUfIlGQAJhcY
         dXy9De4tPFT51tL4lQeaSRlyIW+86RZ4w4y2PZimoa9RHNC4b+lC+AJtSR3a5Fs/dha1
         5ApIDv4G19o4mbc6c5MTv6peScaTzuDSSSg/lHsFc56mR7jxj5oWux6uzInAyvru1IjC
         I0/A==
X-Forwarded-Encrypted: i=1; AKwUvBxKX+obif9vZ7v1GlftIGJBhpJD/m0+O/M+zKgqo4dq0grzuyfaTPtFKkQVzqFPOY+ibWIvDuazSRyW1nA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kLJjFM4UP0mXP4Y+vDi8qNHoQ/3YSfRbCybB3kS0twgQ68GnTo
	TxeCaLAsNH+9znIL0gReBhcerMRrtJgege+lmutb2otcIotdJq108P23MmC2jC2cUA==
X-Gm-Gg: AYBFou2BNMhTbSjPBXMy/pWL4zcOx6ECZJBxmgZdSlAWwxfsZV1hnFBxpBCsGllMf/P
	BD7FgftxHilB63cHjVhRs9zsrtxMtXognaC1InFRf6kFqHvl8dk4+Y6GqqOw93WlqLzaQ7wR9fz
	ugH6zI1Iw3mJs9dUyZqQ1gicRuTV+7TOjkJ2SCqPUVYkJcxj2aDH0BpisR97GfwP8xYwHuZSWKm
	nlH8X82iXgfgxC6lXKn9snOzBs5DLnlpl60aFMoHc3EH8vjgS5+CMlrZ6E3kbol6priOoA8ec6C
	6gAnIlNTDxO24b+u+Dk0NsEcKASEGbIL9BVsbOa3UFX8UkWfMrC4sp4z5T6xfFi6dmyKWMXmXkP
	VZBuHfR4aXr4OAanXJJt0GU3Z6B/dMuBRnsoNKjgIiCjkmWA9U/n0yaj+6koiqgHBKqtHzUrH+G
	0VFEXFZS1bIuAdu36J2ubUhQ7pHvYJZ89y4vwoCjVJxjzrxPTg4SR3e9MD4H6xSxrmQWlWLbCzk
	9RLcbA0CPljHgb0IUvpgk/h0s4LAWCYGItYXLuf
X-Received: by 2002:a05:620a:600d:b0:939:3f4f:7254 with SMTP id af79cd13be357-93bc62a52eamr546059185a.14.1789661179793;
        Thu, 17 Sep 2026 09:06:19 -0700 (PDT)
Received: from [10.99.118.151] ([72.159.227.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81cefa3bsm493113685a.34.2026.09.17.09.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 09:06:18 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf <bpf@vger.kernel.org>, <linux-audit@vger.kernel.org>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Ritesh Harjani <riteshh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, <yonghong.song@linux.dev>, <tglx@kernel.org>, <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 12:06:15 -0400
Message-ID: <1a0b01e5cd8.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net>
References: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
 <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net>
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

On September 17, 2026 10:03:59 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Hi Venkat,
>
> On 9/17/26 3:01 PM, Venkat Rao Bagalkote wrote:
>> Hi all,
>>
>> IBM CI has reported a kernel warning triggered in __audit_syscall_entry() 
>> on a PowerPC 64 (ppc64le, POWER9 pSeries guest) system while running the 
>> BPF kselftest suite (test_progs).
>>
>> Environment:
>>
>>
>> Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
>> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
>> Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)
>>
>>
>> Problem Description:
>>
>>
>> During syscall entry processing (system_call_exception -> 
>> syscall_enter_audit -> __audit_syscall_entry), the kernel hit 
>> WARN_ON(context->context != AUDIT_CTX_UNUSED) at kernel/auditsc.c:1995, 
>> indicating that the task's audit context was not reset to AUDIT_CTX_UNUSED 
>> prior to entering the new syscall.
>
> Hm, based on the trace feels somewhat unrelated to bpf, but were you able 
> to bisect in
> case it can be reliably reproduced? Which tree is this, linux-next or 
> bpf/bpf-next?

Thanks for the report Venkat.

Unfortunately due to some unexpected family medical issues I'm not able to 
look into this very closely at the moment (triaging mail on my phone), but 
the related audit code has been fairly stable lately so it seems a bit odd.

I do know that Thomas Gleixner (CC'd) did some work recently on the syscall 
entry code (audit related commit below), perhaps that may be a place to start?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6f25517010ddd3f8080d7e06b9b1cb1b64b73772

FWIW, I haven't seen this in any of my testing on x86 or ARM, have you seen 
this on other arches besides Power? Also, as Daniel already mentioned, more 
information on the tree would be helpful.

While I don't have access to a Power system, I'm CC'ing Ricardo Robaina who 
also works at IBM/RH and has experience with the audit kernel code. If this 
appears to be specific to Power, he might be a good resource to help 
diagnose and develop a patch.

>
>> Trace:
>>
>>
>> [ 1371.387510] ------------[ cut here ]------------
>> [ 1371.387528] WARNING: kernel/auditsc.c:1995 at 
>> __audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
>> [ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) reed_solomon(E) 
>> livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) mrp(E) stp(E) llc(E) 
>> veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E) 
>> nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) 
>> nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E) 
>> hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) drm(E) fuse(E) 
>> drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) nvme_tcp(E) sd_mod(E) 
>> cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E) 
>> scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E) 
>> [last unloaded: bpf_test_modorder_x(OE)]
>> [ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G        
>> OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
>> [ 1371.387616] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
>> [ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 
>> 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
>> [ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR: 
>> c00000000000cf00
>> [ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      OE K     
>> (7.3.0-rc3-g238650ef6c7c)
>> [ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48002824  
>> XER: 20040084
>> [ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
>>               GPR00: c000000000034958 c00000000beafd40 c0000000020eb200 c0000000345f4800
>>               GPR04: 00007fffe2a31184 0000000000000081 000000007fffffff 0000000000000000
>>               GPR08: 0000000000000000 0000000000000001 0000000000000001 00000000000000dd
>>               GPR12: 0000000000000000 c00000002e99b300 0000000000000000 0000000000000000
>>               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>               GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>               GPR24: 0000000000000000 0000000000000000 0000000000000000 c0000000345f4800
>>               GPR28: 0000000000000000 00000000000000dd 00000000000000dd c000000138e0c000
>> [ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1b0
>> [ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
>> [ 1371.387722] Call Trace:
>> [ 1371.387725] [c00000000beafd40] [c000000000937050] 
>> selinux_task_getpgid+0x80/0xa0 (unreliable)
>> [ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beafde0
>> [ 1371.387741] [c00000000beafe00] [c000000000034958] 
>> system_call_exception+0x448/0x480
>> [ 1371.387749] [c00000000beafe50] [c00000000000d05c] 
>> system_call_vectored_common+0x15c/0x2ec
>> [ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0
>>
>>
>> Please let me know if additional logs, config, or repro details are needed.
>>
>> Regards,
>>
>> Venkat.

--
paul-moore.com




