Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F2606A31E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVVgbw5H;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=auAuvzFA;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVVgbw5H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBCLs0g1bz2xly;
	Sat, 24 Oct 2026 06:12:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792782725;
	cv=none; b=TGHRwgm4KtghlA3fpZ/u65JKbX3qxviMRzgwSceid/Bqc1Nd6ad7Meyw4gQxZe+1zJSFNge5I8E6Q7qK54Ex5ET7S+UGaZCGhaED3YNUwjS4G3lDRuZP290komu7erPlqtRr733ULSxwz7EMzLvGx5x53GvlhLnZAqzknB4sUQdsMtSAHq+GNy6r40g9xlwf/ZP3GHhAAP/JkvRq71y7aJatVrsyfLJosyLU1WThuNlGkWIKtsKMHs3Qby/O51dwlawvm3Ss9yEJeJi69VF+Ye+f6dahR+ufTGGD3m7L6TSW0sKPmZO1GW/5IWU3yz9E3Vy69odTAHuz3dETxJDUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792782725; c=relaxed/relaxed;
	bh=9I3nfi/zCxpfxBzYXDJ/rk4ur0A2HXnoooyC3zKal0U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DN2C/scnC4WpRW2bGiKPGJTt11k4DFxSieazASJMRynBYZyR8rhAU4NttluJT3OrgueXxfYthLmBbc1K/Gyk6Ly4x/Bx9BfrKWD6D2MfWT+knPG96lBAfbQ43yOWB9N9gGXk4wuEwcJYvpYC3GEa/dCfO3kaIPyLnXDEdFm10xl60KhQ6xm2jghHEmYYRowSv2NhRJjs0QNipx1gxS9gJZ1wzYOSmM+IFg84yg5C08O26QyVHUXDYWOn0WgjvR030576oEJjcIk+yt84I33PUpLPhU1Oes1n3lLF+xEvqv25jLxDo0TTCCsJKiGhQU71Ym6kIhQ9HiF36EyqKtuHzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVVgbw5H; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=auAuvzFA; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVVgbw5H; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVVgbw5H;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=auAuvzFA;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AVVgbw5H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBCLq5tm8z2xPB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 06:12:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792782718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I3nfi/zCxpfxBzYXDJ/rk4ur0A2HXnoooyC3zKal0U=;
	b=AVVgbw5HD9Alq0EhT+iF3WGmRyVJDwdJzhGzRnNH5SuQwUXXvOfoIV5fgKzzlqlL032UdY
	HARYnCkrP9pZ3aJJUJTVyTIe9f7MrmAE9PloNEpjGvDvjrs5QiUQsZcLnxdER6ATp0Q+pz
	a+OqsMf+3C9vLqsAwmHFhJb4HURGjuU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792782719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I3nfi/zCxpfxBzYXDJ/rk4ur0A2HXnoooyC3zKal0U=;
	b=auAuvzFARya+IcvO7QYyd+ShxwR6JzVMe7S9scFSkOzIbhR6h5kv6l0IfhVxOxbqYSaerX
	JTFGUFGdIx9NE1BKHDydURd9cXeFFDs/29zBFTOhyhJwRL/H+dioSBa3/CoHSThap3LT64
	nxUCm8InlKD+rYXD49sVFghmplhO0xQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792782718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9I3nfi/zCxpfxBzYXDJ/rk4ur0A2HXnoooyC3zKal0U=;
	b=AVVgbw5HD9Alq0EhT+iF3WGmRyVJDwdJzhGzRnNH5SuQwUXXvOfoIV5fgKzzlqlL032UdY
	HARYnCkrP9pZ3aJJUJTVyTIe9f7MrmAE9PloNEpjGvDvjrs5QiUQsZcLnxdER6ATp0Q+pz
	a+OqsMf+3C9vLqsAwmHFhJb4HURGjuU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-MXfVrn7DOzKnBUBqoRNOXA-1; Fri, 23 Oct 2026 15:11:57 -0400
