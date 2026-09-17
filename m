Return-Path: <linuxppc-dev+bounces-27576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F4C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlyd72nwjz2y8G;
	Fri, 18 Sep 2026 00:22:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789654939;
	cv=none; b=IKsCNb0lkhvN4lWq6RDJGMeARzpNDYZOU2OHAM9FM3ZrsfPkw3t8AIGHnxqSxelrBUPGpKiDesx78DzwlNl/zABxu0P46Cw9RCSTOSKGruH3luDYKi6xkkIIcV8jrdogjRWhhLURWvS2ejjzQbR8GEoH4MH1ESztLqCvPm+YJUphrWlmj++THPbt6fwZlCJZTqWr+RQvq+MUbj9ziHOg4nJxkXUA0hbYvzLzF/HUGDeqTuB9BKV+u/i/34BDFsGmiKuZKzrCDz+l0P168L8oZK0rpU9Y5saN4bVeMcZbIQ4+qgW9bKMshM6cTO2ft2EWmZU7ohzG6AS66wg5UboMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789654939; c=relaxed/relaxed;
	bh=UPwTOvFl1CpeOQIPZjQ5syX2TgH3pKHZm+Fy4Zqxb5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSPGOqjXv7WhOQnsYomgBYNNekQJO3VmZ8Ra3ugZelv2BoZbwYLJ3ja2qmcdBqw6Z2B2adusIK+cSbcpvDB0km8Tsz2Z/SjnxmhjGW5bLw8x0i3xxpHsj8/gmYvbx5QZnYtgRcMjQ3DmrqlzSVHbyIenLJQugfB/gA/YvEuSFzhvp+ubXsSWvahjhyi1UBdOOuTEpKNiG2rBq7PCa7GOIjhZ6Pj9/IbPM1YwkToBh2vgdtvgnOgOHbg58auUn78/1DQWxGTOOT162si4F4UKK8kzylZvf/dhVs33v1J+jSc+Tnll0N29gOadvB15CXKuDla0/Eh/oxUeppVJVBf15g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; dkim=pass (2048-bit key; unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=e7H8tqML; dkim-atps=neutral; spf=pass (client-ip=213.133.104.62; helo=www62.your-server.de; envelope-from=daniel@iogearbox.net; receiver=lists.ozlabs.org) smtp.mailfrom=iogearbox.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=e7H8tqML;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iogearbox.net (client-ip=213.133.104.62; helo=www62.your-server.de; envelope-from=daniel@iogearbox.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 1085 seconds by postgrey-1.37 at boromir; Fri, 18 Sep 2026 00:22:14 AEST
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlyd22KtGz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 00:22:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UPwTOvFl1CpeOQIPZjQ5syX2TgH3pKHZm+Fy4Zqxb5A=; b=e7H8tqML48cZr2bz33jaFvWPda
	MwCHa1RbFAi4N3+VoS/IGjLzAzgQPxd8qX9JzZvAsOHetGOtGLFqjP+Lsm3ZzJyMu26uNGFQN2psR
	yFFd8j4twMHcC0SluCuygqFejlO1dFAAAUhdyaI0LTMNTfAkTm/hBaoqlBcTWN+kvG7QS7rLNXpIK
	/mPEdofpvLpNj6slrPeDpoWxH1iejlSTZCIK6DsVVE6X25bT4Dvk9/tekubKCAby9t/mFXcrOkZwf
	HV/ug/BO/fkfAEfyY81EnyCOx8hl4ow54A6tzLRKJoKxb1svcu+gAcc901m3QGd4YaXWk5m7HK1GJ
	0aKImrlg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x7CiR-0008RH-1D;
	Thu, 17 Sep 2026 16:03:55 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1x7CiQ-000HY2-03;
	Thu, 17 Sep 2026 16:03:54 +0200
Message-ID: <73701ffd-213e-4842-8b40-f719c1eeaed4@iogearbox.net>
Date: Thu, 17 Sep 2026 16:03:53 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] audit/powerpc: WARNING at kernel/auditsc.c:1995
 (__audit_syscall_entry) during BPF kselftests (test_progs)
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 linux-audit@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Ritesh Harjani <riteshh@linux.ibm.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Saket Kumar Bhaskar <skb99@linux.ibm.com>,
 Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, andrii@kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>, yonghong.song@linux.dev
References: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <ff563467-0bab-43ec-a46c-a4167bc12473@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28126/Thu Sep 17 08:24:16 2026)