X-MC-Unique: MXfVrn7DOzKnBUBqoRNOXA-1
X-Mimecast-MFC-AGG-ID: MXfVrn7DOzKnBUBqoRNOXA_1792782716
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a027f2e364so8555305e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 12:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782716; x=1793387516;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9I3nfi/zCxpfxBzYXDJ/rk4ur0A2HXnoooyC3zKal0U=;
        b=Krtjj1yh+8Qd//kvWWpIBj0AvaL0jn8j0drXOQPj9CftLMBxp+KViGwsbSz5vIMyke
         AlgioIY/JkGjzWjV1aPHMB0/nSw33d+L9QjRuomveFY+F/2ye3YlWrI7J+LjU8sHLx42
         GuSkVES6uRZpxFgJGqzPX7cE7RuDNCoR1ioByOhYAdwCcW/y4asHeFkvKCpJYcOZr3ud
         rPMwJakVAhNl9e5fqrpmp+hPSf0QER2QGoB95JhJqLVABaOUJal0gHEP8VneTqYa+SM9
         Y76YTn0FeGRZ52RGicofIepu7dMQQG65jzqs24DBJDRVuL018NkSw8xjoA9vYcb0bfuJ
         ZfOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxX3i7aN5NwRSxImg4wyC6KFusf+5kpBb23/leGkUVVGyUYnZi/Mkpsqd61GZof3ZF27BP/ue+ESragM2Y=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKRBJL0g5QRIgCcE8XwGVwjLDO6lo1vkctBm8WbNgJasQMI9lm+
	RrlAw83ivTeihgciGcWbrN8AbIRKfXqPY7WuAlC982PZSEyrqHRaXt9+u6+2bDQW7bC2cpHbono
	JKWRcXBHRlWHidzF5Up802KlRMXTPuboqhMrEgK8IqT0Kw8KZpaRU7Gj9aJDe2MSA66g=
X-Gm-Gg: AYBFou3xuuR5FI0skr8n7sfZL1D0mRrCeleMeGbUf+YHmCwqn1b7uAYdVohkfAN178D
	5O5qSF4a6cFxEqE1dNWcLkXiGjeV/GCO3N2Ly5AnBPcJWk9l/h+xvkdIv1M5gaD1FebLs7VVv58
	6uv/y9utvhLrz0bfOq7LHj1UilDDVxToz8TILFTN5jHZUrW/hf6bNVJ/v3AsKGokfabe9+LXsov
	zGbFTEUrQqxjRgw3Q+QtqViSxesG+mvNw9h5Jw+cu4zBMslY9EiB/1NhMWOlkzQi5r/LUtF/eAN
	wwMj/2xe0oAHprCG7W/92s/XzSCSrdq2QVQIbDWaj/Cvz02a84hXaG5J1QX9IByr2ny6VAb4D6k
	eyulV2Sknf62QKXBg04p3Lc2KrKPMaap5HNA7Qw==
X-Received: by 2002:a05:600c:a40f:b0:4a2:86b7:b76e with SMTP id 5b1f17b1804b1-4a286b7b9eamr16884405e9.13.1792782715761;
        Fri, 23 Oct 2026 12:11:55 -0700 (PDT)
X-Received: by 2002:a05:600c:a40f:b0:4a2:86b7:b76e with SMTP id 5b1f17b1804b1-4a286b7b9eamr16884135e9.13.1792782715275;
        Fri, 23 Oct 2026 12:11:55 -0700 (PDT)
Received: from [192.168.0.29] (ip-89-102-207-131.bb.vodafone.cz. [89.102.207.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d41cef8sm2011003f8f.45.2026.10.23.12.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 12:11:54 -0700 (PDT)
Message-ID: <d9660f99-c230-4107-a89c-c62e0b3e7f03@redhat.com>
Date: Fri, 23 Oct 2026 21:11:52 +0200
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
User-Agent: Mozilla Thunderbird
From: Jerome Marchand <jmarchan@redhat.com>
Subject: Re: [PATCH] powerpc: Use raw_local_irq_pmu_save/restore() in local_t
 functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261023155529.3895393-1-jmarchan@redhat.com>
 <20261023130943.775b2b65@gandalf.local.home>
In-Reply-To: <20261023130943.775b2b65@gandalf.local.home>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YPPO1tQN1rjKH8hH6X0m9IeWBBJEPuwsvWLAPcXKobI_1792782716
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 19:09, Steven Rostedt wrote:
> On Fri, 23 Oct 2026 17:55:29 +0200
> Jerome Marchand <jmarchan@redhat.com> wrote:
> 
>> On ppc64 with CONFIG_TRACE_IRQFLAGS enabled, the ring buffer code can
>> enter in an infinite recursion loop.
>>
>> The problem occurs because some PowerPC's local_t operations
>> (local_inc/dec in particular) use powerpc_local_irq_pmu_save/restore()
>> which call trace_hardirqs_on/off() to generate trace events. This
>> creates a recursion loop:
>>
>>    ring_buffer_unlock_commit()
>>      rb_commit()
>>        local_inc(&cpu_buffer->entries)
>>          powerpc_local_irq_pmu_save()
>>            trace_hardirqs_off()
>>              trace event => ring_buffer_unlock_commit()
>>                [INFINITE RECURSION]
> 
> Hmm, the ring buffer has recursion protection that should prevent this. My
> question is, why didn't that work? Yes, I agree with the patch to not have
> local_inc/dec() call anything that can be traced, but if this caused an
> infinite recursion, there's a bug in the ring buffer code I want fixed too.
> 
> The ring buffer has a trace_recursive_lock() that will allow one level of
> recursion and then prevents new commits from happening. The
> trace_recursive_unlock() is called after the rb_commit(). Why did the
> rb_commit() allow an infinite recursion?
> 
> -- Steve

I might have jumped to conclusion when I found the recursion and the
peculiarity of the powerpc local_t functions. I now think that the issue
lie in loop in powerpc arch_local_irq_restore() (goto again label). That
somehow it keeps replaying the soft interrupt when event tracing is on
and CONFIG_TRACE_IRQFLAGS is enabled.

Here the output of the watchdog where we can see that most time is spent
in softirq:

[257154.724054] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:107460]
[257154.724084] CPU#2 Utilization every 4000ms during lockup:
[257154.724099] 	#1:   0% system,	100% softirq,	  1% hardirq,	  0% idle
[257154.724120] 	#2:   0% system,	100% softirq,	  1% hardirq,	  0% idle
[257154.724141] 	#3:   0% system,	100% softirq,	  1% hardirq,	  0% idle
[257154.724161] 	#4:   0% system,	100% softirq,	  2% hardirq,	  0% idle
[257154.724182] 	#5:   0% system,	100% softirq,	  1% hardirq,	  0% idle
[257154.724203] Modules linked in: bonding tls rfkill binfmt_misc pseries_rng ibmveth vmx_crypto vsock_loopback zram vmw_vsock_virtio_transport_common vsock lz4hc_compress ibmvscsi scsi_transport_srp fuse i2c_dev aes_gcm_p10_crypto crypto_simd cryptd
[257154.724399] irq event stamp: 0
[257154.724410] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[257154.724471] hardirqs last disabled at (0): [<c0000000002b04b8>] copy_process+0x1418/0x34e0
[257154.724516] softirqs last  enabled at (0): [<c0000000002b04b8>] copy_process+0x1418/0x34e0
[257154.724558] softirqs last disabled at (0): [<0000000000000000>] 0x0
[257154.724621] CPU: 2 UID: 0 PID: 107460 Comm: cat Tainted: P        W           7.2.0-rc4 #1 PREEMPT(lazy)
[257154.724654] Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN
[257154.724665] Hardware name: IBM,8247-22L POWER8 (architected) 0x4b0201 0xf000004 of:IBM,FW860.81 (SV860_215) hv:phyp pSeries
[257154.724688] NIP:  c00000000004f50c LR: c00000000004fc84 CTR: 0000000000000000
[257154.724708] REGS: c0000003affdfa68 TRAP: 0900   Tainted: P        W            (7.2.0-rc4)
[257154.724727] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24082800  XER: 00000000
[257154.724819] CFAR: 0000000000000000 IRQMASK: 0
[257154.724819] GPR00: 0000000000000004 c0000003affdfa30 c000000003c8be00 c0000003affdfa38
[257154.724819] GPR04: 0000000000000000 0000000000000000 c0000003affdfc08 0000000000000000
[257154.724819] GPR08: 0050244d39e48235 0000000000000049 fffffffffffffffc 0000000000000002
[257154.724819] GPR12: c000000000669520 c00000002ec9df00 c0000000060bbd40 c00000000453e200
[257154.724819] GPR16: c000000006d66b80 c000000004366af0 c00000000280b940 0000000000000007
[257154.724819] GPR20: c000000006d61100 0000000000000007 c000000024832600 0000000000000103
[257154.724819] GPR24: 0000000000160003 c00000000c573400 0000000000b5240f c00000000e555fe8
[257154.724819] GPR28: c00000000e53e108 0000000000000000 fcffffffffffffff c00000002ec9df00
[257154.725212] NIP [c00000000004f50c] __replay_soft_interrupts+0x6c/0x5f0
[257154.725255] LR [c00000000004fc84] arch_local_irq_restore.part.0+0x1f4/0x290
[257154.725299] Call Trace:
[257154.725309] [c0000003affdfa30] [c00000000004f6dc] __replay_soft_interrupts+0x23c/0x5f0 (unreliable)
[257154.725369] [c0000003affdfc30] [c00000000004fc84] arch_local_irq_restore.part.0+0x1f4/0x290
[257154.725423] [c0000003affdfc70] [c0000000006946dc] rb_commit+0x50c/0x620
[257154.725468] [c0000003affdfcf0] [c0000000006992cc] ring_buffer_unlock_commit+0x6c/0x3c0
[257154.725514] [c0000003affdfd40] [c0000000006ae9c8] trace_buffer_unlock_commit_regs+0x118/0x2a0
[257154.725569] [c0000003affdfda0] [c0000000006aec74] trace_event_buffer_commit+0x124/0x3e0
[257154.725623] [c0000003affdfe10] [c0000000002cae68] trace_event_raw_event_softirq+0xb8/0x170
[257154.725675] [c0000003affdfe90] [c0000000002cc964] handle_softirqs+0x864/0xc00
[257154.725725] [c0000003affdffe0] [c00000000001cd1c] do_softirq_own_stack+0x5c/0x90
[257154.725777] [c000000040b279e0] [c00000000001cce4] do_softirq_own_stack+0x24/0x90
[257154.725827] [c000000040b27a10] [c0000000002c9ff8] __irq_exit_rcu+0x458/0x560
[257154.725876] [c000000040b27a60] [c0000000002cd72c] irq_exit+0x2c/0x90
[257154.725924] [c000000040b27a90] [c00000000004fc88] arch_local_irq_restore.part.0+0x1f8/0x290
[257154.725978] [c000000040b27ad0] [c0000000006942b0] rb_commit+0xe0/0x620
[257154.726021] [c000000040b27b50] [c0000000006992cc] ring_buffer_unlock_commit+0x6c/0x3c0
[257154.726067] [c000000040b27ba0] [c0000000006ae9c8] trace_buffer_unlock_commit_regs+0x118/0x2a0
[257154.726122] [c000000040b27c00] [c0000000006aec74] trace_event_buffer_commit+0x124/0x3e0
[257154.726175] [c000000040b27c70] [c000000000527c4c] trace_event_raw_event_sys_exit+0xcc/0x180
[257154.726222] [c000000040b27cf0] [c00000000052837c] trace_syscall_exit+0xec/0x1e0
[257154.726266] [c000000040b27d70] [c0000000000440e8] syscall_exit_prepare+0xce8/0xde0
[257154.726315] [c000000040b27e30] [c00000000000d6ac] system_call_common+0x16c/0x2c4
[257154.726368] ---- interrupt: c00 at 0x7fff9f08f8b0
[257154.726421] NIP:  00007fff9f08f8b0 LR: 00007fff9f070a20 CTR: 0000000000000000
[257154.726440] REGS: c000000040b27e60 TRAP: 0c00   Tainted: P        W            (7.2.0-rc4)
[257154.726458] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24000802  XER: 00000000
[257154.726582] IRQMASK: 0
[257154.726582] GPR00: 000000000000007d 00007fffca534fd0 00007fff9f0b7f00 0000000000000000
[257154.726582] GPR04: 0000000000010000 0000000000000001 0000000000000000 00007fff9f0b0b40
[257154.726582] GPR08: 000000000005edb0 0000000000000000 0000000000000000 0000000000000000
[257154.726582] GPR12: 0000000000000000 00007fff9f0ba580 00000001359c09b8 0000000000000000
[257154.726582] GPR16: 00007fff9f0b3580 0000000080001000 00007fff9f0984c8 00007fffca535420
[257154.726582] GPR20: 00007fff9f0b0b40 0000000000000000 00502449f00961a6 00007fff9f0b0cc8
[257154.726582] GPR24: 0000000000000000 00007fff9f0b0cd0 00007fff9f0afbe8 fffffffffffffff8
[257154.726582] GPR28: 0000000000000000 000000000002fd2d 00007fff9f0b12f0 00007fffca535000
[257154.726956] NIP [00007fff9f08f8b0] 0x7fff9f08f8b0
[257154.727011] LR [00007fff9f070a20] 0x7fff9f070a20
[257154.727063] ---- interrupt: c00
[257154.727075] Code: 39200000 48178df1 60000000 7dbf6b78 386d0933 48b427e9 60000000 893f0933 38610038 61290040 993f0933 481176d1 <60000000> e9210140 7dbe6b78 386d0933

Regards,
Jerome