Hi Venkat,

On 9/17/26 3:01 PM, Venkat Rao Bagalkote wrote:
> Hi all,
> 
> IBM CI has reported a kernel warning triggered in __audit_syscall_entry() on a PowerPC 64 (ppc64le, POWER9 pSeries guest) system while running the BPF kselftest suite (test_progs).
> 
> Environment:
> 
> 
> Kernel version: 7.3.0-rc3-g238650ef6c7c (PREEMPT)
> Architecture: ppc64le (POWER9 - IBM,8375-42A pSeries / phyp)
> Workload: BPF selftests (tools/testing/selftests/bpf/test_progs)
> 
> 
> Problem Description:
> 
> 
> During syscall entry processing (system_call_exception -> syscall_enter_audit -> __audit_syscall_entry), the kernel hit WARN_ON(context->context != AUDIT_CTX_UNUSED) at kernel/auditsc.c:1995, indicating that the task's audit context was not reset to AUDIT_CTX_UNUSED prior to entering the new syscall.

Hm, based on the trace feels somewhat unrelated to bpf, but were you able to bisect in
case it can be reliably reproduced? Which tree is this, linux-next or bpf/bpf-next?

> Trace:
> 
> 
> [ 1371.387510] ------------[ cut here ]------------
> [ 1371.387528] WARNING: kernel/auditsc.c:1995 at __audit_syscall_entry+0x50/0x1b0, CPU#17: test_progs/49616
> [ 1371.387539] Modules linked in: dm_verity(E) dm_bufio(E) reed_solomon(E) livepatch_sample(EK) tun(E) vrf(E) 8021q(E) garp(E) mrp(E) stp(E) llc(E) veth(E) bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E) hvcserver(E) pseries_rng(E) vmx_crypto(E) sg(E) drm(E) fuse(E) drm_panel_orientation_quirks(E) xfs(E) sr_mod(E) nvme_tcp(E) sd_mod(E) cdrom(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E) [last unloaded: bpf_test_modorder_x(OE)]
> [ 1371.387607] CPU: 17 UID: 0 PID: 49616 Comm: test_progs Tainted: G        OE K     7.3.0-rc3-g238650ef6c7c #1 PREEMPT
> [ 1371.387616] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
> [ 1371.387620] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
> [ 1371.387626] NIP:  c0000000003e70d0 LR: c000000000352080 CTR: c00000000000cf00
> [ 1371.387631] REGS: c00000000beafaa0 TRAP: 0700   Tainted: G      OE K     (7.3.0-rc3-g238650ef6c7c)
> [ 1371.387637] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48002824  XER: 20040084
> [ 1371.387650] CFAR: c00000000035207c IRQMASK: 0
>                 GPR00: c000000000034958 c00000000beafd40 c0000000020eb200 c0000000345f4800
>                 GPR04: 00007fffe2a31184 0000000000000081 000000007fffffff 0000000000000000
>                 GPR08: 0000000000000000 0000000000000001 0000000000000001 00000000000000dd
>                 GPR12: 0000000000000000 c00000002e99b300 0000000000000000 0000000000000000
>                 GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                 GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                 GPR24: 0000000000000000 0000000000000000 0000000000000000 c0000000345f4800
>                 GPR28: 0000000000000000 00000000000000dd 00000000000000dd c000000138e0c000
> [ 1371.387710] NIP [c0000000003e70d0] __audit_syscall_entry+0x50/0x1b0
> [ 1371.387715] LR [c000000000352080] syscall_enter_audit+0x90/0xd0
> [ 1371.387722] Call Trace:
> [ 1371.387725] [c00000000beafd40] [c000000000937050] selinux_task_getpgid+0x80/0xa0 (unreliable)
> [ 1371.387735] [c00000000beafda0] [c00000000beafde0] 0xc00000000beafde0
> [ 1371.387741] [c00000000beafe00] [c000000000034958] system_call_exception+0x448/0x480
> [ 1371.387749] [c00000000beafe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> [ 1371.387757] ---- interrupt: 3000 at 0x7fffab74cbf0
> 
> 
> Please let me know if additional logs, config, or repro details are needed.
> 
> Regards,
> 
> Venkat.


